import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'kitchen_order_store.dart';

/// LAN HTTP server hosted by the kitchen app (POS posts orders here).
class KitchenLocalServerService {
  KitchenLocalServerService();

  static const int defaultPort = 18200;
  static const _prefsLanIpKey = 'kitchen_last_lan_ip';
  static const _androidIpChannel = MethodChannel('com.flovix.kitchen/local_ip');

  HttpServer? _server;
  int _port = defaultPort;
  String? _lanIp;
  List<String> _candidateIps = const [];
  StreamSubscription<HttpRequest>? _sub;
  bool _discoveryComplete = false;

  bool get isRunning => _server != null;
  int get port => _port;
  String? get lanIp => _lanIp;
  List<String> get candidateIps => List.unmodifiable(_candidateIps);
  bool get discoveryComplete => _discoveryComplete;

  /// Prefer a real LAN IP. Fall back to loopback so UI is never stuck.
  String get displayBaseUrl {
    final ip = _lanIp;
    if (ip == null || ip.isEmpty) {
      return 'http://127.0.0.1:$_port';
    }
    return 'http://$ip:$_port';
  }

  bool get hasUsableLanIp =>
      _lanIp != null && _lanIp!.isNotEmpty && !_isLoopback(_lanIp!);

  Future<void> start({
    int port = defaultPort,
    int maxAttempts = 8,
  }) async {
    await stop();
    await refreshLanIp();

    Object? lastError;
    StackTrace? lastStack;

    for (var attempt = 0; attempt < maxAttempts; attempt++) {
      final tryPort = port + attempt;
      try {
        _server = await HttpServer.bind(
          InternetAddress.anyIPv4,
          tryPort,
          shared: true,
        );
        _port = tryPort;
        _sub = _server!.listen(_handleRequest);
        if (tryPort != port) {
          debugPrint(
            '[KitchenServer] port $port busy — bound to $tryPort instead',
          );
        }
        debugPrint(
          '[KitchenServer] listening on http://0.0.0.0:$tryPort '
          '(LAN: $displayBaseUrl, candidates: $_candidateIps)',
        );
        if (!hasUsableLanIp) {
          unawaited(_retryLanIpDiscovery());
        }
        return;
      } on SocketException catch (e, st) {
        lastError = e;
        lastStack = st;
        if (!_isAddressInUse(e)) {
          debugPrint('[KitchenServer] failed to start: $e');
          debugPrint('$st');
          rethrow;
        }
        debugPrint(
          '[KitchenServer] port $tryPort in use, retrying '
          '(${attempt + 1}/$maxAttempts)…',
        );
        await Future<void>.delayed(Duration(milliseconds: 120 * (attempt + 1)));
      } catch (e, st) {
        debugPrint('[KitchenServer] failed to start: $e');
        debugPrint('$st');
        rethrow;
      }
    }

    debugPrint('[KitchenServer] failed to start: $lastError');
    if (lastStack != null) debugPrint('$lastStack');
    Error.throwWithStackTrace(
      lastError ??
          StateError('Kitchen local server failed to bind near port $port'),
      lastStack ?? StackTrace.current,
    );
  }

  static bool _isAddressInUse(SocketException e) {
    final code = e.osError?.errorCode;
    return code == 98 ||
        code == 48 ||
        code == 10048 ||
        (e.message.toLowerCase().contains('address already in use'));
  }

  Future<void> _retryLanIpDiscovery() async {
    for (var i = 0; i < 5; i++) {
      await Future<void>.delayed(Duration(milliseconds: 800 * (i + 1)));
      await refreshLanIp();
      if (hasUsableLanIp) {
        debugPrint(
          '[KitchenServer] LAN IP resolved after retry: $displayBaseUrl',
        );
        return;
      }
    }
  }

  Future<void> stop() async {
    await _sub?.cancel();
    _sub = null;
    await _server?.close(force: true);
    _server = null;
  }

  Future<void> refreshLanIp() async {
    final ips = await _discoverLanIps();
    _candidateIps = ips;
    if (ips.isNotEmpty) {
      _lanIp = ips.first;
      await _cacheLanIp(ips.first);
    } else {
      // Wi‑Fi off at boot — reuse last known LAN IP so UI isn't blank.
      final cached = await _readCachedLanIp();
      if (cached != null) {
        _lanIp = cached;
        _candidateIps = [cached];
        debugPrint('[KitchenServer] using cached LAN IP $cached');
      } else {
        // Last resort: local loopback so chip shows a real address.
        _lanIp = '127.0.0.1';
        _candidateIps = const ['127.0.0.1'];
        debugPrint(
          '[KitchenServer] no network interface — falling back to 127.0.0.1',
        );
      }
    }
    _discoveryComplete = true;
    debugPrint(
      '[KitchenServer] refreshLanIp → lanIp=$_lanIp '
      'candidates=$_candidateIps display=$displayBaseUrl',
    );
  }

  static Future<void> _cacheLanIp(String ip) async {
    if (_isLoopback(ip) || _isLinkLocal(ip)) return;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_prefsLanIpKey, ip);
    } catch (_) {}
  }

  static Future<String?> _readCachedLanIp() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final ip = prefs.getString(_prefsLanIpKey);
      if (ip == null || ip.isEmpty || _isLoopback(ip) || _isLinkLocal(ip)) {
        return null;
      }
      return ip;
    } catch (_) {
      return null;
    }
  }

  static Future<List<String>> _discoverLanIps() async {
    final candidates = <_LanIpCandidate>[];

    void addCandidate({
      required String ip,
      required String interfaceName,
      required _LanInterfaceKind kind,
    }) {
      final trimmed = ip.trim();
      if (trimmed.isEmpty || _isLoopback(trimmed) || _isLinkLocal(trimmed)) {
        return;
      }
      if (trimmed.contains(':')) return;
      if (candidates.any((c) => c.ip == trimmed)) return;
      candidates.add(
        _LanIpCandidate(
          ip: trimmed,
          interfaceName: interfaceName,
          kind: kind,
        ),
      );
    }

    // 0) Android native — works with Wi‑Fi OFF + Ethernet/USB/hotspot ON.
    for (final row in await _androidNativeIps()) {
      final transport = (row['transport'] ?? 'other').toLowerCase();
      addCandidate(
        ip: row['ip'] ?? '',
        interfaceName: row['interface'] ?? transport,
        kind: switch (transport) {
          'ethernet' => _LanInterfaceKind.ethernet,
          'hotspot' => _LanInterfaceKind.lan,
          'wifi' => _LanInterfaceKind.wifi,
          'cellular' => _LanInterfaceKind.other,
          _ => _LanInterfaceKind.lan,
        },
      );
    }

    // 1) Dart OS interface list.
    try {
      final interfaces = await NetworkInterface.list(
        includeLinkLocal: true,
        includeLoopback: false,
        type: InternetAddressType.IPv4,
      );
      debugPrint(
        '[KitchenServer] interfaces: '
        '${interfaces.map((i) => '${i.name}=${i.addresses.map((a) => a.address).join("|")}').join(", ")}',
      );
      for (final iface in interfaces) {
        final name = iface.name.toLowerCase();
        if (_shouldSkipInterface(name)) continue;
        for (final addr in iface.addresses) {
          if (addr.type != InternetAddressType.IPv4) continue;
          addCandidate(
            ip: addr.address,
            interfaceName: name,
            kind: _classifyInterface(name),
          );
        }
      }
    } catch (e) {
      debugPrint('[KitchenServer] NetworkInterface.list failed: $e');
    }

    // 2) Wi‑Fi plugin (null when Wi‑Fi is off — expected).
    await _ensureNetworkInfoPermission();
    try {
      final info = NetworkInfo();
      final wifiIp = await info.getWifiIP();
      debugPrint('[KitchenServer] getWifiIP=$wifiIp');
      if (wifiIp != null) {
        addCandidate(
          ip: wifiIp,
          interfaceName: 'wifi',
          kind: _LanInterfaceKind.wifi,
        );
      }

      final gateway = await info.getWifiGatewayIP();
      debugPrint('[KitchenServer] getWifiGatewayIP=$gateway');
      if (gateway != null && gateway.isNotEmpty && !_isLoopback(gateway)) {
        final viaGateway = await _probeLocalIpViaHost(gateway);
        if (viaGateway != null) {
          addCandidate(
            ip: viaGateway,
            interfaceName: 'gateway-route',
            kind: _LanInterfaceKind.lan,
          );
        }
      }
    } catch (e) {
      debugPrint('[KitchenServer] network_info_plus failed: $e');
    }

    // 3) Route probe.
    final probed = await _probeOutboundLocalIp();
    if (probed != null) {
      addCandidate(
        ip: probed,
        interfaceName: 'route',
        kind: _LanInterfaceKind.lan,
      );
    }

    // 4) Desktop CLI fallbacks.
    for (final ip in await _platformCommandIps()) {
      addCandidate(
        ip: ip,
        interfaceName: 'cli',
        kind: _LanInterfaceKind.lan,
      );
    }

    candidates.sort((a, b) {
      final kindCmp = a.kind.priority.compareTo(b.kind.priority);
      if (kindCmp != 0) return kindCmp;
      return _privateLanScore(a.ip).compareTo(_privateLanScore(b.ip));
    });

    final deduped = <String>[];
    for (final c in candidates) {
      if (!deduped.contains(c.ip)) deduped.add(c.ip);
    }

    debugPrint(
      '[KitchenServer] LAN candidates: '
      '${candidates.map((c) => '${c.ip}(${c.interfaceName}/${c.kind.name})').join(', ')}',
    );
    return deduped;
  }

  static Future<List<Map<String, String>>> _androidNativeIps() async {
    if (!Platform.isAndroid) return const [];
    try {
      final raw = await _androidIpChannel.invokeMethod<List<dynamic>>(
        'getLocalIpv4Addresses',
      );
      if (raw == null) return const [];
      return [
        for (final item in raw)
          if (item is Map)
            {
              for (final e in item.entries) '${e.key}': '${e.value}',
            },
      ];
    } catch (e) {
      debugPrint('[KitchenServer] Android native IP channel failed: $e');
      return const [];
    }
  }

  static Future<void> _ensureNetworkInfoPermission() async {
    try {
      if (Platform.isAndroid || Platform.isIOS || Platform.isMacOS) {
        final location = await Permission.locationWhenInUse.status;
        if (!location.isGranted) {
          await Permission.locationWhenInUse.request();
        }
      }
      if (Platform.isAndroid) {
        try {
          final nearby = await Permission.nearbyWifiDevices.status;
          if (!nearby.isGranted) {
            await Permission.nearbyWifiDevices.request();
          }
        } catch (_) {}
      }
    } catch (e) {
      debugPrint('[KitchenServer] permission request failed: $e');
    }
  }

  static Future<String?> _probeOutboundLocalIp() async {
    const probes = <(String, int)>[
      ('192.168.1.1', 80),
      ('192.168.0.1', 80),
      ('192.168.100.1', 80),
      ('10.0.0.1', 80),
      ('8.8.8.8', 53),
      ('1.1.1.1', 53),
    ];

    for (final probe in probes) {
      final ip = await _probeLocalIpViaHost(probe.$1, port: probe.$2);
      if (ip != null) return ip;
    }
    return null;
  }

  static Future<String?> _probeLocalIpViaHost(
    String host, {
    int port = 80,
  }) async {
    try {
      final socket = await Socket.connect(
        host,
        port,
        timeout: const Duration(milliseconds: 600),
      );
      final ip = socket.address.address;
      await socket.close();
      if (!_isLoopback(ip) && !_isLinkLocal(ip) && !ip.contains(':')) {
        debugPrint('[KitchenServer] probed local IP $ip via $host:$port');
        return ip;
      }
    } catch (_) {}
    return null;
  }

  static Future<List<String>> _platformCommandIps() async {
    final found = <String>[];
    try {
      if (Platform.isMacOS) {
        for (final iface in ['en0', 'en1', 'en2', 'en3', 'en4', 'en5', 'en6']) {
          final result = await Process.run('ipconfig', ['getifaddr', iface]);
          if (result.exitCode == 0) {
            final ip = '${result.stdout}'.trim();
            if (ip.isNotEmpty) found.add(ip);
          }
        }
      } else if (Platform.isWindows) {
        final result = await Process.run('ipconfig', []);
        if (result.exitCode == 0) {
          final re = RegExp(r'IPv4 Address[.\s]*:\s*([\d.]+)');
          for (final m in re.allMatches('${result.stdout}')) {
            found.add(m.group(1)!);
          }
        }
      } else if (Platform.isLinux) {
        final result = await Process.run('hostname', ['-I']);
        if (result.exitCode == 0) {
          found.addAll(
            '${result.stdout}'
                .trim()
                .split(RegExp(r'\s+'))
                .where((s) => s.isNotEmpty),
          );
        }
      }
    } catch (e) {
      debugPrint('[KitchenServer] platform IP command failed: $e');
    }
    return found;
  }

  static bool _shouldSkipInterface(String name) {
    return name == 'lo' ||
        (name.startsWith('lo') && name.length <= 3) ||
        name.startsWith('utun') ||
        name.startsWith('tun') ||
        name.startsWith('awdl') ||
        name.startsWith('llw') ||
        name.contains('loopback') ||
        name.contains('vethernet') ||
        name.contains('docker') ||
        name.contains('vmware') ||
        name.contains('virtualbox') ||
        name.contains('hyper-v') ||
        name.contains('tailscale') ||
        name.contains('rmnet') ||
        name.contains('ccmni') ||
        name.contains('pdp_ip') ||
        name.contains('wwan') ||
        name.contains('cellular');
  }

  static _LanInterfaceKind _classifyInterface(String name) {
    if (name.startsWith('eth') ||
        name.contains('ethernet') ||
        name.startsWith('lan') ||
        name.startsWith('usb') ||
        name.contains('rndis') ||
        name.contains('enx')) {
      return _LanInterfaceKind.ethernet;
    }

    if (name.startsWith('ap') ||
        name.contains('softap') ||
        name.startsWith('swlan')) {
      return _LanInterfaceKind.lan;
    }

    if (name.contains('wlan') ||
        name.contains('wifi') ||
        name.contains('wi-fi') ||
        name.startsWith('wl') ||
        name.contains('p2p')) {
      return _LanInterfaceKind.wifi;
    }

    if (name.startsWith('en')) {
      return _LanInterfaceKind.lan;
    }

    return _LanInterfaceKind.other;
  }

  static int _privateLanScore(String ip) {
    if (ip.startsWith('192.168.')) return 0;
    if (ip.startsWith('10.')) return 1;
    if (RegExp(r'^172\.(1[6-9]|2\d|3[0-1])\.').hasMatch(ip)) return 2;
    return 3;
  }

  static bool _isLoopback(String ip) =>
      ip == '127.0.0.1' || ip == '::1' || ip.startsWith('127.');

  static bool _isLinkLocal(String ip) => ip.startsWith('169.254.');

  Future<void> _handleRequest(HttpRequest request) async {
    _applyCors(request.response);

    if (request.method == 'OPTIONS') {
      request.response.statusCode = HttpStatus.ok;
      await request.response.close();
      return;
    }

    final path = request.uri.path.replaceFirst(RegExp(r'^/'), '');

    try {
      if (request.method == 'GET' && (path.isEmpty || path == 'health')) {
        await _writeJson(request.response, {
          'ok': true,
          'service': 'flovix_kitchen',
          'port': _port,
          'lanIp': _lanIp,
          'candidateIps': _candidateIps,
          'orders': KitchenOrderStore.instance.orders.length,
        });
        return;
      }

      if (request.method == 'POST' && path == 'orders') {
        final raw = await utf8.decoder.bind(request).join();
        final decoded = jsonDecode(raw);
        if (decoded is! Map) {
          request.response.statusCode = HttpStatus.badRequest;
          await _writeJson(request.response, {
            'ok': false,
            'error': 'body must be a JSON object',
          });
          return;
        }
        final payload = Map<String, dynamic>.from(decoded);
        final ticket = await KitchenOrderStore.instance.enqueue(payload);
        await _writeJson(request.response, {
          'ok': true,
          'id': ticket.id,
          'invoiceNumber': ticket.invoiceNumber,
        });
        return;
      }

      if (request.method == 'GET' && path == 'orders') {
        await _writeJson(request.response, {
          'ok': true,
          'orders': KitchenOrderStore.instance.orders
              .map((e) => e.toJson())
              .toList(),
        });
        return;
      }

      request.response.statusCode = HttpStatus.notFound;
      await _writeJson(request.response, {
        'ok': false,
        'error': 'not found',
      });
    } catch (e) {
      request.response.statusCode = HttpStatus.badRequest;
      await _writeJson(request.response, {
        'ok': false,
        'error': '$e',
      });
    }
  }

  void _applyCors(HttpResponse response) {
    response.headers.set('Access-Control-Allow-Origin', '*');
    response.headers.set('Access-Control-Allow-Methods', 'GET, POST, OPTIONS');
    response.headers.set(
      'Access-Control-Allow-Headers',
      'Origin, Content-Type, Accept, Authorization',
    );
    response.headers.set('Access-Control-Allow-Private-Network', 'true');
    response.headers.contentType = ContentType.json;
  }

  Future<void> _writeJson(
    HttpResponse response,
    Map<String, dynamic> body,
  ) async {
    response.write(jsonEncode(body));
    await response.close();
  }
}

enum _LanInterfaceKind {
  ethernet(0),
  lan(1),
  wifi(2),
  other(3);

  const _LanInterfaceKind(this.priority);
  final int priority;
}

class _LanIpCandidate {
  const _LanIpCandidate({
    required this.ip,
    required this.interfaceName,
    required this.kind,
  });

  final String ip;
  final String interfaceName;
  final _LanInterfaceKind kind;
}
