import 'package:coal_tracking_app/views/pages/google_map_utils/convert_latlang_to_address.dart';

import 'package:coal_tracking_app/views/navigation_container.dart';
import 'package:coal_tracking_app/views/pages/google_map_utils/current_location.dart';
import 'package:coal_tracking_app/views/pages/google_map_utils/custom_marker_info_window.dart';
import 'package:coal_tracking_app/views/pages/map_screen.dart';
import 'package:coal_tracking_app/views/pages/homepage.dart';
import 'package:coal_tracking_app/views/pages/login_folder/login_page.dart';
import 'package:coal_tracking_app/views/pages/trip_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:coal_tracking_app/google_map_styling_screen.dart';
import 'package:get/get_navigation/get_navigation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
        ),
        home: LoginPage());
  }
}
