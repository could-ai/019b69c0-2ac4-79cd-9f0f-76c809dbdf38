import 'dart:async';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class OfflineService extends ChangeNotifier {
  bool _isOffline = false;
  bool get isOffline => _isOffline;

  OfflineService() {
    _initConnectivity();
  }

  Future<void> _initConnectivity() async {
    // connectivity_plus ^5.0.2 uses single ConnectivityResult
    final result = await Connectivity().checkConnectivity();
    _updateConnectionStatus(result);
    
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      _updateConnectionStatus(result);
    });
  }

  void _updateConnectionStatus(ConnectivityResult result) {
    bool hasConnection = result != ConnectivityResult.none;
    _isOffline = !hasConnection;
    notifyListeners();
  }
}
