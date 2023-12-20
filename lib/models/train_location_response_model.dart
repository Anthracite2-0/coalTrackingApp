import 'dart:convert';

TrainLocationResponseModel trainLocationResponseJson(String str) =>
    TrainLocationResponseModel.fromJson(json.decode(str));

class TrainLocationResponseModel {
  String? message;

  TrainLocationResponseModel({this.message});

  TrainLocationResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    return data;
  }
}
