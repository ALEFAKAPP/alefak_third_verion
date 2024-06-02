// To parse this JSON data, do
//
//     final userNotificationModel = userNotificationModelFromJson(jsonString);

import 'dart:convert';

UserNotificationModel userNotificationModelFromJson(String str) => UserNotificationModel.fromJson(json.decode(str));

String userNotificationModelToJson(UserNotificationModel data) => json.encode(data.toJson());

class UserNotificationModel {
  final int id;
  final int senderId;
  final int recieverId;
  final String url;
  final int type;
  final int messageId;
  final String message;
  final String title;

  UserNotificationModel({
    required this.id,
    required this.senderId,
    required this.recieverId,
    required this.url,
    required this.type,
    required this.messageId,
    required this.message,
    required this.title,
  });

  factory UserNotificationModel.fromJson(Map<String, dynamic> json) => UserNotificationModel(
    id: json["id"],
    senderId: json["sender_id"],
    recieverId: json["reciever_id"],
    url: json["url"]??"",
    type: json["type"]??0,
    messageId: json["message_id"]??0,
    message: json["message"]??"",
    title: json["title"]??"",
    //updatedAt: DateTime.parse(json["updated_at"]),
    //getType: GetType.fromJson(json["get_type"]),
    //getReciever: Get.fromJson(json["get_reciever"]),
    //getSender: Get.fromJson(json["get_sender"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "sender_id": senderId,
    "reciever_id": recieverId,
    "url": url,
    "type": type,
    //"message_id": messageId,
    "message": message,
    "title": title,
    //"updated_at": updatedAt.toIso8601String(),
    //"get_type": getType.toJson(),
    //"get_reciever": getReciever.toJson(),
    //"get_sender": getSender.toJson(),
  };
}



