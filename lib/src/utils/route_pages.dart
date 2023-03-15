
import 'package:gentry_pharmaceuticals_app/src/modules/login.dart';
import 'package:gentry_pharmaceuticals_app/src/modules/splash_screen.dart';
import 'package:gentry_pharmaceuticals_app/src/utils/routes.dart';
import 'package:get/get.dart';


class RoutePages{
  static const INITIAL = Routes.splashscreen;

  static final routes = [
    GetPage(name: Routes.splashscreen, page: () => SplashScreen()),
    GetPage(name: Routes.login, page: () => LoginScreen()),
    // GetPage(name: Routes.home, page: () => MenuView()),
    // GetPage(name: Routes.customer, page: () => Customers()),
    // GetPage(name: Routes.doctor, page: () => Doctors()),
    // GetPage(name: Routes.product, page: () => Products()),
  ];
}