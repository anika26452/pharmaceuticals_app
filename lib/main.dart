import 'package:flutter/material.dart';
import 'package:gentry_pharmaceuticals_app/src/modules/splash_screen.dart';
import 'package:gentry_pharmaceuticals_app/src/utils/colors.dart';
import 'package:gentry_pharmaceuticals_app/src/utils/route_pages.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Gentry Pharamceuticals App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColor.appcolor,
      ),
      home: SplashScreen(),
      getPages: RoutePages.routes,
    );
  }
}
