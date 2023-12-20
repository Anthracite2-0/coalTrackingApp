// To parse this JSON data, do
//
//     final allOrdersDriver = allOrdersDriverFromJson(jsonString);

import 'dart:convert';

AllOrdersDriver allOrdersDriverFromJson(String str) =>
    AllOrdersDriver.fromJson(json.decode(str));

String allOrdersDriverToJson(AllOrdersDriver data) =>
    json.encode(data.toJson());

class AllOrdersDriver {
  final int count;
  final List<Row> rows;

  AllOrdersDriver({
    required this.count,
    required this.rows,
  });

  factory AllOrdersDriver.fromJson(Map<String, dynamic> json) =>
      AllOrdersDriver(
        count: json["count"],
        rows: List<Row>.from(json["rows"].map((x) => Row.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "rows": List<dynamic>.from(rows.map((x) => x.toJson())),
      };
}

class Row {
  final int id;
  final int orderId;
  final int driverId;
  final int vehicleId;
  final String initialLat;
  final String initialLong;
  final String currentLat;
  final String currentLong;
  final bool rideStatus;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<dynamic> orders;

  Row({
    required this.id,
    required this.orderId,
    required this.driverId,
    required this.vehicleId,
    required this.initialLat,
    required this.initialLong,
    required this.currentLat,
    required this.currentLong,
    required this.rideStatus,
    required this.createdAt,
    required this.updatedAt,
    required this.orders,
  });

  factory Row.fromJson(Map<String, dynamic> json) => Row(
        id: json["id"],
        orderId: json["order_id"],
        driverId: json["driver_id"],
        vehicleId: json["vehicle_id"],
        initialLat: json["initial_lat"],
        initialLong: json["initial_long"],
        currentLat: json["current_lat"],
        currentLong: json["current_long"],
        rideStatus: json["ride_status"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        orders: List<dynamic>.from(json["orders"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_id": orderId,
        "driver_id": driverId,
        "vehicle_id": vehicleId,
        "initial_lat": initialLat,
        "initial_long": initialLong,
        "current_lat": currentLat,
        "current_long": currentLong,
        "ride_status": rideStatus,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "orders": List<dynamic>.from(orders.map((x) => x)),
      };
}
