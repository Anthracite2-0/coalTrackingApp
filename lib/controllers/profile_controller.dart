import 'dart:convert';

import 'package:coal_tracking_app/models/user_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ProfileController extends GetxController {
  Rx<UserData?> userData = Rx<UserData?>(null);
  RxBool isLoading = RxBool(false);
  Future<void> fetchProfileData(String mobileNumber) async {
    print("object");
    final url =
        'https://admin-server-production-a272.up.railway.app/api/v1/drivers/mobile/$mobileNumber';
    isLoading.value = true;
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        userData.value = UserData.fromJson(jsonData['data']);
        print("userData: ${userData.value!.toJson()}");
      } else {
        userData.value = null;
        print("${response.statusCode}");
      }
    } catch (e) {
      userData.value = null;
      print("Error: $e");
    }
    isLoading.value = false;
  }
}
