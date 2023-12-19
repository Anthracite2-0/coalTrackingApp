class SendCoordinatesRequestModel {
  String? currentLat;
  String? currentLong;

  SendCoordinatesRequestModel({this.currentLat, this.currentLong});

  SendCoordinatesRequestModel.fromJson(Map<String, dynamic> json) {
    currentLat = json['current_lat'];
    currentLong = json['current_long'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_lat'] = this.currentLat;
    data['current_long'] = this.currentLong;
    return data;
  }
}
