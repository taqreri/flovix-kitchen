/// Web stub — kitchen LAN server requires dart:io.
class KitchenLocalServerService {
  KitchenLocalServerService();

  static const int defaultPort = 18200;

  bool get isRunning => false;
  int get port => defaultPort;
  String? get lanIp => null;
  List<String> get candidateIps => const [];
  bool get hasUsableLanIp => false;
  String get displayBaseUrl => 'http://<SET_LAN_IP>:$defaultPort';

  Future<void> start({int port = defaultPort, int maxAttempts = 8}) async {}

  Future<void> stop() async {}

  Future<void> refreshLanIp() async {}
}
