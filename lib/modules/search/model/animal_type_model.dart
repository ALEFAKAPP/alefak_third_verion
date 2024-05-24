// To parse this JSON data, do
//
//     final aimalTypeModel = aimalTypeModelFromJson(jsonString);

import 'dart:convert';

import '../../../utils/my_utils/constants.dart';

AimalTypeModel aimalTypeModelFromJson(String str) => AimalTypeModel.fromJson(json.decode(str));

String aimalTypeModelToJson(AimalTypeModel data) => json.encode(data.toJson());

class AimalTypeModel {
  final int id;
  final String color;
  final String nameAr;
  final String name;
  bool?isSelected;

  AimalTypeModel({
    required this.id,
    required this.color,
    required this.nameAr,
    required this.name,
    this.isSelected
  });

  factory AimalTypeModel.fromJson(Map<String, dynamic> json) => AimalTypeModel(
    id: json["id"]??-1,
    color: json["color"]??'',
    nameAr: json["name_ar"]??'',
    name: json[Constants.utilsProviderModel!.isArabic?"name_ar":"name"]??'',
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "color": color,
    "name_ar": nameAr,
    "name": name,
  };
}
