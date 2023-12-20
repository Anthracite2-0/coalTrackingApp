import 'dart:convert';

TrainStatusResponseModel trainStatusResponseJson(String str) =>
    TrainStatusResponseModel.fromJson(json.decode(str));

class TrainStatusResponseModel {
  String? message;

  TrainStatusResponseModel({this.message});

  TrainStatusResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    return data;
  }
}
