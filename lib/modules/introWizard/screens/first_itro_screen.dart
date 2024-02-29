
import 'package:alefakaltawinea_animals_app/utils/my_utils/baseDimentions.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/myColors.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/my_fonts.dart';
import 'package:alefakaltawinea_animals_app/utils/my_widgets/transition_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/Material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/my_utils/baseTextStyle.dart';

class FirstIntroScreen extends StatefulWidget {
  const FirstIntroScreen({Key? key}) : super(key: key);

  @override
  State<FirstIntroScreen> createState() => _FirstIntroScreenState();
}

class _FirstIntroScreenState extends State<FirstIntroScreen> {
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
                SizedBox(height: 410.h,),
                Text("بطاقة أليفك التعاونية",style: TextStyle(fontSize: 24.sp,fontWeight: FontWeight.w800),),
                Text("أول بطاقة رقمية للرعاية البيطرية",style: TextStyle(fontSize: 22.sp,fontWeight: FontWeight.w500),),
                SizedBox(height: 19.h,),
                TransitionImage(
                  "assets/images/intro_card_img.png",
                  fit: BoxFit.cover,
                  height: 168,
                ),
                SizedBox(height: 10.h,),

              ],),),
          Container(
            margin: EdgeInsets.only(bottom: 240.h),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25),bottomRight: Radius.circular(25)),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/intro_first_screen_img.jpeg"))
            ),


          ),
        ],
      ),
    );
  }


}
