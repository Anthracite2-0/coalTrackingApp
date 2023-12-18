import 'dart:convert';

AcceptRideResponseModel acceptRideResponseJson(String str) =>
    AcceptRideResponseModel.fromJson(json.decode(str));

class AcceptRideResponseModel {
  bool? success;
  String? error;

  AcceptRideResponseModel({this.success, this.error});

  AcceptRideResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['error'] = this.error;
    return data;
  }
}
