class MapScreenRequestModel {
  String? mobile;
  String? orderId;

  MapScreenRequestModel({this.mobile, this.orderId});

  MapScreenRequestModel.fromJson(Map<String, dynamic> json) {
    mobile = json['mobile'];
    orderId = json['order_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mobile'] = this.mobile;
    data['order_id'] = this.orderId;
    return data;
  }
}
