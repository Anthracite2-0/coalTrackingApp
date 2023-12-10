import 'dart:convert';

import 'package:coal_tracking_app/models/user_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ProfileController extends GetxController {
  Rx<UserData?> userData = Rx<UserData?>(null);
  RxBool isLoading = RxBool(false);
  Future<void> fetchProfileData(String mobileNumber) async {
    final url =
        'http://192.168.29.111:3000/api/v1/drivers/mobile/$mobileNumber';
    isLoading.value = true;
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        userData.value = UserData.fromJson(jsonData['data']);
      } else {
        userData.value = null;
      }
    } catch (e) {
      userData.value = null;
    }
    isLoading.value = false;
  }
}
