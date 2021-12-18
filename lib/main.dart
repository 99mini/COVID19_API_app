import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:public_api_app/src/controllers/covid_statistics_controller.dart';

import 'src/app.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Covid Statistics',
      initialBinding: BindingsBuilder(() {
        Get.put(CovidStatisticsController());
      }),
      theme: ThemeData(
        primarySwatch: const MaterialColor(0xFFffffff, {
          50: Color(0xffffffff),
          100: Color(0xffffffff),
          200: Color(0xffffffff),
          300: Color(0xffffffff),
          400: Color(0xffffffff),
          500: Color(0xffffffff),
          600: Color(0xffffffff),
          700: Color(0xffffffff),
          800: Color(0xffffffff),
          900: Color(0xffffffff),
        }),
        primaryColor: Colors.white,
      ),
      home: App(),
    );
  }
}
