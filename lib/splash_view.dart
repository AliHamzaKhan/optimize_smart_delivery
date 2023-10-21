import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:optimize_smart_delivery/config/routes/app_routes.dart';
import 'config/controller/auth_controller.dart';
import 'config/theme/app_colors.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.appbackgroundColor,
        body: SizedBox(
          height: Get.height,
          width: Get.width,
          child: Stack(
            children: [

              Image.asset(
                height: Get.height,
                width: Get.width,
                'assets/images/app_logo.jpg',
                fit: BoxFit.cover,
              )
            ],
          ),
        ));
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1500), () {
      var userAvailable = Get.find<AuthController>().checkUser();
      if (userAvailable) {
        Get.offAllNamed(AppRoutes.orderListingView);
      } else {
        Get.offAllNamed(AppRoutes.login);
      }
    });
  }
}
