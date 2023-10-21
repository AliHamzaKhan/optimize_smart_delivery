

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:optimize_smart_delivery/config/helper/my_utils.dart';
import 'package:optimize_smart_delivery/config/parser/data_parser_service.dart';

import '../constant/app_constant.dart';
import '../responsive/size_config.dart';
import '../theme/app_colors.dart';
import 'location_service.dart';

class AppMapController extends GetxController{
  MapController mapController = MapController();
  final customMarkers = <Marker>[].obs;
  final currentLocation = Rxn<LatLng>();
  var defaultLocation = const LatLng(41.4881552, -81.7106927);
  var polyLinePoints = <LatLng>[].obs;
  var mapZoom = 15.0.obs;
  var maxZoom = 18.0.obs;
  var minZoom = 10.0.obs;
  Timer? debounce;
  final alignments = {
    315: AnchorAlign.topLeft,
    0: AnchorAlign.top,
    45: AnchorAlign.topRight,
    270: AnchorAlign.left,
    null: AnchorAlign.center,
    90: AnchorAlign.right,
    225: AnchorAlign.bottomLeft,
    180: AnchorAlign.bottom,
    135: AnchorAlign.bottomRight,
  };
  AnchorAlign anchorAlign = AnchorAlign.top;
  bool counterRotate = true;

  addMarker(LatLng point, {icon}) {
    customMarkers.assign(buildPin(point, icon: icon));
  }

  moveCameraToCurrentLocation() async {
    appDebugPrint('before : ${currentLocation.value}');
    var locationService = Get.find<LocationService>();
    if (!locationService.serviceEnabled.value) {
      await locationService.grantLocation();
      currentLocation.value = LatLng(41.4881552, -81.7106927);
    }
    var position = await locationService.getLocation();
    currentLocation.value = LatLng(position!.latitude, position.longitude);
    appDebugPrint('after : ${currentLocation.value}');

    moveCamera(currentLocation.value!);
    // update();
  }

  Marker buildPin(LatLng point, {icon, double? size}) => Marker(
    point: point,
    builder: (ctx) =>
    icon ??
        Icon(
          Icons.location_pin,
          size: setHeightValue(30),
          color: AppColors.textColor,
        ),
    width: setHeightValue(size ?? 30),
    height: setHeightValue(size ?? 30),
  );


  moveCamera(LatLng location) {
    try {
      mapController.move(location, mapZoom.value);
    } catch (e) {
      print(e);
    }
  }

  createPolyLinePoints(LatLng start,LatLng end) async{
    PolylinePoints polylinePoints = PolylinePoints();
    PointLatLng origin = PointLatLng(dataParser.getDouble(start.latitude), dataParser.getDouble(start.longitude));
    PointLatLng destination = PointLatLng(dataParser.getDouble(end.latitude), dataParser.getDouble(end.longitude));
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(AppKeyConstant.Api_Key,
        origin,destination,
      travelMode: TravelMode.driving,
    optimizeWaypoints: true
    );
    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polyLinePoints.add(LatLng(point.latitude, point.longitude));
      }
    }
    print(result.points);
  }

  @override
  void onInit() {
    super.onInit();
    moveCameraToCurrentLocation();
  }
}