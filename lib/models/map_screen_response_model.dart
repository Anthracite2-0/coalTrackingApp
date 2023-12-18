import 'dart:convert';

MapScreenResponseModel mapScreenResponseJson(String str) =>
    MapScreenResponseModel.fromJson(json.decode(str));

class MapScreenResponseModel {
  bool? success;
  Data? data;

  MapScreenResponseModel({this.success, this.data});

  MapScreenResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? initialLat;
  String? initialLong;
  String? finalLat;
  String? finalLong;
  String? adminNo;
  String? userNo;

  Data(
      {this.initialLat,
      this.initialLong,
      this.finalLat,
      this.finalLong,
      this.adminNo,
      this.userNo});

  Data.fromJson(Map<String, dynamic> json) {
    initialLat = json['initial_lat'];
    initialLong = json['initial_long'];
    finalLat = json['final_lat'];
    finalLong = json['final_long'];
    adminNo = json['admin_no'];
    userNo = json['user_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['initial_lat'] = this.initialLat;
    data['initial_long'] = this.initialLong;
    data['final_lat'] = this.finalLat;
    data['final_long'] = this.finalLong;
    data['admin_no'] = this.adminNo;
    data['user_no'] = this.userNo;
    return data;
  }
}
