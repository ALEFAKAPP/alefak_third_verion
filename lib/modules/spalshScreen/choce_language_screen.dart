import 'package:alefakaltawinea_animals_app/modules/homeTabsScreen/homeTabsScreen.dart';
import 'package:alefakaltawinea_animals_app/modules/login/login_screen.dart';
import 'package:alefakaltawinea_animals_app/modules/otp/phone_screen.dart';
import 'package:alefakaltawinea_animals_app/modules/serviceProviders/list_screen/data/serviceProvidersModel.dart';
import 'package:alefakaltawinea_animals_app/modules/spalshScreen/splash_two_screen.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/baseTextStyle.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/myUtils.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/my_fonts.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/providers.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/resources.dart';
import 'package:alefakaltawinea_animals_app/utils/my_widgets/transition_image.dart';
import 'package:alefakaltawinea_animals_app/utils/providers.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../utils/my_utils/baseDimentions.dart';
import '../../utils/my_utils/constants.dart';
import '../../utils/my_utils/myColors.dart';
import '../baseScreen/baseScreen.dart';
import '../introWizard/intro_wizard_screen.dart';
import 'data/regions_api.dart';

class ChoceLanguageScreen extends StatefulWidget {
  const ChoceLanguageScreen({Key? key}) : super(key: key);

  @override
  State<ChoceLanguageScreen> createState() => _ChoceLanguageScreenState();
}

class _ChoceLanguageScreenState extends State<ChoceLanguageScreen> {
  UtilsProviderModel? utilsProviderModel;
  RegionsApi regionsApi=RegionsApi();


  @override
  void initState() {
    super.initState();
    utilsProviderModel =
        Provider.of<UtilsProviderModel>(context, listen: false);

  }

  @override
  Widget build(BuildContext context) {
    utilsProviderModel = Provider.of<UtilsProviderModel>(context, listen: true);
    return Scaffold(
        body: Stack(
          alignment:AlignmentDirectional.topStart,
          fit:StackFit.expand ,
          children: [
            Container(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 403.h,),
                  TransitionImage(
                    "assets/images/chose_lag_name_img.png",
                    width:250.w ,
                    height:90.h ,
                  ),
                  SizedBox(height: 30.h,),
                  _button("عربي", () async {
                    await utilsProviderModel!.setCurrentLocal(
                        context, Locale("ar", "EG"));
                    setState(() {
                      getRegions();
                      getAppInfo();
                    });
                    if(Constants.prefs!.getBool(Constants.IS_FIRST_TIME)??true){
                      MyUtils.navigate(context, IntroWizardScreen());
                    }else{
                      print('tessss');
                      MyUtils.navigate(context, LoginScreen());
                    }
                  },),
                  SizedBox(
                    height: 18.h,
                  ),
                  _button("English", () async {

                    await utilsProviderModel!.setCurrentLocal(
                        context, Locale("en", "US"));
                    await getRegions();
                    getAppInfo();

                    if(Constants.prefs!.getBool(Constants.IS_FIRST_TIME)??true){
                      MyUtils.navigateReplaceCurrent(context, IntroWizardScreen());
                    }else{
                      MyUtils.navigate(context, LoginScreen());
                    }        })
                ],),),
            Container(
              margin: EdgeInsets.only(bottom: 300.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25),bottomRight: Radius.circular(25)),
                image: DecorationImage(
                  fit: BoxFit.cover,
                    image: AssetImage("assets/images/chage_lang_img.jpeg"))
              ),


            ),

          ],));
  }

  Widget _button(String title, Function ontClick) {
    return InkWell(onTap: () {
      ontClick();
    }, child: Container(
      padding: EdgeInsets.only(bottom:2.h),
      height: 40.h,
      width: 190.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10),),
        color: C.BASE_BLUE
      ),
      child: Center(child: Text(title, style: TextStyle(fontSize:25.sp,fontWeight: FontWeight.w500,color: Colors.white),
        textAlign: TextAlign.center,),),
    ));
  }

   getRegions()async{
    Constants.STATES.clear();
    await regionsApi.getRegions().then((value) {
      Constants.REGIONS=value.data;
      for(int i=0;i<Constants.REGIONS.length;i++){
        Constants.STATES.addAll( Constants.REGIONS[i].getStates!);
      }
    });

  }
   getAppInfo()async{
    await regionsApi.getAppInfo().then((value) {
      Constants.APP_INFO=value.data;
    });

  }
}
