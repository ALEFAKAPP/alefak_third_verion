// To parse this JSON data, do
//
//     final subscribeInPlanModel = subscribeInPlanModelFromJson(jsonString);

import 'dart:convert';

SubscribeInPlanModel subscribeInPlanModelFromJson(String str) => SubscribeInPlanModel.fromJson(json.decode(str));

String subscribeInPlanModelToJson(SubscribeInPlanModel data) => json.encode(data.toJson());

class SubscribeInPlanModel {
  final SubscriptionData data;
  final String url;
  final int price;

  SubscribeInPlanModel({
    required this.data,
    required this.url,
    required this.price,
  });

  factory SubscribeInPlanModel.fromJson(Map<String, dynamic> json) => SubscribeInPlanModel(
    data: SubscriptionData.fromJson(json["data"]),
    url: json["url"],
    price: json["price"],
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
    "url": url,
    "price": price,
  };
}

class SubscriptionData {
  final bool isSuccess;
  final String message;
  final dynamic validationErrors;
  final DataClass data;

  SubscriptionData({
    required this.isSuccess,
    required this.message,
    required this.validationErrors,
    required this.data,
  });

  factory SubscriptionData.fromJson(Map<String, dynamic> json) => SubscriptionData(
    isSuccess: json["IsSuccess"],
    message: json["Message"],
    validationErrors: json["ValidationErrors"],
    data: DataClass.fromJson(json["Data"]),
  );

  Map<String, dynamic> toJson() => {
    "IsSuccess": isSuccess,
    "Message": message,
    "ValidationErrors": validationErrors,
    "Data": data.toJson(),
  };
}

class DataClass {
  final int invoiceId;
  final String invoiceUrl;
  final dynamic customerReference;
  final String userDefinedField;

  DataClass({
    required this.invoiceId,
    required this.invoiceUrl,
    required this.customerReference,
    required this.userDefinedField,
  });

  factory DataClass.fromJson(Map<String, dynamic> json) => DataClass(
    invoiceId: json["InvoiceId"],
    invoiceUrl: json["InvoiceURL"],
    customerReference: json["CustomerReference"],
    userDefinedField: json["UserDefinedField"],
  );

  Map<String, dynamic> toJson() => {
    "InvoiceId": invoiceId,
    "InvoiceURL": invoiceUrl,
    "CustomerReference": customerReference,
    "UserDefinedField": userDefinedField,
  };
}
