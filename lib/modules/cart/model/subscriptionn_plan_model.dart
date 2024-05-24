// To parse this JSON data, do
//
//     final subscriptionPlanModel = subscriptionPlanModelFromJson(jsonString);

import 'dart:convert';

SubscriptionPlanModel subscriptionPlanModelFromJson(String str) => SubscriptionPlanModel.fromJson(json.decode(str));

String subscriptionPlanModelToJson(SubscriptionPlanModel data) => json.encode(data.toJson());

class SubscriptionPlanModel {
  final int id;
  final String description;
  final String type;
  final String days;
  final String isRenewal;
  final int price;
  final String discountType;
  final int discountValue;
  final String name;
  final int newPrice;
  final List<dynamic> details;

  SubscriptionPlanModel({
    required this.id,
    required this.description,
    required this.type,
    required this.days,
    required this.isRenewal,
    required this.price,
    required this.discountType,
    required this.discountValue,
    required this.name,
    required this.newPrice,
    required this.details,
  });

  factory SubscriptionPlanModel.fromJson(Map<String, dynamic> json) => SubscriptionPlanModel(
    id: json["id"],
    description: json["description"],
    type: json["type"],
    days: json["days"],
    isRenewal: json["is_renewal"],
    price: json["price"],
    discountType: json["discount_type"],
    discountValue: json["discount_value"],
    name: json["name"],
    newPrice: json["new_price"],
    details: List<dynamic>.from(json["details"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "description": description,
    "type": type,
    "days": days,
    "is_renewal": isRenewal,
    "price": price,
    "discount_type": discountType,
    "discount_value": discountValue,
    "name": name,
    "new_price": newPrice,
    "details": List<dynamic>.from(details.map((x) => x)),
  };
}
