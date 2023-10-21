import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'config/binding/app_binding.dart';
import 'config/controller/app_controller.dart';
import 'config/controller/auth_controller.dart';
import 'config/controller/location_service.dart';
import 'config/routes/app_routes.dart';
import 'config/theme/app_theme.dart';

void main()  {
  GetStorage.init();
  Get.put(LocationService(), permanent: true);
  Get.put(AuthController());
  Get.put(AppController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Smart Delivery',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.light,
      // initialBinding: AppBinding(),
      getPages: AppPages.routes,
      initialRoute: AppPages.initial,
      builder: EasyLoading.init(),
    );
  }
}
