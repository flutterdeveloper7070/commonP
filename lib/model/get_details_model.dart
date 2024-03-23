// To parse this JSON data, do
//
//     final getDetailsModel = getDetailsModelFromJson(jsonString);

import 'dart:convert';

GetDetailsModel getDetailsModelFromJson(String str) => GetDetailsModel.fromJson(json.decode(str));

String getDetailsModelToJson(GetDetailsModel data) => json.encode(data.toJson());

class GetDetailsModel {
  String? status;
  String? message;
  Details? details;

  GetDetailsModel({
    this.status,
    this.message,
    this.details,
  });

  factory GetDetailsModel.fromJson(Map<String, dynamic> json) => GetDetailsModel(
    status: json["status"],
    message: json["message"],
    details: json["details"] == null ? null : Details.fromJson(json["details"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "details": details?.toJson(),
  };
}

class Details {
  List<GetDetailsAccount>? account;
  List<GetDetailsAccount>? inspection;
  List<GetDetailsAccount>? measure;
  List<GetDetailsAccount>? problem;
  List<GetDetailsAccount>? sanitation;
  List<GetDetailsAccount>? structural;
  List<GetDetailsAccount>? location;

  Details({
    this.account,
    this.inspection,
    this.measure,
    this.problem,
    this.sanitation,
    this.structural,
    this.location,
  });

  factory Details.fromJson(Map<String, dynamic> json) => Details(
    account: json["Account"] == null ? [] : List<GetDetailsAccount>.from(json["Account"]!.map((x) => GetDetailsAccount.fromJson(x))),
    inspection: json["Inspection"] == null ? [] : List<GetDetailsAccount>.from(json["Inspection"]!.map((x) => GetDetailsAccount.fromJson(x))),
    measure: json["Measure"] == null ? [] : List<GetDetailsAccount>.from(json["Measure"]!.map((x) => GetDetailsAccount.fromJson(x))),
    problem: json["Problem"] == null ? [] : List<GetDetailsAccount>.from(json["Problem"]!.map((x) => GetDetailsAccount.fromJson(x))),
    sanitation: json["Sanitation"] == null ? [] : List<GetDetailsAccount>.from(json["Sanitation"]!.map((x) => GetDetailsAccount.fromJson(x))),
    structural: json["Structural"] == null ? [] : List<GetDetailsAccount>.from(json["Structural"]!.map((x) => GetDetailsAccount.fromJson(x))),
    location: json["Location"] == null ? [] : List<GetDetailsAccount>.from(json["Location"]!.map((x) => GetDetailsAccount.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Account": account == null ? [] : List<dynamic>.from(account!.map((x) => x.toJson())),
    "Inspection": inspection == null ? [] : List<dynamic>.from(inspection!.map((x) => x.toJson())),
    "Measure": measure == null ? [] : List<dynamic>.from(measure!.map((x) => x.toJson())),
    "Problem": problem == null ? [] : List<dynamic>.from(problem!.map((x) => x.toJson())),
    "Sanitation": sanitation == null ? [] : List<dynamic>.from(sanitation!.map((x) => x.toJson())),
    "Structural": structural == null ? [] : List<dynamic>.from(structural!.map((x) => x.toJson())),
    "Location": location == null ? [] : List<dynamic>.from(location!.map((x) => x.toJson())),
  };
}

class GetDetailsAccount {
  String? id;
  String? name;

  GetDetailsAccount({
    this.id,
    this.name,
  });

  factory GetDetailsAccount.fromJson(Map<String, dynamic> json) => GetDetailsAccount(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
