

import 'package:get/get.dart';
import 'package:optimize_smart_delivery/modules/order/controller/order_controller.dart';

class OrderBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => OrderController());
  }

}