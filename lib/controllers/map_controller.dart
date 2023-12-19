import 'package:coal_tracking_app/interface/backend_interface.dart';
import 'package:coal_tracking_app/models/map_screen_request_model.dart';
import 'package:coal_tracking_app/models/map_screen_response_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MapController extends GetxController {
  var isLoading = false.obs;
  var initialLtd = "".obs;
  var initialLong = "".obs;
  var finalLat = "".obs;
  var finalLong = "".obs;

  //var mapScreenResponseModel;

  final storage = const FlutterSecureStorage();

  @override
  void onInit() async {
    super.onInit();
    getMapData();
  }

  void rideStarted() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("rideStarted", true);
  }

  void rideEnded() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("rideStarted", false);
  }

  Future<bool> getRideStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.reload();
    print("rideStarted: ${prefs.getBool("rideStarted")} ");
    return prefs.getBool("rideStarted") ?? false;
  }

  Future<void> getMapData() async {
    try {
      isLoading(true);
      MapScreenRequestModel mapScreenRequestModel =
          MapScreenRequestModel(mobile: "9876567898", orderId: "10");
      MapScreenResponseModel mapScreenResponseModel =
          await BackendInterface.mapScreen(mapScreenRequestModel);
      initialLtd.value = mapScreenResponseModel.data!.initialLat!.toString();
      initialLong.value = mapScreenResponseModel.data!.initialLong!.toString();
      finalLat.value = mapScreenResponseModel.data!.finalLat!.toString();
      finalLong.value = mapScreenResponseModel.data!.finalLong!.toString();
    } finally {
      isLoading(false);
    }
    return;
  }

  // Future<void> sendCoordinates(String lat, String long) async {
  //   try {
  //     isLoading(true);
  //     SendCoordinatesRequestModel sendCoordinatesRequestModel =
  //         SendCoordinatesRequestModel(currentLat: lat, currentLong: long);
  //     SendCoordinatesResponseModel sendCoordinatesResponseModel =
  //         await BackendInterface.sendCoordinates(
  //             sendCoordinatesRequestModel, "10");
  //   } finally {
  //     isLoading(false);
  //   }
  //   return;
  // }
}
