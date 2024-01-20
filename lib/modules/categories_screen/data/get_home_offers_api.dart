
import 'dart:convert';
import 'package:alefakaltawinea_animals_app/data/dio/dio_utils.dart';
import 'package:alefakaltawinea_animals_app/data/dio/my_rasponce.dart';
import 'package:alefakaltawinea_animals_app/modules/categories_screen/data/categories_model.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/apis.dart';

import 'home_offers_model.dart';

class GetHomeOffersListApi{

  Future<MyResponse<HomeOffersModel>> getHomeOffers() async {
    final url = "${Apis.GET_HOME_OFFERS}";

    final response = await BaseDioUtils.request(BaseDioUtils.REQUEST_GET, url);
    if (response != null && response.statusCode == 200) {
      return MyResponse<HomeOffersModel>.fromJson(
          json.decode(jsonEncode(response.data)));
    } else {
      return MyResponse<HomeOffersModel>.init(Apis.CODE_ERROR, "", null);
    }
  }
}