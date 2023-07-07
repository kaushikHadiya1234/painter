import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:painter/Painter%20Screen/Controller/draw_controller.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

 DrawController controller = Get.put(DrawController());
 GlobalKey key = GlobalKey();

 @override
 Widget build(BuildContext context) {
   return SafeArea(
     child: Scaffold(
       key: key,
      body: Stack(
        children: [
          GestureDetector(
            onPanStart: (details) {
              RenderBox? renderBox =
              context.findRenderObject() as RenderBox?;
              setState(() {
                controller.points.add(Drawingmodal(
                    Paint()
                      ..color =  controller.currentcolor.value
                      ..strokeCap = StrokeCap.round
                      ..strokeWidth = controller.slidervalue.value
                      ..isAntiAlias = true,
                    renderBox!.globalToLocal(details.globalPosition)));
              });

            },
            onPanEnd: (details) {
              setState(() {
                controller.points.add(Drawingmodal(Paint(),Offset.infinite));
              });
            },
            onPanUpdate: (details) {
              setState(() {
                RenderBox? renderBox =
                context.findRenderObject() as RenderBox?;
                controller.points.add(Drawingmodal(
                    Paint()
                      ..color = controller.currentcolor.value
                      ..strokeCap = StrokeCap.round
                      ..strokeWidth = controller.slidervalue.value
                      ..isAntiAlias = true,
                    renderBox!.globalToLocal(details.globalPosition)));
              });
            },
            child: CustomPaint(
              size: Size.infinite,
              painter: PaintClass(pointsList: controller.points),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Obx(
              () =>  Container(
                  margin: EdgeInsets.all(5.sp),
                  height: controller.check.value || controller.checkcolor.value || controller.fillcolor.value?15.h:7.h ,
                  width: 90.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.sp),
                    color: Colors.cyan.shade200,
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(onTap: () {
                              controller.check.value = !controller.check.value;
                              controller.checkcolor.value=false;
                              controller.fillcolor.value=false;
                            },child: Icon(Icons.draw)),
                            IconButton(onPressed: () {
                              controller.fillcolor.value =!controller.checkcolor.value;
                              controller.check.value=false;
                              controller.checkcolor.value=false;
                            },icon: Icon(Icons.format_color_fill)),
                            InkWell(onTap: () {
                              controller.checkcolor.value =!controller.checkcolor.value;
                              controller.check.value=false;
                              controller.fillcolor.value=false;
                            },child: Icon(Icons.palette)),
                            Icon(Icons.camera),
                            IconButton(onPressed: () {
                              controller.points.clear();
                            },icon: Icon(Icons.clear)),
                          ],
                        ),
                        Obx(
                          () =>  Visibility(
                            visible: controller.check.value?true:false,
                            child: Slider(value: controller.slidervalue.value, onChanged: (value) {
                              controller.slidervalue.value=value;
                            },
                            min: 0,
                              max: 20,
                              divisions: 20,
                            ),
                          ),
                        ),
                    Obx(
                      () =>  Visibility(
                        visible: controller.checkcolor.value|| controller.fillcolor.value?true:false,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () {
                                controller.currentcolor.value= Colors.red;
                              },
                              child: Container(
                                height: 4.h,
                                width: 4.h,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.red
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                controller.currentcolor.value=Colors.yellow;
                              },
                              child: Container(
                                height: 4.h,
                                width: 4.h,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.yellow
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                controller.currentcolor.value=Colors.green;
                              },
                              child: Container(
                                height: 4.h,
                                width: 4.h,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.green
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                controller.currentcolor.value=Colors.pink;
                              },
                              child: Container(
                                height: 4.h,
                                width: 4.h,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.pink
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                controller.currentcolor.value=Colors.teal;
                              },
                              child: Container(
                                height: 4.h,
                                width: 4.h,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.teal
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                      ],
                    ),
                  ),
                ),
            ),
            ),
        ],
      ),
    ),);
  }
}

class Drawingmodal {
  Paint paint;
  Offset offset;

  Drawingmodal(this.paint, this.offset);
}

 class PaintClass extends CustomPainter
{
  List<Drawingmodal?>? pointsList;
  PaintClass({this.pointsList});
  List<Offset>? offsetPoints = [];
  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < pointsList!.length - 1; i++) {
      if (pointsList![i] != null && pointsList![i + 1] != null) {
        canvas.drawLine(pointsList![i]!.offset, pointsList![i +1]!.offset ,
            pointsList![i]!.paint);
      } else if (pointsList![i] != null && pointsList![i + 1] == null) {
        offsetPoints!.clear();
        offsetPoints!.add(pointsList![i]!.offset);
        offsetPoints!.add(Offset(
            pointsList![i]!.offset.dx + 0.1, pointsList![i]!.offset.dy + 0.1));
        canvas.drawPoints(PointMode.points, offsetPoints!, pointsList![i]!.paint);
      }
    }
  }
  @override
  bool shouldRepaint(PaintClass oldDelegate) => oldDelegate.pointsList!=pointsList;

}
// check.value = !check.value;