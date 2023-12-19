// To parse this JSON data, do
//
//     final userData = userDataFromJson(jsonString);

import 'dart:convert';

UserData userDataFromJson(String str) => UserData.fromJson(json.decode(str));
String userDataToJson(UserData data) => json.encode(data.toJson());

class UserData {
  final int id;
  final String fullName;
  final String email;
  final String mobile;
  final String country;
  final String city;
  final String address;
  final String postalCode;
  final String profileImage;
  final String idImage;
  final String licenseImage;
  final int vehicleId;
  final String licenseNumber;
  final int? createdBy;
  final dynamic updatedBy;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserData({
    required this.id,
    required this.fullName,
    required this.email,
    required this.mobile,
    required this.country,
    required this.city,
    required this.address,
    required this.postalCode,
    required this.profileImage,
    required this.idImage,
    required this.licenseImage,
    required this.vehicleId,
    required this.licenseNumber,
    required this.createdBy,
    required this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        id: json["id"],
        fullName: json["full_name"],
        email: json["email"],
        mobile: json["mobile"],
        country: json["country"],
        city: json["city"],
        address: json["address"],
        postalCode: json["postal_code"],
        profileImage: json["profile_image"],
        idImage: json["id_image"],
        licenseImage: json["license_image"],
        vehicleId: json["vehicle_id"],
        licenseNumber: json["license_number"],
        createdBy: json["createdBy"],
        updatedBy: json["updatedBy"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "full_name": fullName,
        "email": email,
        "mobile": mobile,
        "country": country,
        "city": city,
        "address": address,
        "postal_code": postalCode,
        "profile_image": profileImage,
        "id_image": idImage,
        "license_image": licenseImage,
        "vehicle_id": vehicleId,
        "license_number": licenseNumber,
        "createdBy": createdBy,
        "updatedBy": updatedBy,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
