import 'dart:convert';

import 'package:get/get.dart';
import 'package:optimize_smart_delivery/config/app_enviroment/app_environment.dart';
import 'package:optimize_smart_delivery/config/controller/auth_controller.dart';
import 'package:optimize_smart_delivery/config/controller/location_service.dart';
import 'package:optimize_smart_delivery/config/api/api_response_model.dart';
import 'package:optimize_smart_delivery/config/parser/data_parser_service.dart';
import '../../modules/order/model/delivery_item.dart';
import '../../modules/order/model/task.dart';
import '../../modules/order/model/temp_item.dart';
import '../api/api_service.dart';
import '../helper/my_utils.dart';

class AppController extends GetxService {
  APIService apiService = APIService();
  AuthController authController = Get.find();
  LocationService locationService = Get.find();

  Future<List<Rows>> getOrders() async {
    appDebugPrint("getOrders");
    var location = await locationService.getLocation();
    var url = '${AppEnvironment.ORDERS_URL}&username=${authController.getToken()}&latitude=${location?.latitude}&longitude=${location?.longitude}';
    // Map<String, String> params = {
    //   'username': authController.getToken(),
    //   'latitude': dataParser.getString(location?.latitude),
    //   'longitude': dataParser.getString(location?.longitude)
    // };
    ApiResponseModel response = await apiService.get(
        endpoint:url);
    appDebugPrint(response.rows);
    appDebugPrint(response.rows.length);
    var rows = rowsListFromJson(response.rows ?? {}) /*Rows.fromJson(response.data != '' ? response.rows[0] : {})*/;
    return rows;
  }

  Future<bool> updateStatus({deliveryId, statusId, reason}) async {
    appDebugPrint("updateStatus");
    var location = await locationService.getLocation();


    Map<String, String> params = {
      'deliveryid': dataParser.getString(deliveryId),
      'statusid': dataParser.getString(statusId),
      'latitude': dataParser.getString(location?.latitude),
      'longitude': dataParser.getString(location?.longitude)
    };
    if (reason != null) {
      params['deliveryfailreason'] = reason;
    }
    ApiResponseModel response = await apiService.get(
      endpoint: AppEnvironment.UPDATE_DELIVERY_URL,
      params: params,
    );
    return response.isSuccess;
  }

  Future<List<ItemData>?> getDeliveryItems({deliveryId}) async {
    appDebugPrint("getDeliveryItems");
    Map<String, String> params = {
      'deliveryid': dataParser.getString(deliveryId)
    };
    ApiResponseModel response = await apiService.get(
        endpoint: AppEnvironment.DELIVERY_ITEM_URL, params: params);
    return DeliveryItem.fromJson(response.rows).itemData;
  }

  Future<bool> uploadSignature({deliveryId, signature}) async{
    appDebugPrint("signature");

    var form = <String, dynamic>{};
    form["deliveryid"] = '$deliveryId';
    form["imagedata"] = "data:image/png;base64,$signature";

    ApiResponseModel response = await apiService.post(
        endpoint: AppEnvironment.UPLOAD_SIGNATURE_URL,
        body: form);

    return response.isSuccess;
  }

  Future<bool> reOrderVisit({required int deliverId,required int current}) async{
    appDebugPrint("reOrderVisit");

    Map<String, String> params = {
      'deliveryid' : dataParser.getString(deliverId),
      'visitorder' : dataParser.getString(current)
    };
    ApiResponseModel response = await apiService.get(
        endpoint: AppEnvironment.RE_ORDER_URL,
        params: params);

    return response.isSuccess;
  }

  uploadQuantity({required deliveryId, required List<ItemQuantityUpdate> qtyData}) async{
    List<Map<String, dynamic>> qtyDataJson = qtyData.map((e) => e.toJson()).toList();
    var data = {
      'jdata': jsonEncode({
        "deliveryid": deliveryId,
        "driverid": 1,
        "items": qtyDataJson,
      })
    };
    ApiResponseModel response = await apiService.post(
        endpoint: AppEnvironment.UPDATE_DELIVERY_ITEM_URL,
        body: data);
    return response.isSuccess;
  }
}
