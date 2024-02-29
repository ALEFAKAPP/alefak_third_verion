import 'package:alefakaltawinea_animals_app/shared/constance/fonts.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/baseDimentions.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/baseTextStyle.dart';
import 'package:alefakaltawinea_animals_app/utils/my_widgets/edite_card_popup.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/Material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../utils/my_utils/myColors.dart';
import '../../../utils/my_utils/my_fonts.dart';
import '../../../utils/my_widgets/transition_image.dart';

class SecondIntroScreen extends StatefulWidget {
  const SecondIntroScreen({Key? key}) : super(key: key);

  @override
  State<SecondIntroScreen> createState() => _SecondIntroScreenState();
}

class _SecondIntroScreenState extends State<SecondIntroScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: C.BASE_ORANGE,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 422.h,),
                Text(tr("second_itro_title"),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: C.BASE_BLUE,fontSize: 20.sp,fontWeight: FontWeight.w500),),
                SizedBox(height: 35.h,),
                item(tr("intro2_title1")),
                item(tr("intro2_title2")),
                item(tr("intro2_title3")),
                item(tr("intro2_title4")),
              ],),),
          Container(
            margin: EdgeInsets.only(bottom: 240.h),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25),bottomRight: Radius.circular(25)),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/intro_second_img.jpeg"))
            ),


          ),
        ],
      ),
    );
  }
  Widget item(String title){
    return Padding(
      padding: EdgeInsets.only(left: 30.w,right:30.w,bottom: 6.h),
      child:
      Row(children: [
        Icon(Icons.check_circle_outline,size: 16.h,),
        SizedBox(width: 5.w,),
        Expanded(child: Text(title,style: TextStyle(fontSize: 17.sp,fontWeight: FontWeight.w500),))
      ],),);
  }



}
