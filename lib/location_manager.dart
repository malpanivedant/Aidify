import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'custom_widgets/custom_alert_dialogbox.dart';

const _kTimeLimitInSeconds = 10;

class LocationManager {
  LocationManager._privateConstructor();

  static final LocationManager shared = LocationManager._privateConstructor();

  factory LocationManager() => shared;

  /// [askForPermission] will check and ask for location permission
  Future<bool> _askForPermission(BuildContext context) async {
    LocationPermission permission = await Geolocator.checkPermission();
    const alert = CustomAlertDialog(
      errorTitle: "Request",
      errorMessage: "Please give location access",
      buttonTitle: "Ok",
    );
    if (permission == LocationPermission.denied) {
      await alert.showAlertDialog(context);
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return false;
      } else {
        return true;
      }
    } else if (permission == LocationPermission.deniedForever) {
      Geolocator.openAppSettings();
    }
    return true;
  }

  Future<Position?> getCurrentPosition(BuildContext context) async {
    final hasPermission =
        await LocationManager.shared._askForPermission(context);
    Position? location;
    if (hasPermission) {
      try {
        location = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.medium,
          timeLimit: const Duration(seconds: _kTimeLimitInSeconds),
        );
      } catch (ex) {
        debugPrint(ex.toString());
      }
    }
    return location;
  }

  Future<Position?> getCurrentPositionNoPermission() async {
    Position? location;
    try {
      location = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium,
        timeLimit: const Duration(seconds: _kTimeLimitInSeconds),
      );
    } catch (ex) {
      debugPrint(ex.toString());
    }
    return location;
  }
}
