import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ScreenUtilInit(
      designSize: Size(392.73, 738.18),
      child: GetMaterialApp(title: "Application", initialRoute: AppPages.INITIAL, getPages: AppPages.routes, debugShowCheckedModeBanner: false),
    ),
  );
}
