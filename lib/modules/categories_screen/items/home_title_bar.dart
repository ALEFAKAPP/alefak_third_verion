import 'package:alefakaltawinea_animals_app/utils/my_utils/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/Material.dart';
import 'package:flutter/cupertino.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomeTitleBar extends StatelessWidget {
  const HomeTitleBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 2.h,horizontal: 4.w),
    child: Row(children: [
       Expanded(
         flex: 1,
           child: Row(children: [
         Text('جدة',style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w800),),
         SizedBox(width: 2.w,),
         Image.asset('assets/images/home_dropdowen_icon.png',
           width: 4.w,
           height: 4.w,
         ),
       ],)),
      Expanded(
        flex: 2,
          child: Center(child:Text("${tr("welcome_back")} ${Constants.currentUser!=null?(Constants.currentUser!.name):''}",style: TextStyle(fontSize: 17.sp,fontWeight: FontWeight.w800),),)),
      Expanded(child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
        Image.asset('assets/images/notification_ic.png',
          width: 7.w,
          height: 7.w,
        )
      ],))
      
      /// title
      /// notification icon
    ],),);
  }
}
