import 'package:alefakaltawinea_animals_app/modules/baseScreen/baseScreen.dart';
import 'package:alefakaltawinea_animals_app/modules/notifications/provider/notification_provider.dart';
import 'package:alefakaltawinea_animals_app/modules/user_notifications/user_notifications_provider.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/baseTextStyle.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/myColors.dart';
import 'package:alefakaltawinea_animals_app/utils/my_widgets/laoding_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/Material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../utils/notification/user_notification_model.dart';

class UserNotificationsScreen extends StatefulWidget {
  const UserNotificationsScreen({Key? key}) : super(key: key);

  @override
  State<UserNotificationsScreen> createState() => _UserNotificationsScreenState();
}

class _UserNotificationsScreenState extends State<UserNotificationsScreen> {
  @override
  void initState() {
    context.read<UserNotificationsProvider>().getNotifcations();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
        tag: "SearchScreen",
        showBottomBar: false,
        showSettings: false,
        showWhatsIcon: false,
        body:Column(children: [
          SizedBox(height: 10.h,),
          _header(),
          Expanded(child: Consumer<UserNotificationsProvider>(
            builder: (_,data,__) {
              return data.isLoading?LoadingProgress():data.notifications.isEmpty?
              _noData():
              ListView.builder(
                  itemCount: data.notifications.length,
                  itemBuilder: (_,index){
                return _item(data.notifications[index]);
              });
            }
          ),)
        ],));
  }
  Widget _noData(){
    return Center(child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        Text(tr('there_is_no_notificatiion'),style: S.h4(color: Colors.grey),)

      ],),);
  }
  Widget _item(UserNotificationModel model){
    return Container(
      width:  double.infinity,
      child: Row(children: [
        Image.asset(""),
        SizedBox(width:20.w,),
        Column(children: [
          Text(model.title),
          SizedBox(height:10.w,),
          Text(model.message),
        ],)
      ],),
    );
  }
  Widget _header(){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w,vertical:5.h),
      child: Row(
        mainAxisAlignment:MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios,
              size: 18,
            ),
          ),
          SizedBox(width: 20.w,),
          Expanded(child: Text(tr("notification"),style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w700),),),
        ],),
    );

  }

}
