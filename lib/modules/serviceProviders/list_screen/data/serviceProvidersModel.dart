import 'package:alefakaltawinea_animals_app/modules/serviceProviders/list_screen/data/offer_model.dart';
import 'package:alefakaltawinea_animals_app/modules/serviceProviders/list_screen/data/photo_model.dart';

class ServiceProviderModel {
  int? currentPage;
  List<Data>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Socials>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  ServiceProviderModel(
      {this.currentPage,
        this.data,
        this.firstPageUrl,
        this.from,
        this.lastPage,
        this.lastPageUrl,
        this.links,
        this.nextPageUrl,
        this.path,
        this.perPage,
        this.prevPageUrl,
        this.to,
        this.total});

  ServiceProviderModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Socials>[];
      json['links'].forEach((v) {
        links!.add(new Socials.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = this.firstPageUrl;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['last_page_url'] = this.lastPageUrl;
    data['next_page_url'] = this.nextPageUrl;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['prev_page_url'] = this.prevPageUrl;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? address;
  String? phone;
  String? email;
  String? photo;
  String? bannerPhoto;
  String? longitude;
  String? latitude;
  String? regionId;
  String? regionName;
  String? stateId;
  String? stateName;
  String? isOnline;
  String? categoryId;
  String? website;
  int? is_fav;
  String?type_id;
  String?url;
  List<OfferModel>? offers;
  List<PhotoModel>? photos;
  String?contact_phone;
  List<Socials>?links;
  List<AddressModel>?addresses;
  bool?isSelected;
  bool?isExpanded;
   List<Classification>? classifications;


  Data(
      {this.id,
        this.name,
        this.address,
        this.phone,
        this.email,
        this.photo,
        this.bannerPhoto,
        this.longitude,
        this.latitude,
        this.regionId,
        this.regionName,
        this.stateId,
        this.stateName,
        this.isOnline,
        this.categoryId,
        this.website,
        this.is_fav,
      this.offers,
        this.photos,
        this.type_id,
        this.url,
        this.contact_phone,
        this.links,
        this.addresses,
        this.isSelected,
        this.isExpanded,
        this.classifications,
      });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    phone = json['phone'];
    email = json['email'];
    photo = json['photo'];
    bannerPhoto = json['banner_photo'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    regionId = json['region_id'];
    regionName = json['region_name'];
    stateId = json['state_id'];
    stateName = json['state_name'];
    isOnline = json['is_online'];
    categoryId = json['category_id'];
    website = json['website'];
    is_fav=json['is_fav'];
    type_id=json['type_id'];
    url=json['url'];
    classifications=json["classifications"]==null?[]:List<Classification>.from(json["classifications"].map((x) => Classification.fromJson(x)));
    contact_phone=json['contact_phone']??"";
    if (json['offers'] != null) {
      offers = <OfferModel>[];
      json['offers'].forEach((v) {
        if((OfferModel.fromJson(v).title??"").isNotEmpty){
          offers!.add(new OfferModel.fromJson(v));
        }
      });
    }
    if (json['photos'] != null) {
      photos = <PhotoModel>[];
      json['photos'].forEach((v) {
        photos!.add(new PhotoModel.fromJson(v));
      });
    }
    if (json['socials'] != null) {
      links = <Socials>[];
      json['socials'].forEach((v) {
        links!.add(new Socials.fromJson(v));
      });
    }
    if (json['addresses'] != null) {
      addresses = <AddressModel>[];
      json['addresses'].forEach((v) {
        addresses!.add( AddressModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['address'] = this.address;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['photo'] = this.photo;
    data['banner_photo'] = this.bannerPhoto;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['region_id'] = this.regionId;
    data['region_name'] = this.regionName;
    data['state_id'] = this.stateId;
    data['state_name'] = this.stateName;
    data['is_online'] = this.isOnline;
    data['category_id'] = this.categoryId;
    data['website'] = this.website;
    data['is_fav'] = this.is_fav;
    data['type_id']=this.type_id;
    data['url']=this.url;

    data['contact_phone']=this.contact_phone;
    if (this.offers != null) {
      data['offers'] = this.offers!.map((v) => v.toJson()).toList();
    }
    if (this.photos != null) {
      data['photos'] = this.photos!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Socials {
  num? id;
  String? name;
  String? link;
  String?icon;

  Socials({
    this.id,
    this.name,
    this.link,
    this.icon
  });

  Socials.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    link = json['link'];
    icon = json['icon'];
  }

}
class AddressModel{
  int? id;
  String? phone;
  String? contactPhone;
  String? address;
  String? addressEn;
  String? longitude;
  String? latitude;
  String? title_ar;
  String? title_en;


  AddressModel({
     this.id,
     this.phone,
     this.contactPhone,
     this.longitude,
     this.latitude,
     this.address,
     this.addressEn,
    this.title_ar,
    this.title_en
});
  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
    id: json["id"],
    phone: json["phone"],
    contactPhone: json["contact_phone"],
      longitude:json["longitude"],
    latitude:json["latitude"],
      address:json["address"],
      addressEn:json["addressEn"],
    title_ar: json["title_ar"],
    title_en: json["title_en"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "phone": phone,
    "contact_phone": contactPhone,
    "longitude":longitude,

  };

}
class SocialLinksModel {
  final dynamic url;
  final String label;
  final bool active;

  SocialLinksModel({
    required this.url,
    required this.label,
    required this.active,
  });

  factory SocialLinksModel.fromJson(Map<String, dynamic> json) => SocialLinksModel(
    url: json["url"],
    label: json["label"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "label": label,
    "active": active,
  };
}


class Classification {
  final int id;
  final String name;
  final String description;
  final String color;
  final List<OfferModel> offers;
  final String photo;
  bool?isExpanded;

  Classification({
    required this.id,
    required this.name,
    required this.description,
    required this.color,
    required this.offers,
    required this.photo,
    this.isExpanded
  });

  factory Classification.fromJson(Map<String, dynamic> json) => Classification(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    color: json["color"],
    offers: List<OfferModel>.from(json["offers"].map((x) => OfferModel.fromJson(x))),
      photo:json["photo"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "color": color,
    "offers": List<dynamic>.from(offers.map((x) => x.toJson())),
  };
}






