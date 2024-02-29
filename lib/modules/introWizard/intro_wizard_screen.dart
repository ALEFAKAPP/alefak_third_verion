import 'package:alefakaltawinea_animals_app/modules/introWizard/screens/first_itro_screen.dart';
import 'package:alefakaltawinea_animals_app/modules/introWizard/screens/fivth_intro_screen.dart';
import 'package:alefakaltawinea_animals_app/modules/introWizard/screens/forth_intro_screen.dart';
import 'package:alefakaltawinea_animals_app/modules/introWizard/screens/second_intro_screen.dart';
import 'package:alefakaltawinea_animals_app/modules/introWizard/screens/theerd_intro_screen.dart';
import 'package:alefakaltawinea_animals_app/modules/login/login_screen.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/baseTextStyle.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/my_utils/baseDimentions.dart';
import '../../utils/my_utils/constants.dart';
import '../../utils/my_utils/myColors.dart';
import '../../utils/my_utils/myUtils.dart';
import '../baseScreen/baseScreen.dart';
import '../spalshScreen/splash_two_screen.dart';



class IntroWizardScreen extends StatefulWidget {
  const IntroWizardScreen({Key? key}) : super(key: key);

  @override
  State<IntroWizardScreen> createState() => _IntroWizardScreenState();
}

class _IntroWizardScreenState extends State<IntroWizardScreen> {
  final _controller = PageController();
  int _currentSliderPager=0;
  List<Widget> sliderItems=[
    FirstIntroScreen(),
    SecondIntroScreen(),
    thirdIntroScreen(),
  ];


  @override
  void initState() {
    super.initState();
    Constants.prefs!.setBool(Constants.IS_FIRST_TIME,false);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        body:Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          Expanded(child: PageView(
            children: sliderItems,
            controller: _controller,
            onPageChanged: (currentPage) {
              setState(() {
                _currentSliderPager=currentPage;
              });
            },
          )),
            SizedBox(height: 5.h,),
            _dots(),
            SizedBox(height: 5.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              _skipBtn(),
              _nextBtn(),
            ],),

            SizedBox(height: 15.h,)
        ],));
  }
  Widget _dots(){
    return SizedBox(

      child: Center(
        child: Container(
          width: sliderItems.length*30.w,
            decoration:  BoxDecoration(
              color: C.BASE_BLUE.withOpacity(0.2),
              borderRadius: BorderRadius.all(Radius.circular(2)),
            ),
          child: Row(children:List.generate(sliderItems.length, (index){
            return Container(
              height: 5.5.h,
                width: 30.w,
                decoration:  BoxDecoration(
                  color: index==_currentSliderPager?C.BASE_BLUE:Colors.transparent,
                  borderRadius: BorderRadius.all(Radius.circular(2)),
                )
            );
          }),)),
      ),
    );
  }





  Widget _skipBtn(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        InkWell(
          onTap: (){
            MyUtils.navigateReplaceCurrent(context, LoginScreen());
          },
          child: Container(
            height:25.h,
            width: 70.w,
          margin: EdgeInsets.only(left: 25.w,right: 25.w),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: C.BASE_BLUE,
            
          ),
          child: Center(child: Text(tr(_currentSliderPager<sliderItems.length-1?tr("skip"):tr("start")),style: S.h3(color: Colors.white,fontSize: D.textSize(3.5)),),),
        ),),
      ],
    );
  }
  Widget _nextBtn(){
    return Visibility(
      visible: _currentSliderPager<sliderItems.length-1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          InkWell(
            onTap: (){
              if(_currentSliderPager<sliderItems.length-1){
                _controller.animateToPage(_currentSliderPager+1, duration: Duration(milliseconds: 500), curve: Curves.ease);
            }
            },
            child: Container(
              height:25.h,
              width: 70.w,
              margin: EdgeInsets.only(left: 25.w,right: 25.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: C.BASE_BLUE,

              ),
              child: Center(child: Text(tr("Next"),style: S.h3(color: Colors.white,fontSize: D.textSize(3.5)),),),
            ),),
        ],
      ),
    );
  }


}
