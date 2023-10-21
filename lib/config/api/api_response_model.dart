

import 'dart:convert';

import 'package:optimize_smart_delivery/config/parser/data_parser_service.dart';


class ApiResponseModel {
  bool isSuccess;
  String message;
  int statusCode;
  dynamic data;
  dynamic rows;
  String? token;
  String? status;



  ApiResponseModel({
    required this.isSuccess,
    required this.message,
    required this.statusCode,
    required this.data,
     this.rows,
    this.token,
    this.status
  });

  ApiResponseModel copyWith({
    bool? isSuccess,
    String? message,
    int? statusCode,
    dynamic data,
    dynamic rows,
    String? token,
    String? status,
  }) {
    return ApiResponseModel(
      isSuccess: isSuccess ?? this.isSuccess,
      message: message ?? this.message,
      statusCode: statusCode ?? this.statusCode,
      data: data ?? this.data,
      rows: rows ?? this.rows,
      token: token ?? this.token,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'isSuccess': isSuccess,
      'message': message,
      'statusCode': statusCode,
      'data': data,
      'rows': rows,
      'status': status,
      'token': token,
    };
  }

  factory ApiResponseModel.fromMap(Map<String, dynamic> map) {
    return ApiResponseModel(
        isSuccess: (map['status'] ?? '') != 'success' ? false : true,
        message: dataParser.getString(map['status_message'] ?? ''),
        statusCode: map['message'] ?? 400,
        status: dataParser.getString(map['status'] ?? ''),
        data: map,
         rows: map['rows'] ?? '',
        token: map['token'] != null ? map['token'] as String : null,

    );
  }

  String toJson() => json.encode(toMap());

  factory ApiResponseModel.fromJson(String source) =>
      ApiResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ApiResponseModel(isSuccess: $isSuccess, message: $message, statusCode: $statusCode, data: $data, token: $token)';
  }
}