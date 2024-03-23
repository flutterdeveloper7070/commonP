// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  bool? success;
  String? message;
  String? token;
  LoginResponse? loginResponse;

  LoginModel({
    this.success,
    this.message,
    this.token,
    this.loginResponse,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        success: json["success"],
        message: json["message"],
        token: json["token"],
        loginResponse: json["data"] == null ? null : LoginResponse.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "token": token,
        "data": loginResponse?.toJson(),
      };
}

class LoginResponse {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? mobile;
  String? location;
  DateTime? birthDate;
  bool? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? profileImage;

  LoginResponse({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.mobile,
    this.location,
    this.birthDate,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.profileImage,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        id: json["_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        password: json["password"],
        mobile: json["mobile"],
        location: json["location"],
        birthDate: json["birth_date"] == null ? null : DateTime.parse(json["birth_date"]),
        status: json["status"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        profileImage: json["profile"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "password": password,
        "mobile": mobile,
        "location": location,
        "birth_date": birthDate?.toIso8601String(),
        "status": status,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "profile": profileImage
      };
}
