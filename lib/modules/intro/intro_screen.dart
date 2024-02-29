import 'package:alefakaltawinea_animals_app/modules/categories_screen/new_main_categories_screen.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/baseTextStyle.dart';
import 'package:alefakaltawinea_animals_app/views/cards/BuyCard/steps/StepOne.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/my_utils/baseDimentions.dart';
import '../../utils/my_utils/constants.dart';
import '../../utils/my_utils/myColors.dart';
import '../../utils/my_utils/myUtils.dart';
import '../../utils/my_widgets/transition_image.dart';
import '../baseScreen/baseScreen.dart';
import '../cart/add_cart_screen.dart';
import '../categories_screen/mainCategoriesScreen.dart';

class IntroScreen extends StatefulWidget {
  bool fromaddcard;
  IntroScreen({Key? key,this.fromaddcard=false}) : super(key: key);

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  void initState() {
    if(widget.fromaddcard){
      MyUtils.navigate(context, BuyCard());
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  BaseScreen(
      showSettings: false,
      showBottomBar: false,
      padding: EdgeInsets.zero,
      tag: "AdoptionScreen",
      body: Column(
        children: [
          Container(
            width: double.infinity,
              height: 265.h,
              decoration: BoxDecoration(
                 image: DecorationImage(image: AssetImage("assets/images/new_intro_img.jpeg"),fit: BoxFit.cover),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
              ),
          ),
          SizedBox(height: 16.h,) ,
          Text(tr("intro_title1"),textAlign: TextAlign.center,style: TextStyle(fontSize: 23.sp,fontWeight: FontWeight.w800),),
          Text(tr("intro_title2"),textAlign: TextAlign.center,style: TextStyle(fontSize: 21.sp,fontWeight: FontWeight.w400),),
          SizedBox(height: 42.h,) ,
          Text(tr("intro_title3"),textAlign: TextAlign.center,style: TextStyle(color: C.BASE_BLUE,fontSize: 18.sp,fontWeight: FontWeight.w400),),
          SizedBox(height: 14.h,) ,
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 40.w),
            child: Column(children: [
              Row(children: [Icon(Icons.check_circle_outline,size: 20,),
                SizedBox(width:5.w,),
                Text(tr("intro_desc1"),style: TextStyle(fontSize: 15.sp,fontWeight:FontWeight.w400))]),

            ],),
          ),
          SizedBox(height: 4.h,) ,
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 40.w),
            child: Column(children: [
              Row(children: [Icon(Icons.check_circle_outline,size: 20,),
                SizedBox(width:5.w,),
                Text(tr("intro_desc2"),style: TextStyle(fontSize: 15.sp,fontWeight:FontWeight.w400))]),

            ],),
          ),
          SizedBox(height: 4.h,) ,
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 40.w),
            child: Column(children: [
              Row(children: [Icon(Icons.check_circle_outline,size: 20,),
                SizedBox(width:5.w,),
                Text(tr("intro_desc3"),style: TextStyle(fontSize: 15.sp,fontWeight:FontWeight.w400))]),

            ],),
          ),
          SizedBox(height: 4.h,) ,
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 40.w),
            child: Column(children: [
              Row(children: [Icon(Icons.check_circle_outline,size: 20,),
                SizedBox(width:5.w,),
                Text(tr("intro_desc4"),style: TextStyle(fontSize: 15.sp,fontWeight:FontWeight.w400))]),

            ],),
          ),
          SizedBox(height: 25.h,) ,

          _addCartBtn(),
          _skipBtn()

        ],
      ),
    );
  }
  Widget _whiteContainer() {
    return Container(
      margin: EdgeInsets.only(top: D.default_250),
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(D.default_50),
              topRight: Radius.circular(D.default_50)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                offset: Offset(1, 1),
                blurRadius: 1,
                spreadRadius: 0.5)
          ]),
    );
  }
  Widget _addCartBtn() {
    return Center(
      child: InkWell(
        onTap: () {
          MyUtils.navigate(context, BuyCard());
        },
        child: Container(
          width: 170.w,
          margin: EdgeInsets.symmetric(vertical:5.h),
          padding: EdgeInsets.only(
              left: 30.w,
              right: 30.w,
              top: 3.h,
              bottom: 3.h),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: C.BASE_BLUE,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    offset: Offset(1, 1),
                    blurRadius: 1,
                    spreadRadius: 1)
              ]),
          child: Text(
            tr("subscribe"),
            style: TextStyle(fontSize: 20.sp,color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
  Widget _skipBtn() {
    return Center(
      child: InkWell(
        onTap: () async{
          await Constants.prefs!.setBool("intro${Constants.currentUser!.id}",true);
          MyUtils.navigateAsFirstScreen(context, NewMainCategoriesScreen());
          },
        child: Container(
          width: 170.w,
          margin: EdgeInsets.symmetric(vertical:5.h),
          padding: EdgeInsets.only(
              left: 30.w,
              right: 30.w,
              top: 3.h,
              bottom: 3.h),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: C.BASE_BLUE,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    offset: Offset(1, 1),
                    blurRadius: 1,
                    spreadRadius: 1)
              ]),
          child: Text(
            tr("skip"),
            style: TextStyle(fontSize: 20.sp,color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }



}
