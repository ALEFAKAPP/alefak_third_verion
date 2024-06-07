import 'package:alefakaltawinea_animals_app/modules/user_notifications/user_notifications_repo.dart';
import 'package:alefakaltawinea_animals_app/utils/notification/user_notification_model.dart';
import 'package:flutter/material.dart';

class UserNotificationsProvider with ChangeNotifier{
  bool isLoading=false;
  List<UserNotificationModel>notifications=[];
  setIsLoading(bool value){
    isLoading=value;
    notifyListeners();
  }
  getNotifcations()async{
    notifications.clear();
    setIsLoading(true);
    final response= await UserNotificationsRepo().getUsernotifications();
    notifications.addAll(response.data??[]);
    setIsLoading(false);
  }

}