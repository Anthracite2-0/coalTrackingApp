import 'package:flutter/material.dart';

class ImageButton extends StatelessWidget {
  final String imgUrl;
  final String buttonName;

  const ImageButton({
    super.key,
    required this.imgUrl,
    required this.buttonName,
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
                imgUrl,
                height: width * 0.14,
                width: width * 0.14,
                fit: BoxFit.contain,
              ),
              Text(
                buttonName,
                style: TextStyle(
                  color: Colors.black,
                ),
              )
            ],
          ),
        ),
        SizedBox(
          width: width * 0.02,
        )
      ],
    );
  }
}
