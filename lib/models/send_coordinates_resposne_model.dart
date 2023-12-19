import 'dart:convert';

SendCoordinatesResponseModel sendCoordinatesResponseJson(String str) =>
    SendCoordinatesResponseModel.fromJson(json.decode(str));

class SendCoordinatesResponseModel {
  bool? success;
  List<int>? data;

  SendCoordinatesResponseModel({this.success, this.data});

  SendCoordinatesResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['data'] = this.data;
    return data;
  }
}
