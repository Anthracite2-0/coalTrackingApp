// ignore_for_file: prefer_const_constructors

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class result_card extends StatefulWidget {
  final String title;
  final card_inf;

  const result_card({
    super.key,
    required this.title,
    required this.card_inf,
  });

  @override
  State<result_card> createState() => _result_cardState();
}

class _result_cardState extends State<result_card> {

  @override
  void initState() {
    widget.card_inf.shuffle();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return Center(
      child: Card(
        elevation: 20,
        color: Color(0xDDFFFFFF),
        child: Container(
            width: width * 0.95,
            height: height * 0.55,
            padding: EdgeInsets.all(width * 0.05),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(7)),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      widget.title,
                      style: TextStyle(
                        fontSize: width * 0.07,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Spacer(),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'View All',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: width * 0.04,
                          decoration: TextDecoration.underline,
                          color: Colors.blueGrey,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: width * 0.05,
                ),
                SizedBox(
                  height: height * 0.4,
                  child: ListView.builder(
                      padding: EdgeInsets.all(0),
                      itemCount: widget.card_inf.length,
                      // shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) => customtile(
                            height,
                            width,
                            widget.card_inf[index][0],
                            widget.card_inf[index][1],
                            widget.card_inf[index][2],
                            widget.card_inf[index][3]
                          )
                        ),
                )
              ],
            )),
      ),
    );
  }

  Future<void> _launchUrl(_url) async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  Widget customtile(height, width, img_url, text,text2,web_url) {
    return GestureDetector(
      onTap: () {
        _launchUrl(Uri.parse(web_url));
      },
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: width * 0.03),
          child: Row(
            children: [
              SizedBox(
                width: width * 0.05,
              ),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  // borderRadius: BorderRadius.all(Radius.circular(5))
                ),
                child: Image.asset(
                  img_url,
                  height: width * 0.09,
                  width: width * 0.09,
                ),
              ),
              SizedBox(
                width: width * 0.04,
              ),
              Text(
                text,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Spacer(),
              Text(
                text2,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                width: width * 0.04,
              ),
              Icon(Icons.arrow_forward_ios),
              SizedBox(
                width: width * 0.03,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
