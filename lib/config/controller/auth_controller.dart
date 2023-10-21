import 'package:get/get.dart';
import 'package:optimize_smart_delivery/config/helper/my_utils.dart';
import 'package:optimize_smart_delivery/config/storage/data_store_service.dart';
import '../../Widget/app_alerts.dart';
import '../api/api_response_model.dart';
import '../api/api_service.dart';
import '../app_enviroment/app_environment.dart';
import '../routes/app_routes.dart';

class AuthController extends GetxController {
  APIService apiService = APIService();
  static String TOKEN = 'TOKEN';

  login(
      {required String username,
      required String password,
      required bool save}) async {

    ApiResponseModel api = await apiService.get(
      endpoint: "${AppEnvironment.LOGIN_URL}&username=$username&password=$password",
    );
    appDebugPrint(api);

    if (api.message == 'user authenticated') {
      dataStore.setString(TOKEN, username);
      Get.offAllNamed(AppRoutes.orderListingView);
    } else {
      appAlerts.customAlert(
          title: 'Authentication Failed',
          message: 'Incorrect username/password',
          alertTypes: AlertTypes.error);
    }
  }

  getToken() {
    var token = dataStore.getString(TOKEN);
    appDebugPrint('token $token');
    return token;
  }

  bool checkUser() {
    return getToken() == '' ? false : true;
  }

  logout() {
    dataStore.clearData();
    Get.offAllNamed(AppRoutes.login);
  }
}
