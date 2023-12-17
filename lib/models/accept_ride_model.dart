class AcceptRideModel {
  String? mobile;
  String? orderId;
  Location? location;

  AcceptRideModel({this.mobile, this.orderId, this.location});

  AcceptRideModel.fromJson(Map<String, dynamic> json) {
    mobile = json['mobile'];
    orderId = json['order_id'];
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mobile'] = this.mobile;
    data['order_id'] = this.orderId;
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    return data;
  }
}

class Location {
  int? lat;
  int? long;

  Location({this.lat, this.long});

  Location.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    long = json['long'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['long'] = this.long;
    return data;
  }
}
