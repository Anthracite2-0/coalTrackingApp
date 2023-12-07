// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';

class SchemeSlider extends StatelessWidget {
  const SchemeSlider({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;

    List<String> scheme_image = [
      'images/digitalindia.jpg',
      'images/garibkalyan.jpg',
      'images/jandhan.jpeg',
    ];
    return SizedBox(
      height: width * 0.4,
      child: ListView.builder(
        itemCount: scheme_image.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => Card(
          elevation: 20,
          child: Container(
            margin: EdgeInsets.all(10),
            child: Image.asset(
              scheme_image[index],
              fit: BoxFit.contain,
            ),
            
          ),
        ),
      ),
    );
  }
}
