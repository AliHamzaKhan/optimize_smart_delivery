import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:permission_handler/permission_handler.dart';

import '../helper/my_utils.dart';

class LocationService extends GetxService {
  var currentLocation = LatLng(0, 0).obs;
  var serviceEnabled = false.obs;

  Future<Position?> getLocation() async {
    if (await Permission.location.isGranted) {
      try {
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.bestForNavigation,
        );

        currentLocation.value = LatLng(position.latitude, position.longitude);
        appDebugPrint(currentLocation.value);
        appDebugPrint(position);
        appDebugPrint(serviceEnabled.value);

        return position;
      } catch (e) {
        appDebugPrint('Error getting location: $e');
      }
    } else {
      await grantLocation();
    }

    return null;
  }

  grantLocation() async {
    if (await Permission.location.isGranted) {
      serviceEnabled(true);
      appDebugPrint(serviceEnabled.value);
    } else {
      final status = await Permission.location.request();
      if (status.isGranted) {
        serviceEnabled(true);
        appDebugPrint(serviceEnabled.value);
      } else if (status.isDenied) {
        serviceEnabled(false);
        appDebugPrint(serviceEnabled.value);

        Get.dialog(Column(
          children: [
            const Text(
                'We need access to your location to provide you with nearby services recommendations and improve your overall experience.'),
            TextButton(
                onPressed: () {
                  grantLocation();
                },
                child: const Text('Enable Location'))
          ],
        ));
      } else if (status.isPermanentlyDenied) {
        serviceEnabled(false);
        appDebugPrint(serviceEnabled.value);
      }
    }
  }

  @override
  void onInit() {
    super.onInit();
    // getLocation();
    grantLocation();
  }
}
