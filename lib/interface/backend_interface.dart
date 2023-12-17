import 'dart:convert';
import 'dart:io';

import 'package:coal_tracking_app/models/accept_ride_model.dart';
import 'package:coal_tracking_app/models/accept_ride_response.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:http/http.dart' as http;

class BackendInterface {
  static var client = http.Client();
  final storage = FlutterSecureStorage();

  static Future<AcceptRideResponseModel> accept(AcceptRideModel model) async {
    // await Future.delayed(const Duration(seconds: 3));
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.parse(
        'https://admin-server-production-a272.up.railway.app/api/v1/drivers/accept');

    var response = await client.put(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );
    http.Response acceptRideModel = response;

    if (response.statusCode == 200) {
      //SHARED

      return acceptRideResponseJson(response.body);
    } else {
      return acceptRideResponseJson(response.body);
      ;
    }
  }
}
