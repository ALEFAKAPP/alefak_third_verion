import 'package:alefakaltawinea_animals_app/shared/constance/fonts.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/Material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../utils/my_utils/baseDimentions.dart';
import '../../../utils/my_utils/baseTextStyle.dart';
import '../../../utils/my_utils/myColors.dart';
import '../../../utils/my_utils/my_fonts.dart';
import '../../../utils/my_widgets/transition_image.dart';

class thirdIntroScreen extends StatefulWidget {
  const thirdIntroScreen({Key? key}) : super(key: key);

  @override
  State<thirdIntroScreen> createState() => _thirdIntroScreenState();
}

class _thirdIntroScreenState extends State<thirdIntroScreen> {
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
                SizedBox(height: 438.h,),
                Text(tr("intro3_header"),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: C.BASE_BLUE,fontSize: 30.sp,fontWeight: FontWeight.w800),),
                SizedBox(height: 15.h,),
                Text(tr("intro3_title1"),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 19.sp,fontWeight: FontWeight.w400),),



              ],),),
          Container(
            margin: EdgeInsets.only(bottom: 240.h),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25),bottomRight: Radius.circular(25)),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/intro_third_img.jpeg"))
            ),


          ),
        ],
      ),
    );
  }

  Widget _title(){
    return Positioned(child:Container(
      width:MediaQuery.of(context).size.width ,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(tr("intro3_title"),style:S.h1Bold(color:Colors.white,fontSize:D.size(14),font: MyFonts.VEXA),textAlign: TextAlign.center,),
          SizedBox(height: D.size(5)),
          Text(tr("intro3_description"),style:TextStyle(color:Colors.white,fontFamily: fontPrimary,fontSize:D.size(7),height:D.textSize(0.45)),textAlign:TextAlign.center)
        ],),),top: D.height(4));
  }

}
