import 'package:flutter/material.dart';
import 'package:coal_tracking_app/utils/constants.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class MyButton extends StatelessWidget {
  final Function()? onTap;
  final String text;
  final double h;
  final double w;
  final bgcolor;
  final textcolor;

  const MyButton(
      {super.key,
      required this.onTap,
      this.text = "",
      required this.h,
      required this.w,
      this.bgcolor = dark,
      this.textcolor = Colors.white});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: w,
        height: h,

        //padding: const EdgeInsets.all(20),
        //margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: bgcolor,
          borderRadius: BorderRadius.circular(height * 0.01),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: textcolor,
              fontWeight: FontWeight.bold,
              fontSize: height * 0.02,
            ),
          ),
        ),
      ),
    );
  }
}
