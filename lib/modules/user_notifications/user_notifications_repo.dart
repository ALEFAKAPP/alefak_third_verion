import 'dart:convert';

import 'package:alefakaltawinea_animals_app/data/dio/dio_utils.dart';
import 'package:alefakaltawinea_animals_app/data/dio/my_rasponce.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/apis.dart';
import 'package:alefakaltawinea_animals_app/utils/notification/user_notification_model.dart';

class UserNotificationsRepo{
  Future<MyResponse<List<UserNotificationModel>>> getUsernotifications() async {
    String url = "${Apis.GET_USER_NOTIFICATIONS}";
    final response = await BaseDioUtils.request(BaseDioUtils.REQUEST_POST, url);
    if (response != null && response.statusCode == 200) {
      return MyResponse<List<UserNotificationModel>>.fromJson(
          json.decode(jsonEncode(response.data)));
    } else {
      return MyResponse<List<UserNotificationModel>>.init(Apis.CODE_ERROR, "", null);
    }
  }
}