

import 'dart:convert';

AlefakInLinesModel alefakInLinesModelFromJson(String str) => AlefakInLinesModel.fromJson(json.decode(str));

String alefakInLinesModelToJson(AlefakInLinesModel data) => json.encode(data.toJson());

class AlefakInLinesModel {
  final int status;
  final List<AlefakInLinesData> data;
  final String message;

  AlefakInLinesModel({
    required this.status,
    required this.data,
    required this.message,
  });

  factory AlefakInLinesModel.fromJson(Map<String, dynamic> json) => AlefakInLinesModel(
    status: json["status"]??0,
    data: json["data"]==null?[]:List<AlefakInLinesData>.from(json["data"].map((x) => AlefakInLinesData.fromJson(x))),
    message: json["message"]??'',
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "message": message,
  };
}

class AlefakInLinesData {
  final int id;
  final String name;
  final String description;
  final String photo;

  AlefakInLinesData({
    required this.id,
    required this.name,
    required this.description,
    required this.photo,
  });

  factory AlefakInLinesData.fromJson(Map<String, dynamic> json) => AlefakInLinesData(
    id: json["id"]??0,
    name: json["name"]??'',
    description: json["description"]??'',
    photo: json["photo"]??'',
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "photo": photo,
  };
}
