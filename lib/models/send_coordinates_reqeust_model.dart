class SendCoordinatesRequestModel {
  String? currentLat;
  String? currentLong;
  String? orderId;
  String? driverId;

  SendCoordinatesRequestModel({
    this.currentLat,
    this.currentLong,
    this.orderId,
    this.driverId,
  });

  SendCoordinatesRequestModel.fromJson(Map<String, dynamic> json) {
    currentLat = json['current_lat'];
    currentLong = json['current_long'];
    orderId = json['order_id'];
    driverId = json['driver_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_lat'] = this.currentLat;
    data['current_long'] = this.currentLong;
    data['order_id'] = this.orderId;
    data['driver_id'] = this.driverId;
    return data;
  }
}
