import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:optimize_smart_delivery/config/controller/auth_controller.dart';
import 'package:optimize_smart_delivery/config/parser/data_parser_service.dart';
import 'package:optimize_smart_delivery/config/responsive/size_config.dart';
import 'package:optimize_smart_delivery/config/storage/data_store_service.dart';
import 'package:optimize_smart_delivery/config/theme/app_colors.dart';

class DriverDrawer extends StatelessWidget {
  DriverDrawer({Key? key}) : super(key: key);

  AuthController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          padding: EdgeInsets.all(10),
          width: kWidth * 0.7,
          height: kHeight,
          decoration: BoxDecoration(
            color: AppColors.appbackgroundColor,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 60.0,
                width: 60.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: AppColors.alterColor),
                child: Text(
                  "${dataParser.getFirstStringChar(controller.getToken())}",
                  style: TextStyle(
                      fontSize: 45,
                      fontWeight: FontWeight.bold,
                      color: AppColors.appbackgroundColor),
                ),
              ),
              SizedBox(height: 10),
              // Text(authmanager.checkLoginStatus(), style: headStyle),
              Text(dataParser.strToTitleCase(controller.getToken()), style: TextStyle(color: AppColors.alterColor, fontWeight: FontWeight.bold)),

              Divider(
                color: AppColors.alterColor,
              ),
              Spacer(),
              ListTile(
                title: Text(
                  'Log out',
                  style: TextStyle(color: AppColors.alterColor),
                ),
                leading: Icon(Icons.logout, color: AppColors.alterColor),
                onTap: () {
                  Get.defaultDialog(
                      backgroundColor: AppColors.appbackgroundColor,
                      title: "Logout?",
                      titlePadding: EdgeInsets.all(10),
                      titleStyle: TextStyle(
                          color: AppColors.textColor,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 5),
                      cancel: TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: Text(
                            "No",
                            style: TextStyle(
                                color: AppColors.alterColor,
                                fontSize: 20,
                                fontWeight: FontWeight.normal),
                          )),
                      confirm: TextButton(
                          onPressed: () async {
                            await controller.logout();
                          },
                          child: Text("Yes",
                              style: TextStyle(
                                  color: AppColors.alterColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal))),
                      content: SizedBox());
                },
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
