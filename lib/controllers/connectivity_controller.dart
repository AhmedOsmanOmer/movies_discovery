import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ConnectivityController extends GetxController {
  final Connectivity _connectivity = Connectivity();

  bool isOnline = true;

  Future<void> initConnectivity() async {
    try {
      final results = await _connectivity.checkConnectivity();
      _updateStatus(results);
    } on PlatformException {
      // connectivity check failed; assume online
    }
  }

  Future<void> startMonitoring() async {
    await initConnectivity();
    _connectivity.onConnectivityChanged.listen(_updateStatus);
  }

  void _updateStatus(List<ConnectivityResult> results) async {
    if (results.every((r) => r == ConnectivityResult.none)) {
      isOnline = false;
      update();
    } else {
      isOnline = await _hasActualInternet();
      update();
    }
  }

  Future<bool> _hasActualInternet() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException {
      return false;
    }
  }
}
