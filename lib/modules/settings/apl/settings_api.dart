
import 'dart:convert';
import 'package:alefakaltawinea_animals_app/data/dio/dio_utils.dart';
import 'package:alefakaltawinea_animals_app/data/dio/my_rasponce.dart';
import 'package:alefakaltawinea_animals_app/modules/categories_screen/data/alefak_in_lies_model.dart';
import 'package:alefakaltawinea_animals_app/modules/login/data/user_data.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/apis.dart';

class SettingsApi{

  Future<MyResponse<dynamic>> contactUs(
  String name,
  String message,
  String phone,
  String contact_time,
  ) async {
    final url = "${Apis.CONTACT_US}";
    Map<String,dynamic>body={
      "name":name,
      "phone":phone,
      "message":message,
      "contact_time":contact_time,
    };
    final response = await BaseDioUtils.request(BaseDioUtils.REQUEST_POST, url,body: body);
    if (response != null && response.statusCode == 200) {
      return MyResponse<dynamic>.fromJson(
          json.decode(jsonEncode(response.data)));
    } else {
      return MyResponse<UserData>.init(response!.statusCode.toString(),response.statusMessage!, null);
    }
  }
  Future<MyResponse<dynamic>> registerShop(
      String name,
      String address,
      String phone,
      String manager_name,
      ) async {
    final url = "${Apis.REGISTER_SHOP}";
    Map<String,dynamic>body={
      "name":name,
      "address":address,
      "phone":phone,
      "manager_name":manager_name,
    };
    final response = await BaseDioUtils.request(BaseDioUtils.REQUEST_POST, url,body: body);
    if (response != null && response.statusCode == 200) {
      return MyResponse<dynamic>.fromJson(
          json.decode(jsonEncode(response.data)));
    } else {
      return MyResponse<UserData>.init(response!.statusCode.toString(),response.statusMessage!, null);
    }
  }
  Future<MyResponse<List<AlefakInLinesData>>> getAlefakInLines() async {
    final url = "${Apis.GET_ALEFAK_INN_LINES}";
    final response = await BaseDioUtils.request(BaseDioUtils.REQUEST_GET, url);
    if (response != null && response.statusCode == 200) {
      return MyResponse<List<AlefakInLinesData>>.fromJson(
          json.decode(jsonEncode(response.data)));
    } else {
      return MyResponse<List<AlefakInLinesData>>.init(response!.statusCode.toString(),response.statusMessage!, null);
    }
  }
}