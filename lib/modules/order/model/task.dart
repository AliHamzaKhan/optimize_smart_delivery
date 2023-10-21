import 'package:optimize_smart_delivery/config/parser/data_parser_service.dart';



List<Rows> rowsListFromJson(value) => List<Rows>.from(
    value.map((service) => Rows.fromJson(service))
);

class Rows {
  int? deliveryid;
  String? deliveryrefno;
  String? deliveryaddress;
  String? deliverydate;
  int? visitorderno;
  int? statusid;
  String? notesfordriver;
  String? departedon;
  String? arrivedon;
  String? eta;
  int? distance;
  String? timeFrom;
  String? timeTo;
  String? notes;
  String? tel;

  Rows({
    this.deliveryid,
    this.deliveryrefno,
    this.deliveryaddress,
    this.deliverydate,
    this.visitorderno,
    this.statusid,
    this.notesfordriver,
    this.departedon,
    this.arrivedon,
    this.eta,
    this.distance,
    this.timeFrom,
    this.timeTo,
    this.notes,
    this.tel,
  });

  factory Rows.fromJson(Map<String, dynamic> json) => Rows(
        deliveryid: dataParser.getInt(json["deliveryid"] ?? ''),
        deliveryrefno: dataParser.getString(json["deliveryrefno"] ?? ""),
        deliveryaddress: dataParser.getString(json["deliveryaddress"] ?? ""),
        deliverydate: dataParser.getString(json["deliverydate"] ?? ""),
        visitorderno: dataParser.getInt(json["visitorderno"] ?? ''),
        statusid: dataParser.getInt(json["statusid"] ?? ''),
        notesfordriver: dataParser.getString(json["notesfordriver"] ?? ""),
        departedon: dataParser.getString(json["departedon"] ?? ""),
        arrivedon: dataParser.getString(json["arrivedon"] ?? ""),
        eta: dataParser.getString(json["eta"] ?? ""),
        distance: dataParser.getInt(json["distance"] ?? ''),
        timeFrom: dataParser.getString(json["time_from"] ?? ""),
        timeTo: dataParser.getString(json["time_to"] ?? ""),
        notes: dataParser.getString(json["notes"] ?? ""),
        tel: dataParser.getString(json["telno"] ?? ""),
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['deliveryid'] = deliveryid;
    data['deliveryrefno'] = deliveryrefno;
    data['deliveryaddress'] = deliveryaddress;
    data['deliverydate'] = deliverydate;
    data['visitorderno'] = visitorderno;
    data['statusid'] = statusid;
    data['notesfordriver'] = notesfordriver;
    data['departedon'] = departedon;
    data['arrivedon'] = arrivedon;
    data['eta'] = eta;
    data['distance'] = distance;
    data['time_from'] = timeFrom;
    data['time_to'] = timeTo;
    data['notes'] = notes;
    data['tel'] = tel;
    return data;
  }
}

class Task {
  String? status;

  String? statusMessage;

  List<Rows>? rows;

  Task({this.status, this.statusMessage, this.rows});

  Task.fromJson(Map<String, dynamic> json) {
    status = dataParser.getString(json['status'] ?? '');
    statusMessage = dataParser.getString(json['status_message'] ?? '');
    if (json['rows'] != null) {
      rows = <Rows>[];
      json['rows'].forEach((v) {
        rows!.add(Rows.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['status'] = status;
    data['status_message'] = statusMessage;
    if (rows != null) {
      data['rows'] = rows!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
