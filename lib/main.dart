import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:painter/Painter%20Screen/View/home_screen.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(
    Sizer(
      builder: (context, orientation, deviceType) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/':(p0) => HomeScreen(),
        },
      ),
    ),
  );
}
