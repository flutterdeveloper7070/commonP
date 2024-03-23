// To parse this JSON data, do
//
//     final checkListModel = checkListModelFromJson(jsonString);

import 'dart:convert';


import 'package:predator_pest/app/common_imports/common_imports.dart';

CheckListModel checkListModelFromJson(String str) => CheckListModel.fromJson(json.decode(str));

String checkListModelToJson(CheckListModel data) => json.encode(data.toJson());

class CheckListModel {
  String? title;
  String? description;
  bool? isCheck;
  Color? tileColor;
  List<GetDetailsAccount>? getDetailsList;
  List<dynamic>? inputList;
  final chipKey = GlobalKey<ChipsInputState>();
  TextEditingController descriptionController = TextEditingController();

  CheckListModel({
    this.title,
    this.description,
    this.isCheck,
    this.getDetailsList,
    this.inputList = const [],
    this.tileColor = AppColorConstants.appBlack,
  });

  factory CheckListModel.fromJson(Map<String, dynamic> json) => CheckListModel(
        title: json["title"],
        description: json["description"],
        isCheck: json["isCheck"],
        getDetailsList: json["details"] == null
            ? []
            : List<GetDetailsAccount>.from(json["details"]!.map((x) => GetDetailsAccount.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "isCheck": isCheck,
        "details": getDetailsList == null ? [] : List<dynamic>.from(getDetailsList!.map((x) => x.toJson())),
      };
}
