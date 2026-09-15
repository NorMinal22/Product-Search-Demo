import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

// Preset
enum ConnectivityStatus {wifi, mobile, offline}

// For internet connection
class ConnectionService extends ChangeNotifier{
  ConnectivityStatus _status = ConnectivityStatus.offline;
  ConnectivityStatus get status => _status;
  ConnectivityStatus? previousStatus;
  StreamSubscription<ConnectivityResult>? _subscription;

  static final ConnectionService _instance = ConnectionService._internal();
  factory ConnectionService() => _instance;

  ConnectionService._internal(){
    Connectivity().checkConnectivity().then(_updateStatus);
    _subscription = Connectivity().onConnectivityChanged.listen(_updateStatus);
  }
  void _updateStatus(ConnectivityResult result){
    previousStatus = _status;   // Store old status

    if(result == ConnectivityResult.wifi){
      _status = ConnectivityStatus.wifi;
    } else if(result == ConnectivityResult.mobile){
      _status = ConnectivityStatus.mobile;
    } else {
      _status = ConnectivityStatus.offline;
    }

    if(previousStatus != _status){
      notifyListeners();   // This trigger UI to rebuild everywhere
    }
  }


  // Check if have internet, return true or false
  Future<bool> check() async {
    final result = await Connectivity().checkConnectivity();
    return result == ConnectivityResult.mobile || result == ConnectivityResult.wifi;
  }

  // Stop the subscription from an endless loop
  @override
  void dispose() {
    super.dispose();
    _subscription?.cancel();
  }
}