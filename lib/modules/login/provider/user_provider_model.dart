import 'dart:convert';

import 'package:alefakaltawinea_animals_app/data/dio/my_rasponce.dart';
import 'package:alefakaltawinea_animals_app/modules/categories_screen/mainCategoriesScreen.dart';
import 'package:alefakaltawinea_animals_app/modules/categories_screen/new_main_categories_screen.dart';
import 'package:alefakaltawinea_animals_app/modules/login/data/login_api.dart';
import 'package:alefakaltawinea_animals_app/modules/login/data/returnSuccessModel.dart';
import 'package:alefakaltawinea_animals_app/modules/login/data/user_data.dart';
import 'package:alefakaltawinea_animals_app/modules/login/login_screen.dart';
import 'package:alefakaltawinea_animals_app/modules/otp/otp_screem.dart';
import 'package:alefakaltawinea_animals_app/modules/otp/phone_screen.dart';
import 'package:alefakaltawinea_animals_app/modules/profile/data/update_profile_api.dart';
import 'package:alefakaltawinea_animals_app/modules/registeration/data/registeration_api.dart';
import 'package:alefakaltawinea_animals_app/modules/registeration/registration_screen.dart';
import 'package:alefakaltawinea_animals_app/modules/spalshScreen/data/regions_api.dart';
import 'package:alefakaltawinea_animals_app/modules/spalshScreen/spalshScreen.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/apis.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/constants.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/myUtils.dart';
import 'package:alefakaltawinea_animals_app/utils/notification/fcm.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../intro/intro_screen.dart';
import '../../serviceProviderAccount/SpHomeScreen.dart';
import '../../spalshScreen/splash_two_screen.dart';

class UserProviderModel with ChangeNotifier{

  ///.....ui controllers.........
  bool isLoading=false;
  void setIsLoading(bool value){
    isLoading=value;
    notifyListeners();
  }
  /// ...........login............
  UserData? currentUser;
  LoginApi loginApi=LoginApi();
  UpdateProfileApi updateProfileApi=UpdateProfileApi();

  checkOtp(String phone,String otp,BuildContext ctx,bool isSplash) async {
    setIsLoading(true);
    //bool isLoged= await getSavedUser(ctx);

    if(true){
      MyResponse<UserData> response =
      await loginApi.login(phone,otp);

      if (response.status == Apis.CODE_SUCCESS &&response.data!=null){
        UserData user=response.data;
        if(user.activate=="1"){
          setCurrentUserData(user);
          setIsLoading(false);
          await Constants.prefs!.setString(Constants.TOKEN_KEY!,user.token??'');
          await RegionsApi().getAppInfo();
          if(user.userTypeId.toString()=="6"){
            MyUtils.navigateAsFirstScreen(ctx, SpHomeScreen());
          }else{
            bool isShowed=await Constants.prefs!.getBool("intro${Constants.currentUser!.id}")??false;
            if(!isShowed&&Constants.APPLE_PAY_STATE){
              await FCM().openClosedAppFromNotification();
              MyUtils.navigateAsFirstScreen(ctx, IntroScreen());
            }else{
              await FCM().openClosedAppFromNotification();
              MyUtils.navigateAsFirstScreen(ctx, NewMainCategoriesScreen());
            }
          }
        }else{
          setIsLoading(false);
          /// NAVIGATE TO SMS SCREEN
          MyUtils.navigate(ctx, LoginScreen());
        }

      }else if(response.status == '2002'){
        setIsLoading(false);
        /// NAVIGATE TO SMS SCREEN
        MyUtils.navigate(ctx, RegistrationScreen(phone: phone,));
      }else if(response.status == Apis.CODE_ACTIVE_USER){
        setIsLoading(false);
        /// NAVIGATE TO SMS SCREEN
        MyUtils.navigate(ctx, LoginScreen());
      }else if(response.status == Apis.CODE_SHOW_MESSAGE ){
        setIsLoading(false);
        await Fluttertoast.showToast(msg: "${response.msg}");
      }
      notifyListeners();
    }



  }

  sendOtp(String phone,BuildContext ctx,bool isSplash) async {
    setIsLoading(true);
    //bool isLoged= await getSavedUser(ctx);
    if(true){

      try{
        ReturnSuccessModel response =  await loginApi.sendOtp(phone);
        setIsLoading(false);

        if (response.status == true){
          MyUtils.navigateAsFirstScreen(ctx, OtpScreen('ksa', 'title',phone));
          setIsLoading(false);
        }else if(response.status == Apis.CODE_SHOW_MESSAGE ){
          print("login error: ${response.msg}");
          await Fluttertoast.showToast(msg: "${response.msg}");
        }
      }catch(e){
        setIsLoading(true);
      }
      notifyListeners();
    }



  }

  Future<bool> getSavedUser(BuildContext ctx)async{
    String user=await Constants.prefs!.getString(Constants.SAVED_USER_KEY!) ?? '';
    print('test hisham $user');

      if(user !="null" && user.isNotEmpty &&!user.contains("user_type_id: 6")){
         Constants.currentUser=UserData.fromJson(jsonDecode(user));
         bool? subscribStaus=await Constants.prefs!.getBool(Constants.SUBSCRIBE_STATUS_KEY!);
         Constants.currentUser!.valid_subscriptions=(subscribStaus??false)?1:0;
         setCurrentUserData(Constants.currentUser!);
        setIsLoading(false);
        await Constants.prefs!.setString(Constants.TOKEN_KEY!,Constants.currentUser!.token??"");
        Apis.TOKEN_VALUE=Constants.currentUser!.token??'';
        return true;
      }

    return false;
  }
  saveUserToPrefrances(String user)async{
    await Constants.prefs!.setString(Constants.SAVED_USER_KEY!,user);
  }
  setCurrentUserData(UserData user,)async{
    await Constants.prefs!.setBool(Constants.SUBSCRIBE_STATUS_KEY!,(user.valid_subscriptions??0)>0);
    currentUser=user;
  Constants.currentUser=user;
  Apis.TOKEN_VALUE=user.token!;
  notifyListeners();
}

/// ............REGISTER...............
  RegisterationApi registerationApi=RegisterationApi();
  register(BuildContext ctx,String name,String email,String phone,String city,{int regionId=1,int stateId=1,bool fromaddcard=false}) async {
    setIsLoading(true);
    MyResponse<UserData> response =
    await registerationApi.register( name, email, phone, city, regionId:3, stateId:3155);
    if (response.status == Apis.CODE_SUCCESS &&response.data!=null){
      UserData user=response.data;
      setCurrentUserData(user);
      setIsLoading(false);
      await Constants.prefs!.setString(Constants.TOKEN_KEY!,user.token??'');

      bool isShowed=await Constants.prefs!.getBool("intro${Constants.currentUser!.id}")??false;
      if(!isShowed&&Constants.APPLE_PAY_STATE){
        await FCM().openClosedAppFromNotification();
        MyUtils.navigateAsFirstScreen(ctx, IntroScreen());
      }else{
        await FCM().openClosedAppFromNotification();
        MyUtils.navigateAsFirstScreen(ctx, NewMainCategoriesScreen(navigateTo: (){
          String message = '''حياك الله ${Constants.currentUser!.name}
شكراً على تسجيلك معنا واهتمامك
في منصة أليفك التعاونية 😻

متحمسين تاخد جولة في التطبيق ولمعرفة المزيد عن التطبيق:
https://alefak.com?type=about

وفريقنا بيكون معك على تواصل 
للإجابة على جميع الاستفسارات:
https://wa.link/6p2g3l

 وهديتنا كود خصم على سعر اصدار بطاقة أليفك التعاونية لمدة 48 ساعة
كود الخصم: AT25
بالإضافة لفرشاة البخار الكهربائية 3في1 للتدليك والتصفيف ولإزالة الشعر 😻
شامل التوصيل 🚚''';
          MyUtils.openwhatsapp(ctx,message:message );
        },));
      }

    }else if(response.status == Apis.CODE_ACTIVE_USER &&response.data!=null){
      UserData user=response.data;
      setCurrentUserData(user);
      setIsLoading(false);
      // MyUtils.navigateReplaceCurrent(ctx, OtpScreen("register",tr('register_otp'),code:response.code.toString(),fromaddcard:fromaddcard ));
    }else if(response.status == Apis.CODE_SHOW_MESSAGE ){
      print("login error: ${response.msg}");
      setIsLoading(false);
      await Fluttertoast.showToast(msg: "${response.msg}");
    }
    notifyListeners();

  }
/// ...........update profile............
  updateProfile(BuildContext ctx,String name,String email,String phone,String city) async {
    setIsLoading(true);
    MyResponse<UserData> response =
    await updateProfileApi.updateProfile( name, email, phone,city);

    if (response.status == Apis.CODE_SUCCESS &&response.data!=null){
      UserData user=response.data;
      setCurrentUserData(user);
      saveUserToPrefrances(jsonEncode(user.toJson()));
      setIsLoading(false);
      await Fluttertoast.showToast(msg: "${response.msg}");

      if(user.activate=="0"){
        // MyUtils.navigateAsFirstScreen(ctx, OtpScreen("update",tr('register_otp'),code:response.code.toString(),));
      }
    }else if(response.status == Apis.CODE_ACTIVE_USER &&response.data!=null){
      UserData user=response.data;
      setCurrentUserData(user);
      setIsLoading(false);
      // MyUtils.navigateReplaceCurrent(ctx, OtpScreen("register",tr('register_otp'),code:response.code.toString(),));
    }else if(response.status == Apis.CODE_SHOW_MESSAGE ){
      print("login error: ${response.msg}");
      setIsLoading(false);
      await Fluttertoast.showToast(msg: "${response.msg}");
    }
    notifyListeners();

  }

  changePassword(BuildContext ctx,String oldPassword,String newPassword,String confPassword) async {
    setIsLoading(true);
    MyResponse<dynamic> response =
    await updateProfileApi.changePassword( oldPassword, newPassword, confPassword);

    if (response.status == Apis.CODE_SUCCESS){
      setIsLoading(false);
      Constants.prefs!.clear();
      Constants.currentUser!=null;
      MyUtils.navigateAsFirstScreen(ctx, SplashScreen());

    }else if(response.status == Apis.CODE_SHOW_MESSAGE ){
      print("login error: ${response.msg}");
      setIsLoading(false);
      await Fluttertoast.showToast(msg: "${response.msg}");
    }
    notifyListeners();

  }
  resetPassword(BuildContext ctx,String newPassword,String confPassword,String code,String phone) async {
    setIsLoading(true);
    MyResponse<dynamic> response =
    await updateProfileApi.resetPassword(newPassword, confPassword,code,phone);
    if (response.status == Apis.CODE_SUCCESS){
      setIsLoading(false);
      logout(ctx);
      MyUtils.navigate(ctx, LoginScreen());

    }else if(response.status == Apis.CODE_SHOW_MESSAGE ){
      print("login error: ${response.msg}");
      setIsLoading(false);
      await Fluttertoast.showToast(msg: "${response.msg}");
    }
    notifyListeners();

  }
  deleteAccount(BuildContext ctx) async {
    setIsLoading(true);
    MyResponse<dynamic> response =
    await updateProfileApi.deleteAccount();
    if (response.status == Apis.CODE_SUCCESS){
      setIsLoading(false);
      Constants.prefs!.clear();
      Constants.currentUser=null;
      MyUtils.navigate(ctx, LoginScreen());

    }else if(response.status == Apis.CODE_SHOW_MESSAGE ){
      print("login error: ${response.msg}");
      setIsLoading(false);
      await Fluttertoast.showToast(msg: "${response.msg}");
    }
    notifyListeners();

  }
  logout(BuildContext ctx)async{
    setIsLoading(true);
    await loginApi.logout();
    await Constants.prefs!.setString(Constants.TOKEN_KEY!,'');
    await Constants.prefs!.setString(Constants.SAVED_USER_KEY!,"");
    Apis.TOKEN_VALUE="";
    Constants.currentUser=null;
    currentUser=null;
    setIsLoading(false);
    MyUtils.navigateAsFirstScreen(ctx, LoginScreen());
  }
  String _convertToJsonStringQuotes({required String raw}) {
    /// remove space
    String jsonString = raw.replaceAll(" ", "");
    /// add quotes to json string
    jsonString = jsonString.replaceAll('{', '{"');
    jsonString = jsonString.replaceAll(':', '":');
    jsonString = jsonString.replaceAll('": "//', '://');
    jsonString = jsonString.replaceAll('"https"', 'https');
    jsonString = jsonString.replaceAll('"http"', 'http');
    jsonString = jsonString.replaceAll(',', ',"');
    jsonString = jsonString.replaceAll('}', '}');
    /// remove quotes on object json string
    jsonString = jsonString.replaceAll('"{"', '{"');
    jsonString = jsonString.replaceAll('"}"', '}');
    /// remove quotes on array json string
    jsonString = jsonString.replaceAll('"[{', '[{');
    jsonString = jsonString.replaceAll('}]"', '}]');
    jsonString = jsonString.replaceAll('"[', '[');
    jsonString = jsonString.replaceAll(']"', ']');
    return jsonString;
  }

}