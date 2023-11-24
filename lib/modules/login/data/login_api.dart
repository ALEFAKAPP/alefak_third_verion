
import 'dart:convert';
import 'package:alefakaltawinea_animals_app/data/dio/dio_utils.dart';
import 'package:alefakaltawinea_animals_app/data/dio/my_rasponce.dart';
import 'package:alefakaltawinea_animals_app/modules/login/data/returnSuccessModel.dart';
import 'package:alefakaltawinea_animals_app/modules/login/data/user_data.dart';
import 'package:alefakaltawinea_animals_app/modules/login/provider/user_provider_model.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/apis.dart';
import 'package:alefakaltawinea_animals_app/utils/notification/fcm.dart';

class LoginApi{

   sendOtp(String phone) async {
    final url = "${Apis.SEND_OTP2}";
    print('url $url');
    Map<String,dynamic>body={
      "phone":phone,
      "device_token":FCM.FCM_TOKEN
    };
    final response = await BaseDioUtils.request(BaseDioUtils.REQUEST_POST, url,body: body);
    if (response != null && response.statusCode == 200) {
      return ReturnSuccessModel.fromJson(response.data);
      // UserProviderModel().saveUserToPrefrances(json.encode(response.data['data']));
      // return MyResponse<UserData>.fromJson(
      //     json.decode(jsonEncode(response.data)));
    } else {
      return ReturnSuccessModel.fromJson(response?.data);
      return MyResponse<UserData>.init(response!.statusCode.toString(),response.statusMessage!, null);
    }
  }

  Future login(String phone,String otp) async {
    final url = "${Apis.LOGIN2}";
    print('url $url');
    Map<String, dynamic>body = {
      "phone": phone,
      "otp": otp,
      "device_token": FCM.FCM_TOKEN
    };
    final response = await BaseDioUtils.request(
        BaseDioUtils.REQUEST_POST, url, body: body);
    if (response != null && response.statusCode == 200) {
        UserProviderModel().saveUserToPrefrances(
            json.encode(response.data['data']));
        return MyResponse<UserData>.fromJson(
            json.decode(jsonEncode(response.data)));

    }
  else if(response != null && response.statusCode == 2002) {
      return MyResponse<UserData>.init(response.statusCode.toString(),response.statusMessage!, null);
  }else {
      return MyResponse<UserData>.init(response!.statusCode.toString(),response.statusMessage!, null);
    }
  }

  Future<MyResponse<dynamic>> logout() async {
    final url = "${Apis.LOGOUT}";
    final response = await BaseDioUtils.request(BaseDioUtils.REQUEST_POST, url);
    if (response != null && response.statusCode == 200) {
      return MyResponse<dynamic>.fromJson(
          json.decode(jsonEncode(response.data)));
    } else {
      return MyResponse<dynamic>.init(response!.statusCode.toString(),response.statusMessage!, null);
    }
  }
}