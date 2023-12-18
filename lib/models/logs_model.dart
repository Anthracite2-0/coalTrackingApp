class LocationLogs {
  final int? id;
  final String orderId;
  final double latitude;
  final double longitude;
  final int timestamp;

  LocationLogs(
      {this.id,
      required this.orderId,
      required this.latitude,
      required this.longitude,
      required this.timestamp});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'orderId': orderId,
      'latitude': latitude,
      'longitude': longitude,
      'timestamp': timestamp,
    };
  }

  factory LocationLogs.fromMap(Map<String, dynamic> map) {
    return LocationLogs(
      id: map['id'] as int?,
      orderId: map['orderId'] as String,
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
      timestamp: map['timestamp'] as int,
    );
  }
}
