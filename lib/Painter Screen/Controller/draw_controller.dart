

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:painter/Painter%20Screen/View/home_screen.dart';

class DrawController extends GetxController
{
  RxBool check = false.obs;
  RxBool checkcolor = false.obs;
  RxBool fillcolor = false.obs;

  var currentcolor = Colors.amber.obs;
  var fill = Colors.amber.obs;

  RxDouble slidervalue = 0.0.obs;
  RxList<Drawingmodal?> points = <Drawingmodal>[].obs;


}