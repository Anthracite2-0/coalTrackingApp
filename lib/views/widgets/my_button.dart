import 'package:coal_tracking_app/utils/constants.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;
  final double h;
  final double w;
  final Color bgColor;
  final Color textColor;
  final VoidCallback onTap;

  const MyButton({
    super.key,
    required this.onTap,
    this.text = "",
    required this.h,
    required this.w,
    this.bgColor = dark,
    this.textColor = Colors.white,
  });

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
          color: bgColor,
          borderRadius: BorderRadius.circular(height * 0.01),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: height * 0.02,
            ),
          ),
        ),
      ),
    );
  }
}
