import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_weather_app/utils/get_location.dart';

class LocationController extends GetxController {
  RxDouble lat = 0.0.obs;
  RxDouble long = 0.0.obs;
  final FetchLocation _myLocation = FetchLocation();
  Future<void> setLocation() async {
    try {
      final serviceEnabled = await _myLocation.isServiceEnabled();
      final permissionGranted = await _myLocation.isPermissionGranted();
      if (serviceEnabled && permissionGranted) {
        final locationData = await _myLocation.fetchLocation();
        lat.value = locationData.latitude!;
        long.value = locationData.longitude!;
      }
      update();
    } catch (e) {
      debugPrint("Error has Occured while setting location: $e");
    }
  }
}
