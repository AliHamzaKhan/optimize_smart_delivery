import 'package:flutter/material.dart';

import 'app_colors.dart';

ThemeData darkTheme = ThemeData(
    secondaryHeaderColor: AppColors.alterColor,
    brightness: Brightness.dark,
    primaryColor: AppColors.appbackgroundColor,
    buttonTheme: ButtonThemeData(
      buttonColor: AppColors.alterColor,
      disabledColor: AppColors.subBackgroundColor,
    ));

ThemeData lightTheme = ThemeData(
    secondaryHeaderColor: AppColors.alterColorLight,
    brightness: Brightness.light,
    primaryColor: AppColors.appbackgroundColorLight,
    buttonTheme: ButtonThemeData(
      buttonColor: AppColors.alterColorLight,
      disabledColor: AppColors.subBackgroundColorLight,
    ));

// usage
// backgroundColor: context.theme.backgroundColor,
