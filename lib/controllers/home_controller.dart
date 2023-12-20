import 'dart:async';

import 'package:coal_tracking_app/models/all_orders_driver.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  RxBool isLoading = RxBool(false);
  RxBool isLocationServiceEnabled = RxBool(false);
  RxBool isLocationPermissionGranted = RxBool(false);
  RxBool isLocationServiceRequesting = RxBool(false);
  RxBool isLocationServiceRequestingDenied = RxBool(false);
  RxBool isLocationServiceRequestingPermanentlyDenied = RxBool(false);
  RxBool isLocationServiceRequestingPermanentlyDeniedAndNeverAskAgain =
      RxBool(false);
  RxBool isLocationServiceRequestingPermanentlyDeniedAndNeverAskAgainIOS =
      RxBool(false);
  RxBool isLocationServiceRequestingIOS = RxBool(false);
  RxBool isLocationServiceRequestingDeniedIOS = RxBool(false);
  RxBool isLocationServiceRequestingPermanentlyDeniedIOS = RxBool(false);
  RxBool isLocationServiceRequestingDeniedAndroid = RxBool(false);
  RxBool isLocationServiceRequestingPermanentlyDeniedAndroid = RxBool(false);
  RxBool isLocationServiceRequestingPermanentlyDeniedAndNeverAskAgainAndroid =
      RxBool(false);

  RxBool isRiding = RxBool(false);
  RxBool isRidingLoading = RxBool(false);
  Rx<AllOrdersDriver> allOrders = AllOrdersDriver(count: 0, rows: []).obs;

  Rx<DateTime> currentTime = DateTime.now().obs;
  @override
  void onInit() {
    super.onInit();
    // Start a timer to update the time every second
    Timer.periodic(const Duration(seconds: 1), _updateTime);
  }

  // Future<void> checkLocationService() async {
//   isLocationServiceEnabled.value = await ;
// }
//
// Future<void> checkLocationPermission() async {
//   isLocationPermissionGranted.value = await FlutterBackgroundService.hasPermissions();
// }
  Future<void> setRidingTrue() async {
    isRidingLoading.value = true;
    isRiding.value = true;
    // await FlutterBackgroundService.start();
    isRidingLoading.value = false;
  }

  Future<void> setRidingFalse() async {
    isRidingLoading.value = true;
    isRiding.value = false;
    // await FlutterBackgroundService.stop();
    isRidingLoading.value = false;
  }

  Future<bool> checkRiding() async {
    return isRiding.value;
  }

  Future<void> getAllOrders() async {
    try {
      final res = await http.get(
        Uri.parse(
          'https://admin-server-production-a272.up.railway.app/api/v1/drivers/rides/9',
        ),
      );
      if (res.statusCode == 200) {
        allOrders = allOrdersDriverFromJson(res.body).obs;
      } else {
        print(res.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }

  void _updateTime(Timer timer) async {
    currentTime = DateTime.now().obs;
  }
}
