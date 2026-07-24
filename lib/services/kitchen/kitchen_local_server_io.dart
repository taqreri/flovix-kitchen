import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:network_info_plus/network_info_plus.dart';

import 'kitchen_order_store.dart';

/// LAN HTTP server hosted by the kitchen app (POS posts orders here).
class KitchenLocalServerService {
  KitchenLocalServerService();

  static const int defaultPort = 18200;

  HttpServer? _server;
  int _port = defaultPort;
  String? _lanIp;
  List<String> _candidateIps = const [];
  StreamSubscription<HttpRequest>? _sub;

  bool get isRunning => _server != null;
  int get port => _port;
  String? get lanIp => _lanIp;
  List<String> get candidateIps => List.unmodifiable(_candidateIps);

  /// Never advertise loopback to POS — other devices cannot reach 127.0.0.1.
  String get displayBaseUrl {
    final ip = _lanIp;
    if (ip == null || ip.isEmpty || _isLoopback(ip)) {
      return 'http://<SET_LAN_IP>:$_port';
    }
    return 'http://$ip:$_port';
  }

  bool get hasUsableLanIp =>
      _lanIp != null && _lanIp!.isNotEmpty && !_isLoopback(_lanIp!);

  Future<void> start({
    int port = defaultPort,
    int maxAttempts = 8,
  }) async {
    // Hot restart often leaves the previous socket bound; close first.
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
        // Brief pause helps after hot restart while the old socket releases.
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
    // 98 = Linux/Android EADDRINUSE, 48 = macOS EADDRINUSE, 10048 = Windows.
    return code == 98 ||
        code == 48 ||
        code == 10048 ||
        (e.message.toLowerCase().contains('address already in use'));
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
    _lanIp = ips.isNotEmpty ? ips.first : null;
  }

  /// Prefer real LAN IPv4 from network interfaces; fall back to Wi‑Fi plugin.
  static Future<List<String>> _discoverLanIps() async {
    final found = <String>{};

    try {
      final interfaces = await NetworkInterface.list(
        includeLinkLocal: false,
        type: InternetAddressType.IPv4,
      );
      for (final iface in interfaces) {
        final name = iface.name.toLowerCase();
        // Skip virtual / tunnel adapters when possible.
        if (name.contains('loopback') ||
            name.contains('vethernet') ||
            name.contains('docker') ||
            name.contains('vmware') ||
            name.contains('virtualbox') ||
            name.contains('hyper-v') ||
            name.contains('tailscale') ||
            name.contains('utun') ||
            name.contains('tun')) {
          continue;
        }
        for (final addr in iface.addresses) {
          if (addr.type != InternetAddressType.IPv4) continue;
          if (_isLoopback(addr.address)) continue;
          if (_isLinkLocal(addr.address)) continue;
          found.add(addr.address);
        }
      }
    } catch (e) {
      debugPrint('[KitchenServer] NetworkInterface.list failed: $e');
    }

    try {
      final wifiIp = await NetworkInfo().getWifiIP();
      if (wifiIp != null &&
          wifiIp.isNotEmpty &&
          !_isLoopback(wifiIp) &&
          !_isLinkLocal(wifiIp)) {
        // Prefer Wi‑Fi IP by putting it first.
        return [
          wifiIp,
          ...found.where((ip) => ip != wifiIp),
        ];
      }
    } catch (e) {
      debugPrint('[KitchenServer] getWifiIP failed: $e');
    }

    // Prefer common private LAN ranges.
    final sorted = found.toList()
      ..sort((a, b) {
        int score(String ip) {
          if (ip.startsWith('192.168.')) return 0;
          if (ip.startsWith('10.')) return 1;
          if (RegExp(r'^172\.(1[6-9]|2\d|3[0-1])\.').hasMatch(ip)) return 2;
          return 3;
        }

        return score(a).compareTo(score(b));
      });
    return sorted;
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
