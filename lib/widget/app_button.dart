import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:optimize_smart_delivery/config/responsive/size_config.dart';

import '../config/theme/app_colors.dart';

//ignore: must_be_immutable
class AppButton extends StatelessWidget {
  AppButton(
      {required this.title,
      required this.onTap,
      this.isOutline = false,
      this.btnColor,
      this.textColor,
      this.btnRadius,
      this.btnWidth,
      this.btnHeight,
      this.textSize,
      this.shadow,
      this.shadow1,
      this.isShadow = true});

final  String title;
  var onTap;
  final bool isOutline;
  Color? btnColor;
  Color? textColor;
  double? btnRadius;
  double? btnWidth;
  double? btnHeight;
  double? textSize;
  double? shadow;
  double? shadow1;
 final bool isShadow;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: btnHeight ?? 45,
        width: btnWidth ?? Get.width,
        margin: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5
        ),

        decoration: BoxDecoration(
          color: isOutline
              ? AppColors.appbackgroundColor
              : (btnColor ?? AppColors.alterColor),
          borderRadius: BorderRadius.circular(btnRadius ?? 20),
          border: Border.all(
              color: isOutline
                  ? (btnColor ?? AppColors.alterColor)
                  : Colors.transparent),
          boxShadow: isShadow
              ? [
                  BoxShadow(
                    color: AppColors.subBackgroundColor.withOpacity(0.5),
                    spreadRadius:shadow ?? 3,
                    blurRadius: shadow1 ?? 5,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ]
              : [],
        ),
        alignment: Alignment.center,
        child : Text(
            title,
          style: TextStyle(fontSize: textSize ?? 18, fontWeight: FontWeight.w700, color: textColor ?? AppColors.appbackgroundColor ),
        )

      ),
    );
  }
}

//ignore: must_be_immutable
class AppIconButton extends StatelessWidget {
  AppIconButton({
    required this.title,
    required this.onTap,
    required this.icon,
    this.isOutline = false,
    this.btnColor,
    this.textColor,
    this.iconColor,
    this.borderColor,
    this.btnRadius,
    this.iconSize,
    this.btnWidth,
    this.btnHeight,
    this.padding,
    this.margin,
    this.centerPadding,
    this.textSize,
    this.alignment,
  });

  String title;
  var onTap;
  bool isOutline;
  Color? btnColor;
  Color? textColor;
  Color? iconColor;
  Color? borderColor;
  double? btnRadius;
  double? iconSize;
  double? btnWidth;
  double? btnHeight;
  double? textSize;
  double? padding;
  double? centerPadding;
  double? margin;
  IconData icon;
  MainAxisAlignment? alignment;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: setHeightValue(btnHeight ?? 50),
        width: btnWidth ?? kWidth,
        padding: EdgeInsets.symmetric(
          horizontal: setWidthValue(padding ?? 12),
        ),
        margin: EdgeInsets.symmetric(
          horizontal: margin ?? 12,
        ),
        decoration: BoxDecoration(
            color: btnColor ?? Colors.transparent,
            borderRadius: BorderRadius.circular(setHeightValue(btnRadius ?? 5)),
            border:isOutline ? Border.all(color:borderColor ?? AppColors.alterColor, width: 1): null) ,
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment:alignment ?? MainAxisAlignment.spaceBetween,
          children: [
            Text(
                title,
              style: TextStyle(
                color: textColor ?? AppColors.textColor,
                fontSize: setHeightValue(textSize ?? 18),
                fontWeight: FontWeight.bold
              ),
            ),
            setWidth(centerPadding ?? 0),
            Icon(
              icon,
              size: setHeightValue(iconSize ?? 15),
              color: iconColor ?? AppColors.textColor,
            )
          ],
        ),
      ),
    );
  }
}

PbBackButton({icon, iconColor, backgroundColor, size, iconSize,onTap, margin, radius}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: size ?? 17,
      height: size ?? 17,
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: margin ?? 0,
      vertical: margin ?? 0
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular((radius ?? 17) / 2),
          color: backgroundColor ?? AppColors.subBackgroundColor),
      child: Icon(
        icon ?? Icons.arrow_back,
        color: iconColor ?? AppColors.alterColor,
        size: iconSize ?? 12,
      ),
      // child: Image.asset(
      //   color: AppColors.accent,
      //   AssetsConstant.back_arrow,
      //   width: setHeightValue(size ?? 17),
      //   height: setHeightValue(size ?? 17),
      //   fit: BoxFit.cover,
      // ),
    ),
  );
}
