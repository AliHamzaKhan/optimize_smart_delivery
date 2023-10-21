

import 'package:get/get.dart';

import '../controller/app_controller.dart';
import '../controller/auth_controller.dart';

class AppBinding implements Bindings{
  @override
  void dependencies() {
   Get.put(AppController());

  }

}