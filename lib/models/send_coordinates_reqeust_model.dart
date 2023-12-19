class SendCoordinatesRequestModel {
  String? currentLat;
  String? currentLong;
  String? orderId;

  SendCoordinatesRequestModel(
      {this.currentLat, this.currentLong, this.orderId});

  SendCoordinatesRequestModel.fromJson(Map<String, dynamic> json) {
    currentLat = json['current_lat'];
    currentLong = json['current_long'];
    orderId = json['order_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_lat'] = this.currentLat;
    data['current_long'] = this.currentLong;
    data['order_id'] = this.orderId;
    return data;
  }
}
