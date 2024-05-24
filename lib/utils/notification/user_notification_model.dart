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
  final DateTime updatedAt;
  final GetType getType;
  final Get getReciever;
  final Get getSender;

  UserNotificationModel({
    required this.id,
    required this.senderId,
    required this.recieverId,
    required this.url,
    required this.type,
    required this.messageId,
    required this.message,
    required this.title,
    required this.updatedAt,
    required this.getType,
    required this.getReciever,
    required this.getSender,
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
    updatedAt: DateTime.parse(json["updated_at"]),
    getType: GetType.fromJson(json["get_type"]),
    getReciever: Get.fromJson(json["get_reciever"]),
    getSender: Get.fromJson(json["get_sender"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "sender_id": senderId,
    "reciever_id": recieverId,
    "url": url,
    "type": type,
    "message_id": messageId,
    "message": message,
    "title": title,
    "updated_at": updatedAt.toIso8601String(),
    "get_type": getType.toJson(),
    "get_reciever": getReciever.toJson(),
    "get_sender": getSender.toJson(),
  };
}

class Get {
  final int id;
  final String username;
  final String usernameEn;
  final String email;
  final String phone;
  final String photo;
  final dynamic bannerPhoto;
  final int userTypeId;
  final int activate;
  final int activeEmail;
  final int activePhone;
  final int block;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime lastLogin;
  final int countryId;
  final int categoryId;
  final int regionId;
  final int stateId;
  final int phonecode;
  final String deviceToken;
  final String activationCode;
  final String longitude;
  final String latitude;
  final String address;
  final String addressEn;
  final int privilegeId;
  final String lang;
  final int notification;
  final int ready;
  final String token;
  final String emailEdited;
  final int currencyId;
  final int mainProvider;
  final int profitRate;
  final int acceptPricing;
  final int acceptEstimate;
  final int addProduct;
  final int shopType;
  final int clientType;
  final dynamic commercialNo;
  final dynamic commercialEndDate;
  final dynamic commercialId;
  final dynamic taxNumber;
  final String about;
  final int approved;
  final dynamic cancelReason;
  final int hasRegions;
  final String deviceType;
  final dynamic licenceEndDate;
  final String versionNumber;
  final dynamic licencePhoto;
  final int driverType;
  final dynamic deletedAt;
  final int provideMedicalServices;
  final int provideAnalysisServices;
  final int provideXrayServices;
  final dynamic polyclinicId;
  final dynamic identificationNumber;
  final String birthDate;
  final int packageId;
  final dynamic packageEndDate;
  final int packageDays;
  final int isOnline;
  final int stop;
  final int acceptedTerms;
  final dynamic website;
  final int sort;
  final dynamic offerPhoto;
  final dynamic alefakName;
  final dynamic contactPhone;
  final String apiToken;

  Get({
    required this.id,
    required this.username,
    required this.usernameEn,
    required this.email,
    required this.phone,
    required this.photo,
    required this.bannerPhoto,
    required this.userTypeId,
    required this.activate,
    required this.activeEmail,
    required this.activePhone,
    required this.block,
    required this.createdAt,
    required this.updatedAt,
    required this.lastLogin,
    required this.countryId,
    required this.categoryId,
    required this.regionId,
    required this.stateId,
    required this.phonecode,
    required this.deviceToken,
    required this.activationCode,
    required this.longitude,
    required this.latitude,
    required this.address,
    required this.addressEn,
    required this.privilegeId,
    required this.lang,
    required this.notification,
    required this.ready,
    required this.token,
    required this.emailEdited,
    required this.currencyId,
    required this.mainProvider,
    required this.profitRate,
    required this.acceptPricing,
    required this.acceptEstimate,
    required this.addProduct,
    required this.shopType,
    required this.clientType,
    required this.commercialNo,
    required this.commercialEndDate,
    required this.commercialId,
    required this.taxNumber,
    required this.about,
    required this.approved,
    required this.cancelReason,
    required this.hasRegions,
    required this.deviceType,
    required this.licenceEndDate,
    required this.versionNumber,
    required this.licencePhoto,
    required this.driverType,
    required this.deletedAt,
    required this.provideMedicalServices,
    required this.provideAnalysisServices,
    required this.provideXrayServices,
    required this.polyclinicId,
    required this.identificationNumber,
    required this.birthDate,
    required this.packageId,
    required this.packageEndDate,
    required this.packageDays,
    required this.isOnline,
    required this.stop,
    required this.acceptedTerms,
    required this.website,
    required this.sort,
    required this.offerPhoto,
    required this.alefakName,
    required this.contactPhone,
    required this.apiToken,
  });

  factory Get.fromJson(Map<String, dynamic> json) => Get(
    id: json["id"],
    username: json["username"],
    usernameEn: json["username_en"],
    email: json["email"],
    phone: json["phone"],
    photo: json["photo"],
    bannerPhoto: json["banner_photo"],
    userTypeId: json["user_type_id"],
    activate: json["activate"],
    activeEmail: json["active_email"],
    activePhone: json["active_phone"],
    block: json["block"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    lastLogin: DateTime.parse(json["last_login"]),
    countryId: json["country_id"],
    categoryId: json["category_id"],
    regionId: json["region_id"],
    stateId: json["state_id"],
    phonecode: json["phonecode"],
    deviceToken: json["device_token"],
    activationCode: json["activation_code"],
    longitude: json["longitude"],
    latitude: json["latitude"],
    address: json["address"],
    addressEn: json["address_en"],
    privilegeId: json["privilege_id"],
    lang: json["lang"],
    notification: json["notification"],
    ready: json["ready"],
    token: json["token"],
    emailEdited: json["email_edited"],
    currencyId: json["currency_id"],
    mainProvider: json["main_provider"],
    profitRate: json["profit_rate"],
    acceptPricing: json["accept_pricing"],
    acceptEstimate: json["accept_estimate"],
    addProduct: json["add_product"],
    shopType: json["shop_type"],
    clientType: json["client_type"],
    commercialNo: json["commercial_no"],
    commercialEndDate: json["commercial_end_date"],
    commercialId: json["commercial_id"],
    taxNumber: json["tax_number"],
    about: json["about"],
    approved: json["approved"],
    cancelReason: json["cancel_reason"],
    hasRegions: json["has_regions"],
    deviceType: json["device_type"],
    licenceEndDate: json["licence_end_date"],
    versionNumber: json["version_number"],
    licencePhoto: json["licence_photo"],
    driverType: json["driver_type"],
    deletedAt: json["deleted_at"],
    provideMedicalServices: json["provide_medical_services"],
    provideAnalysisServices: json["provide_analysis_services"],
    provideXrayServices: json["provide_xray_services"],
    polyclinicId: json["polyclinic_id"],
    identificationNumber: json["identification_number"],
    birthDate: json["birth_date"],
    packageId: json["package_id"],
    packageEndDate: json["package_end_date"],
    packageDays: json["package_days"],
    isOnline: json["is_online"],
    stop: json["stop"],
    acceptedTerms: json["accepted_terms"],
    website: json["website"],
    sort: json["sort"],
    offerPhoto: json["offer_photo"],
    alefakName: json["alefak_name"],
    contactPhone: json["contact_phone"],
    apiToken: json["api_token"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "username_en": usernameEn,
    "email": email,
    "phone": phone,
    "photo": photo,
    "banner_photo": bannerPhoto,
    "user_type_id": userTypeId,
    "activate": activate,
    "active_email": activeEmail,
    "active_phone": activePhone,
    "block": block,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "last_login": lastLogin.toIso8601String(),
    "country_id": countryId,
    "category_id": categoryId,
    "region_id": regionId,
    "state_id": stateId,
    "phonecode": phonecode,
    "device_token": deviceToken,
    "activation_code": activationCode,
    "longitude": longitude,
    "latitude": latitude,
    "address": address,
    "address_en": addressEn,
    "privilege_id": privilegeId,
    "lang": lang,
    "notification": notification,
    "ready": ready,
    "token": token,
    "email_edited": emailEdited,
    "currency_id": currencyId,
    "main_provider": mainProvider,
    "profit_rate": profitRate,
    "accept_pricing": acceptPricing,
    "accept_estimate": acceptEstimate,
    "add_product": addProduct,
    "shop_type": shopType,
    "client_type": clientType,
    "commercial_no": commercialNo,
    "commercial_end_date": commercialEndDate,
    "commercial_id": commercialId,
    "tax_number": taxNumber,
    "about": about,
    "approved": approved,
    "cancel_reason": cancelReason,
    "has_regions": hasRegions,
    "device_type": deviceType,
    "licence_end_date": licenceEndDate,
    "version_number": versionNumber,
    "licence_photo": licencePhoto,
    "driver_type": driverType,
    "deleted_at": deletedAt,
    "provide_medical_services": provideMedicalServices,
    "provide_analysis_services": provideAnalysisServices,
    "provide_xray_services": provideXrayServices,
    "polyclinic_id": polyclinicId,
    "identification_number": identificationNumber,
    "birth_date": birthDate,
    "package_id": packageId,
    "package_end_date": packageEndDate,
    "package_days": packageDays,
    "is_online": isOnline,
    "stop": stop,
    "accepted_terms": acceptedTerms,
    "website": website,
    "sort": sort,
    "offer_photo": offerPhoto,
    "alefak_name": alefakName,
    "contact_phone": contactPhone,
    "api_token": apiToken,
  };
}

class GetType {
  final int id;
  final String name;
  final String icon;
  final DateTime createdAt;
  final String updatedAt;

  GetType({
    required this.id,
    required this.name,
    required this.icon,
    required this.createdAt,
    required this.updatedAt,
  });

  factory GetType.fromJson(Map<String, dynamic> json) => GetType(
    id: json["id"],
    name: json["name"],
    icon: json["icon"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "icon": icon,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt,
  };
}
