abstract class NetworkInfo {
  Future<bool> get isConnected;
  Future<String>checkConnectionStatus();
}
