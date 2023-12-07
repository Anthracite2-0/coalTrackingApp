import 'package:coal_tracking_app/convert_latlang_to_address.dart';
import 'package:coal_tracking_app/current_location.dart';
import 'package:coal_tracking_app/custom_marker.dart';
import 'package:coal_tracking_app/custom_marker_info_window.dart';
import 'package:coal_tracking_app/custom_marker_with_network_image.dart';
import 'package:coal_tracking_app/google_search_places_api.dart';
import 'package:coal_tracking_app/polygone_screen.dart';
import 'package:coal_tracking_app/polyline_screen.dart';
import 'package:coal_tracking_app/polyline_two.dart';
import 'package:coal_tracking_app/views/pages/login_folder/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:coal_tracking_app/google_map_styling_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: LoginPage(),
    );
  }
}
