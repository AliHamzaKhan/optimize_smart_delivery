import 'package:get/get.dart';
import 'package:optimize_smart_delivery/modules/registry/view/register_view.dart';
import 'package:optimize_smart_delivery/splash_view.dart';
import '../../modules/order/binding/order_binding.dart';
import '../../modules/order/view/order_listing_view.dart';
import '../../modules/order/view/order_running_view.dart';
import '../../modules/registry/binding/registry_binding.dart';
import '../../modules/registry/view/login_view.dart';

abstract class AppPages {
  static const String initial = AppRoutes.splashView;
  static final routes = [
    GetPage(name: AppRoutes.splashView, page: () => SplashView()),
    GetPage(name: AppRoutes.login, page: () => LoginView(), binding: RegistryBinding()),
    GetPage(name: AppRoutes.register, page: () => RegisterView(), binding: RegistryBinding()),
    GetPage(
        name: AppRoutes.orderListingView,
        page: () => OrderListingView(),
        binding: OrderBinding(),
        children: [
          GetPage(
              name: AppRoutes.orderRunning,
              page: () => OrderRunningView()),
        ]
    ),

  ];
}

abstract class AppRoutes {
  AppRoutes();
  static const String splashView = '/splash_view';
  static const String login = '/login_view';
  static const String register = '/register_view';
  static const String orderListingView = '/order_listing_view';
  static const String orderRunning = '/order_running_view';
  static const String orderRunningView = orderListingView + orderRunning;
}
