import 'dart:convert';

import 'package:coal_tracking_app/models/accept_ride_model.dart';
import 'package:coal_tracking_app/models/accept_ride_response.dart';
import 'package:coal_tracking_app/models/map_screen_request_model.dart';
import 'package:coal_tracking_app/models/map_screen_response_model.dart';
import 'package:coal_tracking_app/models/send_coordinates_reqeust_model.dart';
import 'package:coal_tracking_app/models/send_coordinates_resposne_model.dart';
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
    }
  }

  static Future<MapScreenResponseModel> mapScreen(
      MapScreenRequestModel model) async {
    // await Future.delayed(const Duration(seconds: 3));
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      //'Authorization': '$token',
      'Accept': 'application/json',
      //HttpHeaders.authorizationHeader: '$token',
    };
    final encoding = Encoding.getByName('utf-8');

    var url = Uri.parse(
        'https://admin-server-production-a272.up.railway.app/api/v1/drivers/location');
    var response;
    try {
      response = await client.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          //'Authorization': '$token',
        },
        body: jsonEncode(model.toJson()),
        encoding: encoding,
      );
      http.Response mapScreenResponseModel = response;

      if (response.statusCode == 200) {
        //SHARED

        return mapScreenResponseJson(response.body);
      } else {
        return mapScreenResponseJson(response.body);
      }
    } catch (e) {
      return mapScreenResponseJson(response.body);
    }
  }

  static Future<SendCoordinatesResponseModel> sendCoordinates(
      SendCoordinatesRequestModel model) async {
    // await Future.delayed(const Duration(seconds: 3));
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.parse(
        'https://admin-server-production-a272.up.railway.app/api/v1/orderanddrivers/');

    var response = await client.put(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );
    http.Response sendCoordinatesResponseModel = response;

    if (response.statusCode == 200) {
      //SHARED

      return sendCoordinatesResponseJson(response.body);
    } else {
      return sendCoordinatesResponseJson(response.body);
    }
  }
}
