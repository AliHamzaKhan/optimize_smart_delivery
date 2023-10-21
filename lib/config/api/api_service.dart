

import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:optimize_smart_delivery/Widget/app_alerts.dart';
import 'package:optimize_smart_delivery/config/app_enviroment/app_environment.dart';
import 'package:http/http.dart' as http;
import 'package:optimize_smart_delivery/config/helper/my_utils.dart';

import '../../Widget/app_loading.dart';
import 'api_response_model.dart';


typedef CompleteCallback = void Function(dynamic callBack);
typedef SuccessCallback = void Function(dynamic success);
typedef ErrorsCallback = void Function(dynamic error);

class APIService {
  String commonError = "Something went wrong, Please try again later";
  String connectivityError = "No internet connection, Please try again later";
  String validationError = "Please enter valid information to proceed";
  String invalidResponse = "Invalid response from server";
  String serverError = "Invalid response from server";

  String errorMessage = 'Error occurred';

  Future<Map> getWithoutCallBack(
      String url,
      Map<String, String> queryParams, {
        showLoader = true,
        BuildContext? context,
        Function? logout,
      }) async {
    try {
      if (showLoader) {
        AppLoader.showLoading();
      }
      String uri = "${AppEnvironment.apiUrl()}$url${Uri(queryParameters: queryParams)}";

      var response = await http.get(
        Uri.parse(uri),
        headers: _setHeaders(),
      );
      if (response.statusCode == 401 && logout != null) {
        logout();
        return {};
      }

      var result = jsonDecode(response.body);
      // printDebug(result);
      if (result != null) {
        return Map.from(result);
      } else {
        if (showLoader) {
          AppLoader.fail(error: commonError);
        }
        return _response();
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
      if (showLoader) {
        AppLoader.dismiss();
      }
      return _response();
    }
  }

  /// This is the Api [GET] method. it will give you response in this model [ApiResponseModel].
  Future<ApiResponseModel> get({
    required String endpoint,
    Map<String, String>? params,
    bool disableLoading = false,
    showError = true,
    Function? logout,
  }) async {
    try {
      if (!disableLoading) AppLoader.showLoading();

      String url = "${AppEnvironment.apiUrl()}$endpoint${Uri(queryParameters: params)}";
      appDebugPrint(url);
      http.Response response = await http.get(
        Uri.parse(url),
        headers: _setHeaders(),
      );
      if (!disableLoading) {
        AppLoader.dismiss();
      }
      if (response.statusCode == 401 && logout != null) {
        logout();
        return ApiResponseModel.fromJson('');
      } else if (response.statusCode == 500) {
        var responseApi = ApiResponseModel.fromJson('');
        responseApi.message = commonError;
        return responseApi;
      }
      ApiResponseModel result = ApiResponseModel.fromJson(response.body);
      if (!result.isSuccess && showError) {
        appAlerts.customAlert(
          alertTypes: AlertTypes.error,
          title: errorMessage,
          subTitle: result.message,
        );
      }

      return result;
    } on Exception catch (e) {
      debugPrint(e.toString());
      if (!disableLoading) {
        AppLoader.dismiss();
      }
      if (showError) {
        var isConnectivity = await internetConnectivityCheck();

        appAlerts.customAlert(
          alertTypes:
          !isConnectivity ? AlertTypes.connectivity : AlertTypes.error,
          title: !isConnectivity
              ? connectivityError
              : serverError,
          subTitle: !isConnectivity ? connectivityError : commonError,
        );
      }

      ApiResponseModel result = ApiResponseModel.fromMap({});

      return result;
    }
  }

  Future<bool> internetConnectivityCheck() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  /// This is the Api [POST] method. it will give you response in this model [ApiResponseModel].
  Future<ApiResponseModel> post({
    required String endpoint,
    required Map<String, dynamic> body,
    Map<String, String>? headers,
    bool disableLoading = false,
    bool showError = true,
    Function? logout,
     }) async {
    try {
      if (!disableLoading) AppLoader.showLoading();
      headers ??= {};
      String url = "${AppEnvironment.apiUrl()}$endpoint";

      http.Response response = await http.post(
        Uri.parse(url),
        headers: {...headers, ..._setHeaders()},
        body: jsonEncode(body),
      );

      if (!disableLoading) {
        AppLoader.dismiss();
      }
      if (response.statusCode == 401 && logout != null) {
        logout();
        return ApiResponseModel.fromJson('');
      } else if (response.statusCode == 500) {
        var responseApi = ApiResponseModel.fromJson('');
        responseApi.message = commonError;
        return responseApi;
      }
      ApiResponseModel result = ApiResponseModel.fromJson(response.body);

      if (!result.isSuccess && showError) {
        appAlerts.customAlert(
            alertTypes: AlertTypes.error,
            title: 'Error',
            subTitle: result.message);
      }
      return result;
    } on Exception catch (e) {
      debugPrint(e.toString());
      if (!disableLoading) {
        AppLoader.dismiss();
      }

      if (showError) {
        var isConnectivity = await internetConnectivityCheck();
        appAlerts.customAlert(
          alertTypes:
          !isConnectivity ? AlertTypes.connectivity : AlertTypes.error,
          title: 'Error',
          subTitle: !isConnectivity ? connectivityError : commonError,
        );
      }

      ApiResponseModel result = ApiResponseModel.fromMap({});
      return result;
    }
  }

  /// This is the Api [PATCH] method. it will give you response in this model [ApiResponseModel].
  Future<ApiResponseModel> patch({
    required String endpoint,
    required Map<String, dynamic> body,
    Function? logout,
  }) async {
    try {
      AppLoader.showLoading();

      String url = "${AppEnvironment.apiUrl()}$endpoint";
      http.Response response = await http.patch(
        Uri.parse(url),
        headers: _setHeaders(),
        body: jsonEncode(body),
      );
      if (response.statusCode == 401 && logout != null) {
        logout();
        return ApiResponseModel.fromJson('');
      } else if (response.statusCode == 500) {
        var response = ApiResponseModel.fromJson('');
        response.message = commonError;
        return response;
      }
      ApiResponseModel result = ApiResponseModel.fromJson(response.body);
      AppLoader.dismiss();
      if (result.isSuccess) {
        AppLoader.success(message: result.message);
      } else {
        AppLoader.fail(error: result.message);
      }

      return result;
    } on Exception catch (_) {
      AppLoader.dismiss();
      ApiResponseModel result = ApiResponseModel.fromMap({});
      return result;
    }
  }

  /// This is the Api [PUT] method. it will give you response in this model [ApiResponseModel].
  Future<ApiResponseModel> put({
    required String endpoint,
    required Map<String, dynamic> body,
    Function? logout,
  }) async {
    try {
      AppLoader.showLoading();

      String url = "${AppEnvironment.apiUrl()}$endpoint";
      http.Response response = await http.put(
        Uri.parse(url),
        headers: _setHeaders(),
        body: jsonEncode(body),
      );
      if (response.statusCode == 401 && logout != null) {
        logout();
        return ApiResponseModel.fromJson('');
      } else if (response.statusCode == 500) {
        var responce = ApiResponseModel.fromJson('');
        responce.message = commonError;
        return responce;
      }
      ApiResponseModel result = ApiResponseModel.fromJson(response.body);
      AppLoader.dismiss();
      if (result.isSuccess) {
        AppLoader.success(message: result.message);
      } else {
        appAlerts.customAlert(
            alertTypes: AlertTypes.error,
            title: 'Error',
            subTitle: result.message);

      }

      return result;
    } on Exception catch (_) {
      AppLoader.dismiss();
      ApiResponseModel result = ApiResponseModel.fromMap({});
      return result;
    }
  }

  /// This is the Api [DELETE] method. it will give you response in this model [ApiResponseModel].
  Future<ApiResponseModel> delete({
    required String endpoint,
    Map<String, String>? params,
    bool disableLoading = false,
    showError = true,
    Function? logout,
  }) async {
    try {
      if (!disableLoading) AppLoader.showLoading();

      String url = "${AppEnvironment.apiUrl()}$endpoint${Uri(queryParameters: params)}";
      http.Response response = await http.delete(
        Uri.parse(url),
        headers: _setHeaders(),
      );
      if (!disableLoading) {
        AppLoader.dismiss();
      }

      if (response.statusCode == 401 && logout != null) {
        logout();
        return ApiResponseModel.fromJson('');
      } else if (response.statusCode == 500) {
        var response = ApiResponseModel.fromJson('');
        response.message = commonError;
        return response;
      }
      ApiResponseModel result = ApiResponseModel.fromJson(response.body);

      if (!result.isSuccess && showError) {
        appAlerts.customAlert(
            alertTypes: AlertTypes.error,
            title: 'Error',
            subTitle: result.message);
      }

      return result;
    } on Exception catch (e) {
      debugPrint(e.toString());
      if (!disableLoading) {
        AppLoader.dismiss();
      }
      if (showError) {
        var isConnectivity = await internetConnectivityCheck();

        appAlerts.customAlert(
            alertTypes: AlertTypes.error,
            title: 'Error',
            subTitle: !isConnectivity ? connectivityError : commonError);
      }

      ApiResponseModel result = ApiResponseModel.fromMap({});
      return result;
    }
  }

  /*
  * #### Post fine Method
  * @@@@@ params
  * 1 -- BuildContext
  * 2 -- url
  * 3 -- post MAP
  * 4 -- headers MAP
  * 5 -- success Method callback
  * 6 -- fail method callback
  * 7 -- returnFull optional, true for return complete output false for return just data inside success
  * 8 -- loader optional default true, for showing loader while request
  * */

  postFile({
    required String endpoint,
    // required File file,
    Map<String, dynamic>? body,
    required SuccessCallback success,
    required ErrorsCallback requestFail,
    showLoader = true,
  }) async {
    String url = "${AppEnvironment.apiUrl()}$endpoint";
    var request = http.MultipartRequest("POST", Uri.parse(url));
    request.headers.addAll({...request.headers, ..._setHeaders()});
    if (body != null) {
      body.forEach((key, value) {
        request.fields[key] = '$value';
      });
    }

    if (showLoader) {
      AppLoader.showLoading();
    }
    request.send().then((streamedResponse) async {
      if (streamedResponse.statusCode >= 200 &&
          streamedResponse.statusCode < 399) {
        // showLoader && PBLoader.dismiss();
        var response = await http.Response.fromStream(streamedResponse);
        var responseJson = json.decode(response.body);
        if (responseJson != null) {
          success(responseJson);
        } else {
          requestFail(commonError);
        }
      } else {
        requestFail(commonError);
      }
    }).catchError((error) {
      if (showLoader) {
        AppLoader.dismiss();
      }
      requestFail(commonError);
    });
  }

  patchWithoutContext(
      String url,
      Map<String, String> queryParams,
      Map<String, dynamic> body,
      SuccessCallback success,
      ErrorsCallback requestFail, {
        showLoader = true,
        Function? logout,
      }) async {
    String uri = "${AppEnvironment.apiUrl()}$url${Uri(queryParameters: queryParams)}";
    print(uri);
    try {
      if (showLoader) {
        AppLoader.showLoading();
      }
      print(body);
      var response = await http.patch(
        Uri.parse(uri),
        body: jsonEncode(body),
        headers: _setHeaders(),
      );
      var result = jsonDecode(response.body);
      if (result != null) {
        final Map map = Map.from(result);
        success(map);
      } else {
        if (showLoader) {
          AppLoader.fail(error: commonError);
        }
        requestFail(commonError);
      }
    } catch (e) {
      if (showLoader) {
        AppLoader.fail(error: "$e");
      }

      if (true)
      {
        requestFail(e);
      }
    }
  }

  _setHeaders() {
    // Map<String, String> authHeader = {
    //   'Content-type': 'application/json',
    //   'Accept': 'application/json',
    //   "Access-Control-Allow-Origin": "*"
    // };
    // return {...authHeader, ...getAuthToken()};
  }

  // Map<String, String> getAuthToken() {
  //   String thisUser = dataStore.getString(AppKeyConstant.kUserInfo);
  //
  //   String thisToken = dataStore.getString(AppKeyConstant.kToken);
  //
  //   if (thisUser != "" && thisToken != "") {
  //     // ignore: no_leading_underscores_for_local_identifiers
  //     var _userData = dataParser.decodeMap(thisUser);
  //     var user = PbUserModel.fromJson(_userData);
  //     return {
  //       'Authorization': 'Bearer $thisToken',
  //       'X-Authorization': dataParser.base64Encoder(user.userId!.toString()),
  //
  //     };
  //   }
  //   return {};
  // }

  _response({isSuccess = false, statusCode = 200, message}) {
    return {
      "isSuccess": isSuccess,
      "statusCode": statusCode,
      "message": message ?? commonError,
    };
  }
}