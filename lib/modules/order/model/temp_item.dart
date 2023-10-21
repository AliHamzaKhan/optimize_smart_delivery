


import 'package:optimize_smart_delivery/config/parser/data_parser_service.dart';

class TempItem{
  var key;
  var value;
  TempItem({this.key, this.value});
}

class ItemQuantityUpdate {
  int? itemid;
  int? qty;

  ItemQuantityUpdate({
    this.itemid,
    this.qty,
  });

  factory ItemQuantityUpdate.fromJson(Map<String, dynamic> json) => ItemQuantityUpdate(
    itemid: dataParser.getInt(json["itemid"] ?? 0),
    qty: dataParser.getInt(json["qty"] ?? 0),
  );

  Map<String, dynamic> toJson() => {
    "itemid": itemid,
    "qty": qty,
  };
}
class ItemImageUpdate {
  int? itemid;
  String? imagedata;

  ItemImageUpdate({
    this.itemid,
    this.imagedata,
  });

  factory ItemImageUpdate.fromJson(Map<String, dynamic> json) => ItemImageUpdate(
    itemid: dataParser.getInt(json["itemid"] ?? 0),
    imagedata: dataParser.getString(json["imagedata"] ?? ''),
  );

  Map<String, dynamic> toJson() => {
    "itemid": itemid,
    "imagedata": imagedata,
  };
}