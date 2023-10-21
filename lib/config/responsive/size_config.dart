import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme/app_colors.dart';

class SizeConfig {
  static double? screenWidth;
  static double? screenHeight;
  static double? blockSizeHorizontal;
  static double? blockSizeVertical;
  static double? _safeAreaHorizontal;
  static double? _safeAreaVertical;
  static double? safeBlockHorizontal;
  static double? safeBlockVertical;

  SizeConfig() {
    init();
  }

  void init() {
    screenWidth = Get.width;
    screenHeight = Get.height;
    blockSizeHorizontal = screenWidth! / 100;
    blockSizeVertical = screenHeight! / 100;
    _safeAreaHorizontal = screenWidth! * 0.05;
    _safeAreaVertical = screenHeight! * 0.05;
    safeBlockHorizontal = (screenWidth! - _safeAreaHorizontal!) / 100;
    safeBlockVertical = (screenHeight! - _safeAreaVertical!) / 100;
  }
}

Widget setHeight(double value) {
  return SizedBox(height: value);
}

Widget setWidth(double value) {
  return SizedBox(width: value);
}

double setHeightValue(double value){
  return (0.001 * value) * kHeight;
}
double setWidthValue(double value){
  return (0.001 * value) * kWidth;
}
var kHeight = Get.height;
var kWidth = Get.width;

class TextScalingFactors {
  final double? display4ScaledSize;
  final double? display3ScaledSize;
  final double? display2ScaledSize;
  final double? display1ScaledSize;
  final double? headlineScaledSize;
  final double? titleScaledSize;
  final double? subtitleScaledSize;
  final double? body2ScaledSize;
  final double? body1ScaledSize;
  final double? captionScaledSize;
  final double? buttonScaledSize;
  final double? buttonTextSize;

  TextScalingFactors(
      {required this.display4ScaledSize,
      required this.display3ScaledSize,
      required this.display2ScaledSize,
      required this.display1ScaledSize,
      required this.headlineScaledSize,
      required this.titleScaledSize,
      required this.subtitleScaledSize,
      required this.body2ScaledSize,
      required this.body1ScaledSize,
      required this.captionScaledSize,
      required this.buttonScaledSize,
      required this.buttonTextSize});
}

TextTheme buildAppTextTheme(
    {required TextTheme customTextTheme,
    required TextScalingFactors scaledText}) {
  return customTextTheme
      .copyWith(
        headlineLarge: customTextTheme.headlineLarge!.copyWith(
            fontSize: scaledText.display4ScaledSize,
            color: AppColors.textColor,
            overflow: TextOverflow.clip),
        headlineMedium: customTextTheme.headlineMedium!.copyWith(
            fontSize: scaledText.display3ScaledSize,
            color: AppColors.textColor,
            overflow: TextOverflow.clip),
        headlineSmall: customTextTheme.headlineSmall!.copyWith(
            fontSize: scaledText.display2ScaledSize,
            color: AppColors.textColor,
            overflow: TextOverflow.clip),
        titleLarge: customTextTheme.titleLarge!.copyWith(
            fontSize: scaledText.display1ScaledSize,
            color: AppColors.textColor,
            overflow: TextOverflow.clip),
        titleMedium: customTextTheme.titleMedium!.copyWith(
            fontSize: scaledText.headlineScaledSize,
            color: AppColors.textColor,
            overflow: TextOverflow.clip),
        titleSmall: customTextTheme.titleSmall!.copyWith(
            fontSize: scaledText.titleScaledSize,
            color: AppColors.textColor,
            overflow: TextOverflow.clip),
        labelLarge: customTextTheme.labelLarge!.copyWith(
            fontSize: scaledText.buttonScaledSize,
            color: AppColors.textColor,
            overflow: TextOverflow.clip),
        labelMedium: customTextTheme.labelMedium!.copyWith(
            fontSize: scaledText.subtitleScaledSize,
            color: AppColors.textColor,
            overflow: TextOverflow.clip),
        labelSmall: customTextTheme.labelSmall!.copyWith(
            fontSize: scaledText.body2ScaledSize,
            color: AppColors.textColor,
            overflow: TextOverflow.clip),
        bodyLarge: customTextTheme.bodyLarge!.copyWith(
            fontSize: scaledText.body1ScaledSize,
            color: AppColors.textColor,
            overflow: TextOverflow.clip),
        bodyMedium: customTextTheme.bodyMedium!.copyWith(
            fontSize: scaledText.captionScaledSize,
            color: AppColors.textColor,
            overflow: TextOverflow.clip),
        bodySmall: customTextTheme.bodySmall!.copyWith(
            fontSize: scaledText.buttonTextSize,
            color: AppColors.textColor,
            overflow: TextOverflow.clip),
      )
      .apply(
        bodyColor: AppColors.textColor,
        fontFamily: 'Lato',
      );
}
