import 'dart:io';
import 'package:alefakaltawinea_animals_app/core/servies/firebase/analytics_helper.dart';
import 'package:alefakaltawinea_animals_app/modules/ads/provider/ads_slider_provider.dart';
import 'package:alefakaltawinea_animals_app/modules/baseScreen/baseScreen.dart';
import 'package:alefakaltawinea_animals_app/modules/categories_screen/mainCategoriesScreen.dart';
import 'package:alefakaltawinea_animals_app/modules/categories_screen/new_main_categories_screen.dart';
import 'package:alefakaltawinea_animals_app/modules/intro/intro_screen.dart';
import 'package:alefakaltawinea_animals_app/modules/login/provider/user_provider_model.dart';
import 'package:alefakaltawinea_animals_app/modules/serviceProviderAccount/SpHomeScreen.dart';
import 'package:alefakaltawinea_animals_app/modules/spalshScreen/PageMaintenanceScreen.dart';
import 'package:alefakaltawinea_animals_app/modules/spalshScreen/PageUpdateScreen.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/apis.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/baseDimentions.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/constants.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/myColors.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/myUtils.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/providers.dart';
import 'package:alefakaltawinea_animals_app/utils/my_widgets/transition_image.dart';
import 'package:alefakaltawinea_animals_app/utils/my_widgets/update_app_popup.dart';
import 'package:alefakaltawinea_animals_app/utils/notification/fcm.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../app_states/provider/app_state_provider.dart';
import 'choce_language_screen.dart';
import 'data/app_info_model.dart';
import 'data/regions_api.dart';



class SplashScreen extends StatefulWidget{
  bool? toHome;
  SplashScreen({this.toHome=false,Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{

  SharedPreferences? prefs;
  UtilsProviderModel? utilsProviderModel;
  RegionsApi regionsApi=RegionsApi();
  double _minimumVersion = 1.0 ;

  @override
  void initState() {
    super.initState();
    if(Platform.isIOS){
      Constants.DEVICE_TYPE="ios";
    }else{
      Constants.DEVICE_TYPE="android";
    }
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      AnalyticsHelper().setScreen(screenName: "splash_screen");
      await _initPref(context);
      await getAppInfo();

      if( Constants.APP_INFO!=null){
        if((Constants.APP_INFO!.maintenanceMode)!= null && (Constants.APP_INFO!.maintenanceMode??true)){
          MyUtils.navigateAsFirstScreen(context, PageMaintenanceScreen());
        }else if(GetPlatform.isAndroid ) {
          _minimumVersion = Constants.APP_INFO!.appMinimumVersionAndroid!;
        }else if(GetPlatform.isIOS) {
          _minimumVersion = Constants.APP_INFO!.appMinimumVersionIos!;
        }

        if(Constants.APP_VERSIONs < _minimumVersion) {
          MyUtils.navigateAsFirstScreen(context, PageUpdateScreen());
        }else{
          login();
        }
      }else{
        login();
      }

    });


  }
  @override
  Widget build(BuildContext context) {
    utilsProviderModel=Provider.of<UtilsProviderModel>(Constants.mainContext!,listen: true);
    Constants.utilsProviderModel=utilsProviderModel;


    return BaseScreen(
        tag: "SplashScreen",
        showSettings: false,
        showBottomBar: false,
        showWhatsIcon:false,
        body: Stack(
          alignment:AlignmentDirectional.center,
          children: [
            Container(width: double.infinity,height: double.infinity,color: C.BASE_BLUE,),
            _logoTitleItem(),
            Positioned(child:TransitionImage(
              "assets/images/splash_animals.png",
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.fitHeight,
            ),bottom: 0.0, )

          ],)
    );
  }
  Widget _logoTitleItem(){
    return TransitionImage(
      "assets/images/logo_with_name.png",
      width: D.default_300*0.9,
      height: D.default_300*0.9,
    );
  }


  getAppInfo()async{
    await regionsApi.getAppInfo().then((value) {
      if(value.data==null){
        regionsApi.getAppInfo().then((value) {
          Constants.APP_INFO=value.data as AppInfoModel;
        });
      }
      Constants.APP_INFO=value.data as AppInfoModel;
    });
  }

  _initPref(BuildContext ctx)async{
    if(Constants.prefs==null){
      prefs =  await SharedPreferences.getInstance();
      Constants.prefs=prefs;
    }
    if((Constants.prefs!.getString(Constants.TOKEN_KEY)??'').isNotEmpty){
      Apis.TOKEN_VALUE=Constants.prefs!.getString(Constants.TOKEN_KEY)??'';
    }
    if(Constants.prefs!.get(Constants.LANGUAGE_KEY)!=null){
      if(Constants.prefs!.get(Constants.LANGUAGE_KEY)=="ar"){
        utilsProviderModel!.setLanguageState("ar");
        utilsProviderModel!.setCurrentLocal(ctx, Locale('ar','EG'));
      }else{
        utilsProviderModel!.setLanguageState("en");
        utilsProviderModel!.setCurrentLocal(ctx, Locale('en','US'));
      }
    }else{
      utilsProviderModel!.setLanguageState("ar");
      utilsProviderModel!.setCurrentLocal(ctx, Locale('ar','EG'));
    }

  }
  void setLocal()async{
    if(utilsProviderModel!.isArabic){
      await context.setLocale(Locale('ar', 'EG'));
      await EasyLocalization.of(context)!.setLocale(Locale('ar', 'EG'));
      utilsProviderModel!.currentLocalName="العربية";
      Constants.SELECTED_LANGUAGE="ar";
      await utilsProviderModel!.setLanguageState("ar");
      await Constants.prefs!.setString(Constants.LANGUAGE_KEY!, "ar");
    }else{
      await context.setLocale(Locale('en', 'US'));
      await EasyLocalization.of(context)!.setLocale(Locale('en', 'US'));
      utilsProviderModel!.currentLocalName="English";
      Constants.SELECTED_LANGUAGE="en";
      utilsProviderModel!.setLanguageState("en");
      await Constants.prefs!.setString(Constants.LANGUAGE_KEY!, "en");
    }
  }
  login()async{
    bool isLogin=false;
    try{
       isLogin=await UserProviderModel().getSavedUser(context)??false;
    }catch(e){
       isLogin=false;
    }


    if(isLogin){
      if(Constants.currentUser!.userTypeId.toString()=="6"){
        MyUtils.navigateAsFirstScreen(context, SpHomeScreen());
      }
      else{
        bool isShowed=await Constants.prefs!.getBool("intro${Constants.currentUser!.id}")??false;
        if(!isShowed&&Constants.APPLE_PAY_STATE){
          MyUtils.navigateAsFirstScreen(context, IntroScreen());
        }else{
          if(widget.toHome??false){
            MyUtils.navigateReplaceCurrent(context, NewMainCategoriesScreen());
          }else{
              MyUtils.navigateReplaceCurrent(context, NewMainCategoriesScreen());
          }
          // }
        }
      }
    }else{
      MyUtils.navigateReplaceCurrent(context, ChoceLanguageScreen());
    }
  }
}
