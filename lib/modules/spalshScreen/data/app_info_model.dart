import 'package:alefakaltawinea_animals_app/utils/my_utils/appConfig.dart';

class AppInfoModel {
  String? aboutUs;
  String? conditions;
  String? privacy;
  String? phone;
  String? whatsapp;
  String? email;
  int? firstCardPrice;
  int? secCardPrice;
  double? appMinimumVersionAndroid;
  double? appMinimumVersionIos;
  bool? maintenanceMode;
  String? futureCard;
  int? priceCard;
  int? priceAdditionalCard;

  AppInfoModel(
      {this.aboutUs,
        this.conditions,
        this.privacy,
        this.phone,
        this.whatsapp,
        this.email,
        this.firstCardPrice,
        this.secCardPrice,
        this.appMinimumVersionAndroid,
        this.appMinimumVersionIos,
        this.maintenanceMode,
        this.futureCard,
        this.priceCard,
        this.priceAdditionalCard,
      });

  AppInfoModel.fromJson(Map<String, dynamic> json) {
    aboutUs = json['about-us'];
    conditions = json['conditions'];
    privacy = json['privacy'];
    phone = json['phone'];
    whatsapp = json['whatsapp'];
    email = json['email'];
    firstCardPrice = json['first_card_price'];
    secCardPrice = json['sec_card_price'];
    appMinimumVersionAndroid = BaseConfig.checkDouble(json['app_minimum_version_android']);
    appMinimumVersionIos = BaseConfig.checkDouble(json['app_minimum_version_ios']);
    maintenanceMode = json['maintenance_mode'] ?? false;
    futureCard = json['future_card'] ?? '';
    priceCard = json['price_card'] ?? 0.0;
    priceAdditionalCard = json['price_additional_card'] ?? 0.0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['about-us'] = this.aboutUs;
    data['conditions'] = this.conditions;
    data['privacy'] = this.privacy;
    data['phone'] = this.phone;
    data['whatsapp'] = this.whatsapp;
    data['email'] = this.email;
    data['first_card_price'] = this.firstCardPrice;
    data['sec_card_price'] = this.secCardPrice;
    data['app_minimum_version_android'] = this.appMinimumVersionAndroid;
    data['app_minimum_version_ios'] = this.appMinimumVersionIos;
    data['maintenance_mode'] = this.maintenanceMode;
    data['future_card'] = this.futureCard;
    data['price_card'] = this.priceCard;
    data['price_additional_card'] = this.priceAdditionalCard;
    return data;
  }
}