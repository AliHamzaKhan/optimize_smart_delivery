import 'package:get/get.dart';
import 'package:optimize_smart_delivery/config/controller/auth_controller.dart';
import 'package:optimize_smart_delivery/config/helper/my_utils.dart';

class RegistryController extends GetxController {
  var loading = true.obs;
  var isSwitchOn = true.obs;
  Map loginData = {};
  AuthController controller = Get.find();

  login({required bool save}) async {
    appDebugPrint(loginData);
    await controller.login(
        username: loginData['username'],
        password: loginData['password'],
        save: save);
  }
}
