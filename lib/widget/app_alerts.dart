import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../config/theme/app_colors.dart';
import 'app_button.dart';

typedef SuccessCallback = void Function(dynamic data);
typedef OnChangeCallback = void Function(bool? val);
typedef AlertSuccessCallback = void Function();

enum AlertTypes {
  info,
  warning,
  error,
  alert,
  connectivity,
  congrats,
  success,
  logout,
}

class AppAlerts {
  customAlert({
    String? title,
    String? subTitle,
    String? message,
    AlertSuccessCallback? callback,
    AlertSuccessCallback? cancelCallback,
    AlertSuccessCallback? otherCallback,
    AlertTypes alertTypes = AlertTypes.info,
    String? cancelText,
    String? okText,
    String? otherActionText,
    bool showCheckbox = false,
    bool checkBoxValue = false,
    OnChangeCallback? onChangeCallback,
  }) async {
    List<Widget> getBtns(BuildContext context) {
      return [
        AppButton(
            onTap: () {
              Get.back();
              if (callback != null) {
                callback();
              }
            },
            title: okText ?? (alertTypes == AlertTypes.warning ? 'Yes' : 'OK'),
            btnWidth: 80),
        if (otherCallback != null &&
            otherActionText != null &&
            otherActionText.isNotEmpty) ...[
          const SizedBox(
            width: 8,
            height: 10,
          ),
          AppButton(
            onTap: () {
              Get.back();
              otherCallback();
            },
            title: otherActionText,
            textColor: AppColors.appbackgroundColor,
            btnColor: AppColors.alterColor,
            btnWidth: 100,
          ),
        ],
        if (cancelCallback != null) ...[
          const SizedBox(
            width: 8,
            height: 10,
          ),
          AppButton(
            onTap: () {
              Get.back();
              cancelCallback();
            },
            title: cancelText ??
                (alertTypes == AlertTypes.warning ? 'No' : 'Cancel'),
            textColor: AppColors.appbackgroundColor,
            btnColor: AppColors.alterColor,
            btnWidth: 100,
          ),
        ],
      ];
    }

    if (Get.isDialogOpen == false) {
      await Get.defaultDialog(
        radius: 10,
        barrierDismissible: false,
        title: '',
        titlePadding: const EdgeInsets.all(0),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        content: StatefulBuilder(
          builder: (context, setState) {
            return Container(
              padding: const EdgeInsets.all(5),
              width: Get.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 5),
                  if (alertTypes == AlertTypes.warning) ...[
                    Icon(
                      Icons.warning_amber_rounded,
                      size: 40,
                      color: AppColors.alterColor,
                    )
                  ] else if (alertTypes == AlertTypes.error) ...[
                    Icon(
                      Icons.error_outline_outlined,
                      size: 40,
                      color: AppColors.alterColor,
                    )
                  ] else if (alertTypes == AlertTypes.info) ...[
                    Icon(
                      Icons.info_outline_rounded,
                      size: 40,
                      color: AppColors.alterColor,
                    )
                  ] else if (alertTypes == AlertTypes.connectivity) ...[
                    Icon(
                      Icons.wifi_2_bar_rounded,
                      size: 40,
                      color: AppColors.alterColor,
                    )
                  ] else if (alertTypes == AlertTypes.success) ...[
                    Icon(
                      Icons.circle_notifications_rounded,
                      size: 40,
                      color: AppColors.alterColor,
                    )
                  ] else if (alertTypes == AlertTypes.congrats) ...[
                    Icon(
                      Icons.heat_pump,
                      size: 40,
                      color: AppColors.alterColor,
                    )
                  ] else if (alertTypes == AlertTypes.logout) ...[
                    Icon(
                      Icons.logout,
                      size: 40,
                      color: AppColors.alterColor,
                    )
                  ] else if (alertTypes == AlertTypes.alert) ...[
                    Icon(
                      Icons.add_alert_outlined,
                      size: 40,
                      color: AppColors.alterColor,
                    )
                  ],
                  const SizedBox(height: 10),
                  if (title != null && title.isNotEmpty) ...[
                    const SizedBox(height: 5),
                    Text(
                      title,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    ),
                  ],
                  if (subTitle != null && subTitle.isNotEmpty) ...[
                    const SizedBox(height: 5),
                    Text(subTitle,
                        style: const TextStyle(
                          fontSize: 18,
                          overflow: TextOverflow.clip,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 3)

                    // Text(
                    //   subTitle,
                    //   textAlign: TextAlign.center,
                    //   style: pbTextStyleMedium(size: 18),
                    // ),
                  ],
                  if (message != null && message.isNotEmpty) ...[
                    const SizedBox(height: 5),
                    Text(
                      message,
                      maxLines: 3,
                      style: const TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  ],
                  const SizedBox(height: 10),
                  if (showCheckbox) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Checkbox(
                            value: checkBoxValue,
                            onChanged: (val) {
                              setState(() {
                                checkBoxValue = !checkBoxValue;
                              });
                              onChangeCallback!.call(val);
                            }),
                        const Text('Enable Recurring Payment'),
                      ],
                    )
                  ],
                  const SizedBox(height: 10),
                  getBtns(context).length > 4
                      ? isWeb()
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: getBtns(context),
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: getBtns(context),
                            )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: getBtns(context),
                        )
                ],
              ),
            );
          },
        ),
      );
    }
  }

  bool isWeb() {
    return kIsWeb;
  }
}

AppAlerts appAlerts = AppAlerts();
