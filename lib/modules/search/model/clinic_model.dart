// To parse this JSON data, do
//
//     final clinicModel = clinicModelFromJson(jsonString);

import 'dart:convert';

ClinicModel clinicModelFromJson(String str) => ClinicModel.fromJson(json.decode(str));

String clinicModelToJson(ClinicModel data) => json.encode(data.toJson());

class ClinicModel {
  final int id;
  final String username;
  bool?isSelected;


  ClinicModel({
    required this.id,
    required this.username,
    this.isSelected,
  });

  factory ClinicModel.fromJson(Map<String, dynamic> json) => ClinicModel(
    id: json["id"]??0,
    username: json["username"]??json["username_en"]??'',

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
  };
}
