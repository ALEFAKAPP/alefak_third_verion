// To parse this JSON data, do
//
//     final homeOffersModel = homeOffersModelFromJson(jsonString);

import 'dart:convert';

import 'package:alefakaltawinea_animals_app/modules/notifications/data/notification_model.dart';
import 'package:alefakaltawinea_animals_app/modules/serviceProviders/list_screen/data/serviceProvidersModel.dart';

HomeOffersModel homeOffersModelFromJson(String str) => HomeOffersModel.fromJson(json.decode(str));

String homeOffersModelToJson(HomeOffersModel data) => json.encode(data.toJson());

class HomeOffersModel {
  final int currentPage;
  final List<HomeListOfOffersModel> data;
  final String firstPageUrl;
  final int from;
  final int lastPage;
  final String lastPageUrl;
  final String nextPageUrl;
  final String path;
  final int perPage;
  final String prevPageUrl;
  final int to;
  final int total;

  HomeOffersModel({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.nextPageUrl,
    required this.path,
    required this.perPage,
    required this.prevPageUrl,
    required this.to,
    required this.total,
  });

  factory HomeOffersModel.fromJson(Map<String, dynamic> json) => HomeOffersModel(
    currentPage: json["current_page"]??0,
    data: json["data"]==null?[]:List<HomeListOfOffersModel>.from(json["data"].map((x) => HomeListOfOffersModel.fromJson(x))),
    firstPageUrl: json["first_page_url"]??"",
    from: json["from"]??0,
    lastPage: json["last_page"]??'',
    lastPageUrl: json["last_page_url"]??'',
    nextPageUrl: json["next_page_url"]??'',
    path: json["path"],
    perPage: json["per_page"],
    prevPageUrl: json["prev_page_url"]??"",
    to: json["to"]??0,
    total: json["total"]??0,
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "first_page_url": firstPageUrl,
    "from": from,
    "last_page": lastPage,
    "last_page_url": lastPageUrl,
    "next_page_url": nextPageUrl,
    "path": path,
    "per_page": perPage,
    "prev_page_url": prevPageUrl,
    "to": to,
    "total": total,
  };
}

class HomeListOfOffersModel {
  final int id;
  final String nameAr;
  final String nameEn;
  final String descriptionAr;
  final String descriptionEn;
  final String photo;
  final List<OfferElement> offers;

  HomeListOfOffersModel({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.descriptionAr,
    required this.descriptionEn,
    required this.photo,
    required this.offers,
  });

  factory HomeListOfOffersModel.fromJson(Map<String, dynamic> json) => HomeListOfOffersModel(
    id: json["id"],
    nameAr: json["name_ar"],
    nameEn: json["name_en"],
    descriptionAr: json["description_ar"],
    descriptionEn: json["description_en"],
    photo: json["photo"]??"",
    offers: List<OfferElement>.from(json["offers"].map((x) => OfferElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name_ar": nameAr,
    "name_en": nameEn,
    "description_ar": descriptionAr,
    "description_en": descriptionEn,
    "photo": photo,
    "offers": List<dynamic>.from(offers.map((x) => x.toJson())),
  };
}

class OfferElement {
  final int id;
  final String categoryId;
  final int offerId;
  final OfferOffer offer;
  //final String shop;

  OfferElement({
    required this.id,
    required this.categoryId,
    required this.offerId,
    required this.offer,
    //required this.shop,
  });

  factory OfferElement.fromJson(Map<String, dynamic> json) => OfferElement(
    id: json["id"],
    categoryId: json["category_id"],
    offerId: json["offer_id"],
    offer: OfferOffer.fromJson(json["offer"]),
    //shop: Shop.fromJson(json["shop"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category_id": categoryId,
    "offer_id": offerId,
    "offer": offer.toJson(),
    //"shop": shop,
  };
}

class OfferOffer {
  final int id;
  final String title;
  final String userId;
  final String price;
  final String discountValue;
  final DateTime expirationDate;
  final String code;
  final String usageTimes;
  final List<Features> features;
  final String userUsage;
  final dynamic notificationDate;
  final Data shop;

  OfferOffer({
    required this.id,
    required this.title,
    required this.userId,
    required this.price,
    required this.discountValue,
    required this.expirationDate,
    required this.code,
    required this.usageTimes,
    required this.features,
    required this.userUsage,
    required this.notificationDate,
    required this.shop,
  });

  factory OfferOffer.fromJson(Map<String, dynamic> json) => OfferOffer(
    id: json["id"],
    title: json["title"],
    userId: json["user_id"],
    price: json["price"],
    discountValue: json["discount_value"],
    expirationDate: DateTime.parse(json["expiration_date"]),
    code: json["code"],
    usageTimes: json["usage_times"],
    features: List<Features>.from(json["features"].map((x) => Features.fromJson(x))),
    userUsage: json["user_usage"],
    notificationDate: json["notification_date"],
    shop: Data.fromJson(json["shop"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "user_id": userId,
    "price": price,
    "discount_value": discountValue,
    "expiration_date": "${expirationDate.year.toString().padLeft(4, '0')}-${expirationDate.month.toString().padLeft(2, '0')}-${expirationDate.day.toString().padLeft(2, '0')}",
    "code": code,
    "usage_times": usageTimes,
    "features": List<dynamic>.from(features.map((x) => x.toJson())),
    "user_usage": userUsage,
    "notification_date": notificationDate,
    "shop": shop,
  };
}


