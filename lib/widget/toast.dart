import 'package:flutter/material.dart';
import 'package:optimize_smart_delivery/config/theme/app_colors.dart';

apiUpdateToast(context, String? title, String? message, {int? seconds}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: AppColors.alterColor,
    content: Text("$title updated $message "),
    duration: Duration(seconds: seconds ?? 2),
  ));
}

appToast(context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(backgroundColor: AppColors.alterColor, content: Text(message)));
}
