class TrainStatusRequestModel {
  bool? trainStatus;

  TrainStatusRequestModel({this.trainStatus});

  TrainStatusRequestModel.fromJson(Map<String, dynamic> json) {
    trainStatus = json['train_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['train_status'] = this.trainStatus;
    return data;
  }
}
