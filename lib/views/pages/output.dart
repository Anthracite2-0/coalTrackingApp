import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class Output extends StatefulWidget {
  final String? riddle;
  const Output({Key? key, this.riddle}) : super(key: key);

  @override
  State<Output> createState() => _OutputState();
}

class _OutputState extends State<Output> {
  @override
  void initState() {
    super.initState();
    // if (widget.riddle == null) {
    //   Get.to(Home());
    // }
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Text("${widget.riddle}"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
