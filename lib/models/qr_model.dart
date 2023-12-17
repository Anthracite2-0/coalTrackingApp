import 'dart:convert';

QRModel qrModelJson(String str) => QRModel.fromJson(json.decode(str));

class QRModel {
  FinalDestination? finalDestination;
  String? orderId;

  QRModel({this.finalDestination, this.orderId});

  QRModel.fromJson(Map<String, dynamic> json) {
    finalDestination = json['final_destination'] != null
        ? new FinalDestination.fromJson(json['final_destination'])
        : null;
    orderId = json['order_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.finalDestination != null) {
      data['final_destination'] = this.finalDestination!.toJson();
    }
    data['order_id'] = this.orderId;
    return data;
  }
}

class FinalDestination {
  double? lat;
  double? lng;

  FinalDestination({this.lat, this.lng});

  FinalDestination.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}
