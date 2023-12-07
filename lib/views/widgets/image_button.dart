import 'package:flutter/material.dart';

class imagebutton extends StatelessWidget {
  final img_url;
  final button_name;

  const imagebutton({
    super.key,
    required this.img_url,
    required this.button_name,
  });

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;


    return Row(
      children: [
        OutlinedButton(
          onPressed: () => {},
          style: ButtonStyle(
            elevation: MaterialStateProperty.all(5),
            backgroundColor: MaterialStateProperty.all(Colors.white),
          ),
          child: Column(
            children: [
              Image.asset(
                img_url,
                height: width*0.14,
          width: width*0.14,
                fit: BoxFit.contain,
              ),
              Text(
                button_name,
                style: TextStyle(
                  color: Colors.black,
                ),
              )
            ],
          ),
        ),
        SizedBox(width: width*0.02,)
      ],
    );
  }
}
