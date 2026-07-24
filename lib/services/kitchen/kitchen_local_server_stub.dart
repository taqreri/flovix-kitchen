/// Web stub — kitchen LAN server requires dart:io.
class KitchenLocalServerService {
  KitchenLocalServerService();

  static const int defaultPort = 18200;

  bool get isRunning => false;
  int get port => defaultPort;
  String? get lanIp => '127.0.0.1';
  List<String> get candidateIps => const ['127.0.0.1'];
  bool get hasUsableLanIp => false;
  bool get discoveryComplete => true;
  String get displayBaseUrl => 'http://127.0.0.1:$defaultPort';

  Future<void> start({int port = defaultPort, int maxAttempts = 8}) async {}

  Future<void> stop() async {}

  Future<void> refreshLanIp() async {}
}
