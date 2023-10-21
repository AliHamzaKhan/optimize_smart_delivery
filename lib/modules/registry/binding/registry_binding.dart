

import 'package:get/get.dart';

import '../controller/registry_controller.dart';

class RegistryBinding implements Bindings{
  @override
  void dependencies() {
   Get.lazyPut(() => RegistryController());
  }

}