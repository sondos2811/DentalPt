// ignore_for_file: unrelated_type_equality_checks

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dental_pt/core/network/network_info.dart';

class NetworkInfoImpl implements NetworkInfo {
  final Connectivity connectivity;

  NetworkInfoImpl({required this.connectivity});

  @override
  Future<bool> get isConnected async {
    final connectivityResult = await connectivity.checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  // Manual check (instead of listening to changes)
  @override
  Future<String> checkConnectionStatus() async {
    final connectivityResult = await connectivity.checkConnectivity();
    
    if (connectivityResult == ConnectivityResult.none) {
      return "No network connection";
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return "Connected to WiFi";
    } else if (connectivityResult == ConnectivityResult.mobile) {
      return "Connected to Mobile Data";
    } else {
      return "Unknown connection state";
    }
  }
}
