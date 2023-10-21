import 'dart:convert';

import 'package:optimize_smart_delivery/config/parser/data_parser_service.dart';

DeliveryItem deliveryItemFromJson(String str) =>
    DeliveryItem.fromJson(json.decode(str));

String deliveryItemToJson(DeliveryItem data) => json.encode(data.toJson());

class DeliveryItem {
  String? status;
  String? statusMessage;
  List<ItemData>? itemData;

  DeliveryItem({
    this.status,
    this.statusMessage,
    this.itemData,
  });

  factory DeliveryItem.fromJson(Map<String, dynamic> json) => DeliveryItem(
        status: dataParser.getString(json["status"] ?? ''),
        statusMessage: dataParser.getString(json["status_message"] ?? ''),
        itemData:
            List<ItemData>.from(json["rows"].map((x) => ItemData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "status_message": statusMessage,
        "rows": List<dynamic>.from(itemData!.map((x) => x.toJson())),
      };
}

class ItemData {
  int? deliveryid;
  int? itemId;
  String? itemName;
  int? qty;
  String? itemUnit;
  String? photopath;
  String? photoon;
  String? deliveryrefno;

  ItemData({
    this.deliveryid,
    this.itemId,
    this.itemName,
    this.qty,
    this.itemUnit,
    this.photopath,
    this.photoon,
    this.deliveryrefno,
  });

  factory ItemData.fromJson(Map<String, dynamic> json) => ItemData(
        deliveryid: dataParser.getInt(json["deliveryid"] ?? ''),
        itemId: dataParser.getInt(json["ItemID"] ?? ''),
        itemName: dataParser.getString(json["ItemName"] ?? ''),
        qty: dataParser.getInt(json["Qty"] ?? ''),
        itemUnit: dataParser.getString(json["ItemUnit"] ?? ''),
        photopath: dataParser.getString(json["photopath"] ?? ''),
        photoon: dataParser.getString(json["photoon"] ?? ''),
        deliveryrefno: dataParser.getString(json["deliveryrefno"] ?? ''),
      );

  Map<String, dynamic> toJson() => {
        "deliveryid": deliveryid,
        "ItemID": itemId,
        "ItemName": itemName,
        "Qty": qty,
        "ItemUnit": itemUnit,
        "photopath": photopath,
        "photoon": photoon,
        "deliveryrefno": deliveryrefno,
      };
}
