// To parse this JSON data, do
//
//     final homeSingleOfferModel = homeSingleOfferModelFromJson(jsonString);

import 'dart:convert';

import 'package:alefakaltawinea_animals_app/modules/serviceProviderAccount/data/scan_code_model.dart';

HomeSingleOfferModel homeSingleOfferModelFromJson(String str) => HomeSingleOfferModel.fromJson(json.decode(str));

String homeSingleOfferModelToJson(HomeSingleOfferModel data) => json.encode(data.toJson());

class HomeSingleOfferModel {
  final int id;
  final DateTime dueDate;
  final int offerCategoryId;
  final int offerId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Offer offer;

  HomeSingleOfferModel({
    required this.id,
    required this.dueDate,
    required this.offerCategoryId,
    required this.offerId,
    required this.createdAt,
    required this.updatedAt,
    required this.offer,
  });

  factory HomeSingleOfferModel.fromJson(Map<String, dynamic> json) => HomeSingleOfferModel(
    id: json["id"],
    dueDate: DateTime.parse(json["due_date"]),
    offerCategoryId: json["offer_category_id"],
    offerId: json["offer_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    offer: Offer.fromJson(json["offer"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "due_date": "${dueDate.year.toString().padLeft(4, '0')}-${dueDate.month.toString().padLeft(2, '0')}-${dueDate.day.toString().padLeft(2, '0')}",
    "offer_category_id": offerCategoryId,
    "offer_id": offerId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "offer": offer.toJson(),
  };
}


