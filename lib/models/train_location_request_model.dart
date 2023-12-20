class TrainLocationRequestModel {
  String? trainCurrentLat;
  String? trainCurrentLong;

  TrainLocationRequestModel({this.trainCurrentLat, this.trainCurrentLong});

  TrainLocationRequestModel.fromJson(Map<String, dynamic> json) {
    trainCurrentLat = json['train_current_lat'];
    trainCurrentLong = json['train_current_long'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['train_current_lat'] = this.trainCurrentLat;
    data['train_current_long'] = this.trainCurrentLong;
    return data;
  }
}
