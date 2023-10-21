import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:optimize_smart_delivery/Widget/app_button.dart';
import 'package:optimize_smart_delivery/config/constant/app_constant.dart';
import 'package:optimize_smart_delivery/config/responsive/size_config.dart';
import 'package:optimize_smart_delivery/config/theme/app_colors.dart';

import '../../../Widget/app_widget.dart';
import '../../../Widget/delivery_button_color.dart';
import '../../../config/helper/my_utils.dart';
import '../../../widget/order_items_drawer.dart';
import '../controller/order_controller.dart';
import '../model/order_type.dart';

class OrderRunningView extends GetView<OrderController> {
  const OrderRunningView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.mapController.createPolyLinePoints(
        LatLng(24.906504, 67.005936), LatLng(25.075474, 67.104813));
    return Scaffold(
      key: controller.scaffoldKey,
      backgroundColor: AppColors.appbackgroundColor,
      body: SafeArea(
        child: Container(
          width: kWidth,
          height: kHeight,
          child: Stack(
            children: [
              mapView(),
              appBar(),
              Align(
                alignment: Alignment.bottomCenter,
                child: orderDetails(),
              )
            ],
          ),
        ),
      ),
      endDrawer: OrderItemsDrawer(),
    );
  }

  mapView() {
    return Container(
      color: AppColors.alterColor,
      width: kWidth,
      height: kHeight * 0.68,
      child: FlutterMap(
        mapController: MapController(),
        options: MapOptions(
          center: LatLng(24.906504, 67.005936),
          zoom: 13.0,
        ),
        nonRotatedChildren: [],
        children: [
          TileLayer(
            urlTemplate: AppKeyConstant.Map_Box_Style,
            additionalOptions: const {
              'accessToken': AppKeyConstant.Default_Public_Token,
              'id': AppKeyConstant.kMapId
            },
          ),
          PolylineLayer(
            polylines: [
              Polyline(
                  points: controller.mapController.polyLinePoints,
                  color: AppColors.alterColor,
                  strokeWidth: 3),
            ],
          ),
          MarkerLayer(
            markers: [
              controller.mapController.buildPin(LatLng(24.906504, 67.005936),
                  icon: Icon(
                    Icons.directions_bus_outlined,
                    size: setHeightValue(30),
                    color: AppColors.textColor,
                  )),
              controller.mapController.buildPin(LatLng(25.075474, 67.104813)),
            ],
          ),
        ],
      ),
    );
  }

  openGoogleMapButton() {
    return Positioned(
        bottom: 10,
        right: 1,
        child: AppIconButton(
          title: 'Open Map',
          onTap: () {},
          icon: Icons.map,
          alignment: MainAxisAlignment.center,
          btnWidth: 130,
          centerPadding: 10,
          btnRadius: 20,
          btnColor: AppColors.appbackgroundColor,
        ));
  }

  orderDetails() {
    return Obx(() => GestureDetector(
          onTap: () {
            controller.showFullOrder.value = !controller.showFullOrder.value;
            controller.isStatusLoaded.value = !controller.isStatusLoaded.value;
          },
          child: AnimatedContainer(
            width: kWidth,
            height:
                controller.showFullOrder.value ? kHeight * 0.4 : kHeight * 0.3,
            padding: EdgeInsets.symmetric(
                horizontal: setWidthValue(30), vertical: setHeightValue(10)),
            decoration: BoxDecoration(
                color: AppColors.cardColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(setHeightValue(20)),
                  topRight: Radius.circular(setHeightValue(20)),
                )),
            duration: const Duration(milliseconds: 300),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                statusButton(5),
                getTableWidget('Address',
                    'orderController.getCurrentOrder().deliveryaddress!',
                    textSize: 18),
                setHeight(5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: getTableWidget('From', '10:AM', textSize: 18)),
                    Expanded(
                        child: getTableWidget('To', '12:PM', textSize: 18)),
                  ],
                ),
                setHeight(5),
                getTableWidget('Tel', '03222319787', textSize: 18),
                setHeight(5),
                getTableWidget(
                    'Notes', 'orderController.getCurrentOrder().notes!',
                    textSize: 18, maxLines: 5),
                setHeight(5),
                getTableWidget(
                    DistanceCal().kmToMm(100).toStringAsFixed(1), 'km',
                    textColor: AppColors.alterColor, textSize: 18),
                setHeight(5),
              ],
            ),
          ),
        ));
  }

  statusButton(status, {onTap}) {
    return controller.isStatusLoaded.value
        ? AppButton(
            title: getNameByStatusNum(status),
            onTap: onTap,
            btnColor: getStatusByNum(status),
            isOutline: true,
            btnWidth: 150,
            btnHeight: 35,
            btnRadius: 5,
            textColor: getStatusByNum(status),
          )
        : Center(
            child: CircularProgressIndicator(
              color: AppColors.alterColor,
            ),
          );
  }

  appBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
            onPressed: () {
              controller.mapController.polyLinePoints.clear();
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back,
              color: AppColors.textColor,
              size: 25,
            )),
        Text(
          'Order No # 12958',
          style: TextStyle(
              color: AppColors.textColor,
              fontWeight: FontWeight.bold,
              fontSize: setHeightValue(20)),
        ),
        IconButton(
            onPressed: () {
              controller.openDrawer();
            },
            icon: Icon(
              Icons.menu,
              color: AppColors.textColor,
              size: 25,
            )),
      ],
    );
  }
}
