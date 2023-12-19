import 'package:coal_tracking_app/views/navigation_container.dart';
import 'package:coal_tracking_app/views/pages/login_folder/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/login_controller.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // var locationDB = LocationDatabase();
  // for (int i = 100; i < 200; i++) {
  //   LocationLogs location = LocationLogs(
  //       orderId: 'order$i',
  //       latitude: 40.7128,
  //       longitude: -74.0060,
  //       timestamp: DateTime.now().millisecondsSinceEpoch);
  //   await locationDB.insertLocation(location);
  // }

  // Retrieving location logs for a specific orderId
  // List<LocationLogs> order123Locations =
  //     await locationDB.getLocationsForOrder('order123');
  // print('Locations for order123: $order123Locations');
  //
  // // Retrieving all unique order IDs
  // List<String> allOrderIds = await locationDB.getAllOrderIds();
  // print('All Order IDs: $allOrderIds');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Coal Tracking App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: GetX<AuthController>(
        init: AuthController(),
        builder: (authController) {
          if (authController.authState == AuthState.authenticated) {
            return NavigationContainer(
              isMineOfficial: false,
            );
          } else {
            return const LoginPage();
          }
        },
      ),
    );
  }
}
