
import 'package:alefakaltawinea_animals_app/modules/login/data/user_data.dart';
import 'package:alefakaltawinea_animals_app/modules/login/provider/user_provider_model.dart';
import 'package:alefakaltawinea_animals_app/modules/spalshScreen/spalshScreen.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/constants.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/providers.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../modules/categories_screen/mainCategoriesScreen.dart';
import '../../modules/settings/change_language_dialog_widget.dart';
import '../../modules/settings/regions_dialog_widget.dart';
import '../../modules/spalshScreen/data/regions_model.dart';
import 'baseDimentions.dart';
import 'baseTextStyle.dart';
import 'myColors.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter_share/flutter_share.dart';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class MyUtils{

  /// ........... navigation utils................................
  static void navigate(BuildContext context,Widget screen){
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => screen)).then((value) {
      //Constants.utilsProviderModel!.setCurrentLocal(context, Constants.utilsProviderModel!.currentLocal);
    });
  }
  static void navigateAsFirstScreen(BuildContext context,Widget screen){
    Navigator.of(context).popUntil((route) => route.isFirst);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => screen)).then((value) {
      //Constants.utilsProviderModel!.setCurrentLocal(context, Constants.utilsProviderModel!.currentLocal);
    });
  }

  static void navigateReplaceCurrent(BuildContext context,Widget screen){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => screen)).then((value) {
      //Constants.utilsProviderModel!.setCurrentLocal(context, Constants.utilsProviderModel!.currentLocal);
    });
  }
  ///========================intor utils===================================================
  static void printLongLine(String text) {
    final pattern = new RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => print(match.group(0)));
  }

  static languageDialog(BuildContext context,Widget body,UtilsProviderModel? utilsProviderModel,
  {bool isDismissible = true,}) {
    // flutter defined function
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {// return object of type Dialog
        return WillPopScope(
            onWillPop: isDismissible ? _onWillPop : _onWillNotPop,
            child: AlertDialog(
              contentPadding: EdgeInsets.all(0),
              content:ChangeLanguageDialogWidget(),
            ));
      },
    );
  }
  static regionsDialog(BuildContext context) {
    basePopup(context, body: RegionsDialogWidget(onItemSelect: (Get_states ) {  },)) ;
  }
  static Future<bool> _onWillPop() async {
    return  true;
  }

  static Future<bool> _onWillNotPop() async {
    return  false;
  }
  static Future<void> share() async {
    await FlutterShare.share(
        title: 'تطبيق أليفك ',
        linkUrl: Constants.APP_LINK);
  }
  static openwhatsapp(BuildContext context) async{
    var whatsapp ="${Constants.APP_INFO!.whatsapp}";
    var whatsappURl_android = "whatsapp://send?phone="+whatsapp+"&text=";
    var whatappURL_ios ="https://wa.me/$whatsapp?text=${Uri.parse("")}";
    if(Platform.isIOS){
      // for iOS phone only
      if( await canLaunch(whatappURL_ios)){
        await launch(whatappURL_ios, forceSafariVC: false);
      }else{
        await Fluttertoast.showToast(msg: "الرجاء تنزيل whatsapp لتتمكن من التواصل معنا");
      }
    }else{
      // android , web
      if( await canLaunch(whatsappURl_android)){
        await launch(whatsappURl_android);
      }else{
        await Fluttertoast.showToast(msg: "الرجاء تنزيل whatsapp لتتمكن من التواصل معنا");

      }
    }
  }
  static void basePopup(BuildContext context,{required Widget body, EdgeInsetsGeometry? padding}) {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false, // set to false
        pageBuilder: (_, __, ___) {
          return
            Scaffold(
                backgroundColor: Colors.white.withOpacity(0.5),
              body:SafeArea(child: Container(
              color: Colors.black.withOpacity(0.5),
              padding: padding ?? EdgeInsets.all(D.default_20),
              child: Center(child:Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  body
                ],)),)));
        },
      ),
    );
  }
  static String replaceArabicNumber(String input) {
    const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const arabic = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];

    for (int i = 0; i < english.length; i++) {
      input = input.replaceAll(arabic[i], english[i]);
    }
    print("$input");
    return input;
  }

  static getCities (){
     List<Map<String, dynamic>> cities =
    [
      {"id":"1","name":"الرياض","name_en":"Riyadh","code":null,"state":"1","district_id":"1","created_at":"2021-10-09 16:52:59","updated_at":"2021-10-09 16:52:59","deleted_at":null},
      {"id":"2","name":"المجمعة","name_en":"Al Majma'ah","code":null,"state":"1","district_id":"1","created_at":"2021-10-09 16:52:59","updated_at":"2021-10-09 16:52:59","deleted_at":null},
      {"id":"3","name":"حرمة","name_en":"Harmah","code":null,"state":"1","district_id":"1","created_at":"2021-10-09 16:52:59","updated_at":"2021-10-09 16:52:59","deleted_at":null},
      {"id":"4","name":"تمير","name_en":"Tumair","code":null,"state":"1","district_id":"1","created_at":"2021-10-09 16:52:59","updated_at":"2021-10-09 16:52:59","deleted_at":null},
      {"id":"5","name":"الزلفي","name_en":"Az Zulfi","code":null,"state":"1","district_id":"1","created_at":"2021-10-09 16:52:59","updated_at":"2021-10-09 16:52:59","deleted_at":null},
      {"id":"6","name":"الغاط","name_en":"Al Ghat","code":null,"state":"1","district_id":"1","created_at":"2021-10-09 16:52:59","updated_at":"2021-10-09 16:52:59","deleted_at":null},
      {"id":"7","name":"عفيف","name_en":"Afif","code":null,"state":"1","district_id":"1","created_at":"2021-10-09 16:52:59","updated_at":"2021-10-09 16:52:59","deleted_at":null},
      {"id":"8","name":"ثادق","name_en":"Thadiq","code":null,"state":"1","district_id":"1","created_at":"2021-10-09 16:52:59","updated_at":"2021-10-09 16:52:59","deleted_at":null},
      {"id":"9","name":"شقراء","name_en":"Shaqra'","code":null,"state":"1","district_id":"1","created_at":"2021-10-09 16:52:59","updated_at":"2021-10-09 16:52:59","deleted_at":null},
      {"id":"10","name":"الدوادمي","name_en":"Ad Duwadimi","code":null,"state":"1","district_id":"1","created_at":"2021-10-09 16:52:59","updated_at":"2021-10-09 16:52:59","deleted_at":null},
      {"id":"11","name":"حريملاء","name_en":"Huraymila","code":null,"state":"1","district_id":"1","created_at":"2021-10-09 16:52:59","updated_at":"2021-10-09 16:52:59","deleted_at":null},
      {"id":"12","name":"الدرعية","name_en":"Ad Dir'iyah","code":null,"state":"1","district_id":"1","created_at":"2021-10-09 16:52:59","updated_at":"2021-10-09 16:52:59","deleted_at":null},
      {"id":"13","name":"ضرما","name_en":"Duruma","code":null,"state":"1","district_id":"1","created_at":"2021-10-09 16:52:59","updated_at":"2021-10-09 16:52:59","deleted_at":null},
      {"id":"14","name":"القويعية","name_en":"Al Quway'iyah","code":null,"state":"1","district_id":"1","created_at":"2021-10-09 16:52:59","updated_at":"2021-10-09 16:52:59","deleted_at":null},
      {"id":"15","name":"المزاحمية","name_en":"Al Muzahimiyah","code":null,"state":"1","district_id":"1","created_at":"2021-10-09 16:52:59","updated_at":"2021-10-09 16:52:59","deleted_at":null},
      {"id":"16","name":"الخرج","name_en":"Al Kharj","code":null,"state":"1","district_id":"1","created_at":"2021-10-09 16:52:59","updated_at":"2021-10-09 16:52:59","deleted_at":null},
      {"id":"17","name":"الدلم","name_en":"Ad Dilam","code":null,"state":"1","district_id":"1","created_at":"2021-10-09 16:52:59","updated_at":"2021-10-09 16:52:59","deleted_at":null},
      {"id":"18","name":"السليل","name_en":"As Sulayyil","code":null,"state":"1","district_id":"1","created_at":"2021-10-09 16:52:59","updated_at":"2021-10-09 16:52:59","deleted_at":null},
      {"id":"19","name":"الحريق","name_en":"Al Hariq","code":null,"state":"1","district_id":"1","created_at":"2021-10-09 16:52:59","updated_at":"2021-10-09 16:52:59","deleted_at":null},
      {"id":"20","name":"حوطة بني تميم","name_en":"Hawtat Bani Tamim","code":null,"state":"1","district_id":"1","created_at":"2021-10-09 16:52:59","updated_at":"2021-10-09 16:52:59","deleted_at":null},
      {"id":"21","name":"ليلى","name_en":"Layla","code":null,"state":"1","district_id":"1","created_at":"2021-10-09 16:52:59","updated_at":"2021-10-09 16:52:59","deleted_at":null},
      {"id":"22","name":"الطائف","name_en":"At Taif","code":null,"state":"1","district_id":"2","created_at":"2021-10-09 16:52:59","updated_at":"2021-10-09 16:52:59","deleted_at":null},
      {"id":"23","name":"مكة المكرمة","name_en":"Makkah Al Mukarramah","code":null,"state":"1","district_id":"2","created_at":"2021-10-09 16:52:59","updated_at":"2021-10-09 16:52:59","deleted_at":null},
      {"id":"24","name":"جدة","name_en":"Jeddah","code":null,"state":"1","district_id":"2","created_at":"2021-10-09 16:52:59","updated_at":"2021-10-09 16:52:59","deleted_at":null},
      {"id":"25","name":"رابغ","name_en":"Rabigh","code":null,"state":"1","district_id":"2","created_at":"2021-10-09 16:52:59","updated_at":"2021-10-09 16:52:59","deleted_at":null},
      {"id":"26","name":"خليص","name_en":"Khulays","code":null,"state":"1","district_id":"2","created_at":"2021-10-09 16:52:59","updated_at":"2021-10-09 16:52:59","deleted_at":null},
      {"id":"27","name":"الخرمة","name_en":"Al Khurmah","code":null,"state":"1","district_id":"2","created_at":"2021-10-09 16:52:59","updated_at":"2021-10-09 16:52:59","deleted_at":null},
      {"id":"28","name":"الجموم","name_en":"Al Jumum","code":null,"state":"1","district_id":"2","created_at":"2021-10-09 16:52:59","updated_at":"2021-10-09 16:52:59","deleted_at":null},
      {"id":"29","name":"القنفذة","name_en":"Al Qunfidhah","code":null,"state":"1","district_id":"2","created_at":"2021-10-09 16:52:59","updated_at":"2021-10-09 16:52:59","deleted_at":null},
      {"id":"30","name":"ثول","name_en":"Thuwal","code":null,"state":"1","district_id":"2","created_at":"2021-10-09 16:52:59","updated_at":"2021-10-09 16:52:59","deleted_at":null},
      {"id":"31","name":"تربه","name_en":"Turbah","code":null,"state":"1","district_id":"2","created_at":"2021-10-09 16:52:59","updated_at":"2021-10-09 16:52:59","deleted_at":null},
      {"id":"32","name":"مدينة الملك عبدالله الاقتصادية","name_en":"King Abdullah Economic City","code":null,"state":"1","district_id":"2","created_at":"2021-10-09 16:52:59","updated_at":"2021-10-09 16:52:59","deleted_at":null},
      {"id":"33","name":"المدينة المنورة","name_en":"Al Madinah Al Munawwarah","code":null,"state":"1","district_id":"3","created_at":"2021-10-09 16:52:59","updated_at":"2021-10-09 16:52:59","deleted_at":null},
      {"id":"34","name":"العلا","name_en":"Al Ula","code":null,"state":"1","district_id":"3","created_at":"2021-10-09 16:52:59","updated_at":"2021-10-09 16:52:59","deleted_at":null},
      {"id":"35","name":"خيبر","name_en":"Khaybar","code":null,"state":"1","district_id":"3","created_at":"2021-10-09 16:52:59","updated_at":"2021-10-09 16:52:59","deleted_at":null},
      {"id":"36","name":"ينبع","name_en":"Yanbu","code":null,"state":"1","district_id":"3","created_at":"2021-10-09 16:52:59","updated_at":"2021-10-09 16:52:59","deleted_at":null},
      {"id":"37","name":"بدر","name_en":"Badr","code":null,"state":"1","district_id":"3","created_at":"2021-10-09 16:52:59","updated_at":"2021-10-09 16:52:59","deleted_at":null},
      {"id":"38","name":"ينبع الصناعية","name_en":"Yanbu Al Sinaiyah","code":null,"state":"1","district_id":"3","created_at":"2021-10-09 16:52:59","updated_at":"2021-10-09 16:52:59","deleted_at":null},
      {"id":"39","name":"بريدة","name_en":"Buraydah","code":null,"state":"1","district_id":"4","created_at":"2021-10-09 16:52:59","updated_at":"2021-10-09 16:52:59","deleted_at":null},
      {"id":"40","name":"عنيزة","name_en":"Unayzah","code":null,"state":"1","district_id":"4","created_at":"2021-10-09 16:52:59","updated_at":"2021-10-09 16:52:59","deleted_at":null},
      {"id":"41","name":"عيون الجواء","name_en":"Uyun Al Jawa'","code":null,"state":"1","district_id":"4","created_at":"2021-10-09 16:52:59","updated_at":"2021-10-09 16:52:59","deleted_at":null},
      {"id":"42","name":"الرس","name_en":"Ar Rass","code":null,"state":"1","district_id":"4","created_at":"2021-10-09 16:52:59","updated_at":"2021-10-09 16:52:59","deleted_at":null},
      {"id":"43","name":"المذنب","name_en":"Al Midhnab","code":null,"state":"1","district_id":"4","created_at":"2021-10-09 16:52:59","updated_at":"2021-10-09 16:52:59","deleted_at":null},
      {"id":"44","name":"رياض الخبراء","name_en":"Riyad Al Khabra","code":null,"state":"1","district_id":"4","created_at":"2021-10-09 16:52:59","updated_at":"2021-10-09 16:52:59","deleted_at":null},
      {"id":"45","name":"البدائع","name_en":"Al Badai'","code":null,"state":"1","district_id":"4","created_at":"2021-10-09 16:52:59","updated_at":"2021-10-09 16:52:59","deleted_at":null},
      {"id":"46","name":"الهلالية","name_en":"Al Hilaliyah","code":null,"state":"1","district_id":"4","created_at":"2021-10-09 16:52:59","updated_at":"2021-10-09 16:52:59","deleted_at":null},
      {"id":"47","name":"البكيرية","name_en":"Al Bukayriyah","code":null,"state":"1","district_id":"4","created_at":"2021-10-09 16:52:59","updated_at":"2021-10-09 16:52:59","deleted_at":null},
      {"id":"48","name":"الشماسية","name_en":"Ash Shimasiyah","code":null,"state":"1","district_id":"4","created_at":"2021-10-09 16:52:59","updated_at":"2021-10-09 16:52:59","deleted_at":null},
      {"id":"49","name":"النبهانية","name_en":"An Nabhaniyah","code":null,"state":"1","district_id":"4","created_at":"2021-10-09 16:52:59","updated_at":"2021-10-09 16:52:59","deleted_at":null},
      {"id":"50","name":"المرموثة","name_en":"Al Marmuthah","code":null,"state":"1","district_id":"4","created_at":"2021-10-09 16:52:59","updated_at":"2021-10-09 16:52:59","deleted_at":null},
      {"id":"51","name":"الهفوف","name_en":"Al Hufuf","code":null,"state":"1","district_id":"5","created_at":"2021-10-09 16:52:59","updated_at":"2021-10-09 16:52:59","deleted_at":null},
      {"id":"52","name":"الدمام","name_en":"Dammam","code":null,"state":"1","district_id":"5","created_at":"2021-10-09 16:52:59","updated_at":"2021-10-09 16:52:59","deleted_at":null},
      {"id":"53","name":"الخبر","name_en":"Al Khobar","code":null,"state":"1","district_id":"5","created_at":"2021-10-09 16:52:59","updated_at":"2021-10-09 16:52:59","deleted_at":null},
      {"id":"54","name":"حفر الباطن","name_en":"Hafar Al Batin","code":null,"state":"1","district_id":"5","created_at":"2021-10-09 16:52:59","updated_at":"2021-10-09 16:52:59","deleted_at":null},
      {"id":"55","name":"القطيف","name_en":"Al Qatif","code":null,"state":"1","district_id":"5","created_at":"2021-10-09 16:52:59","updated_at":"2021-10-09 16:52:59","deleted_at":null},
      {"id":"56","name":"قرية العليا","name_en":"Qaryat Al 'ulya","code":null,"state":"1","district_id":"5","created_at":"2021-10-09 16:52:59","updated_at":"2021-10-09 16:52:59","deleted_at":null},
      {"id":"57","name":"الجبيل","name_en":"Al Jubail","code":null,"state":"1","district_id":"5","created_at":"2021-10-09 16:52:59","updated_at":"2021-10-09 16:52:59","deleted_at":null},
      {"id":"58","name":"النعيرية","name_en":"An Nu'ayriyah","code":null,"state":"1","district_id":"5","created_at":"2021-10-09 16:52:59","updated_at":"2021-10-09 16:52:59","deleted_at":null},
      {"id":"59","name":"الظهران","name_en":"Dhahran","code":null,"state":"1","district_id":"5","created_at":"2021-10-09 16:52:59","updated_at":"2021-10-09 16:52:59","deleted_at":null},
      {"id":"60","name":"بقيق","name_en":"Buqayq","code":null,"state":"1","district_id":"5","created_at":"2021-10-09 16:52:59","updated_at":"2021-10-09 16:52:59","deleted_at":null},
      {"id":"61","name":"سيهات","name_en":"Sayhat","code":null,"state":"1","district_id":"5","created_at":"2021-10-09 16:52:59","updated_at":"2021-10-09 16:52:59","deleted_at":null},
      {"id":"62","name":"تاروت","name_en":"Tarut","code":null,"state":"1","district_id":"5","created_at":"2021-10-09 16:52:59","updated_at":"2021-10-09 16:52:59","deleted_at":null},
      {"id":"63","name":"صفوى","name_en":"Safwa","code":null,"state":"1","district_id":"5","created_at":"2021-10-09 16:52:59","updated_at":"2021-10-09 16:52:59","deleted_at":null},
      {"id":"64","name":"عنك","name_en":"'inak","code":null,"state":"1","district_id":"5","created_at":"2021-10-09 16:52:59","updated_at":"2021-10-09 16:52:59","deleted_at":null},
      {"id":"65","name":"دارين","name_en":"Darin","code":null,"state":"1","district_id":"5","created_at":"2021-10-09 16:52:59","updated_at":"2021-10-09 16:52:59","deleted_at":null},
      {"id":"66","name":"الخفجي","name_en":"Al Khafji","code":null,"state":"1","district_id":"5","created_at":"2021-10-09 16:52:59","updated_at":"2021-10-09 16:52:59","deleted_at":null},
      {"id":"67","name":"راس تنورة","name_en":"Ras Tannurah","code":null,"state":"1","district_id":"5","created_at":"2021-10-09 16:52:59","updated_at":"2021-10-09 16:52:59","deleted_at":null},
      {"id":"68","name":"المبرز","name_en":"Al Mubarraz","code":null,"state":"1","district_id":"5","created_at":"2021-10-09 16:52:59","updated_at":"2021-10-09 16:52:59","deleted_at":null},
      {"id":"69","name":"الاحساء","name_en":"Al Ahsa","code":null,"state":"1","district_id":"5","created_at":"2021-10-09 16:52:59","updated_at":"2021-10-09 16:52:59","deleted_at":null},
      {"id":"70","name":"ابها","name_en":"Abha","code":null,"state":"1","district_id":"6","created_at":"2021-10-09 16:52:59","updated_at":"2021-10-09 16:52:59","deleted_at":null},
      {"id":"71","name":"خميس مشيط","name_en":"Khamis Mushayt","code":null,"state":"1","district_id":"6","created_at":"2021-10-09 16:52:59","updated_at":"2021-10-09 16:52:59","deleted_at":null},
      {"id":"72","name":"احد رفيده","name_en":"Ahad Rifaydah","code":null,"state":"1","district_id":"6","created_at":"2021-10-09 16:52:59","updated_at":"2021-10-09 16:52:59","deleted_at":null},
      {"id":"73","name":"طريب","name_en":"Tarib","code":null,"state":"1","district_id":"6","created_at":"2021-10-09 16:52:59","updated_at":"2021-10-09 16:52:59","deleted_at":null},
      {"id":"74","name":"المجاردة","name_en":"Al Majardah","code":null,"state":"1","district_id":"6","created_at":"2021-10-09 16:52:59","updated_at":"2021-10-09 16:52:59","deleted_at":null},
      {"id":"75","name":"تثليث","name_en":"Tathlith","code":null,"state":"1","district_id":"6","created_at":"2021-10-09 16:52:59","updated_at":"2021-10-09 16:52:59","deleted_at":null},
      {"id":"76","name":"بيشة","name_en":"Bishah","code":null,"state":"1","district_id":"6","created_at":"2021-10-09 16:52:59","updated_at":"2021-10-09 16:52:59","deleted_at":null},
      {"id":"77","name":"سبت العلاية","name_en":"Sabt Al 'alayah","code":null,"state":"1","district_id":"6","created_at":"2021-10-09 16:52:59","updated_at":"2021-10-09 16:52:59","deleted_at":null},
      {"id":"78","name":"محايل","name_en":"Muhayil","code":null,"state":"1","district_id":"6","created_at":"2021-10-09 16:52:59","updated_at":"2021-10-09 16:52:59","deleted_at":null},
      {"id":"79","name":"النماص","name_en":"An Namas (Tanumah)","code":null,"state":"1","district_id":"6","created_at":"2021-10-09 16:52:59","updated_at":"2021-10-09 16:52:59","deleted_at":null},
      {"id":"80","name":"بللسمر","name_en":"Billasmar","code":null,"state":"1","district_id":"6","created_at":"2021-10-09 16:52:59","updated_at":"2021-10-09 16:52:59","deleted_at":null},
      {"id":"81","name":"سراة عبيدة","name_en":"Sarat Abidah","code":null,"state":"1","district_id":"6","created_at":"2021-10-09 16:52:59","updated_at":"2021-10-09 16:52:59","deleted_at":null},
      {"id":"82","name":"تندحة","name_en":"Tendaha","code":null,"state":"1","district_id":"6","created_at":"2021-10-09 16:52:59","updated_at":"2021-10-09 16:52:59","deleted_at":null},
      {"id":"83","name":"تبوك","name_en":"Tabuk","code":null,"state":"1","district_id":"7","created_at":"2021-10-09 16:52:59","updated_at":"2021-10-09 16:52:59","deleted_at":null},
      {"id":"84","name":"حقل","name_en":"Haql","code":null,"state":"1","district_id":"7","created_at":"2021-10-09 16:52:59","updated_at":"2021-10-09 16:52:59","deleted_at":null},
      {"id":"85","name":"تيماء","name_en":"Tayma'","code":null,"state":"1","district_id":"7","created_at":"2021-10-09 16:52:59","updated_at":"2021-10-09 16:52:59","deleted_at":null},
      {"id":"86","name":"الوجه","name_en":"Al Wajh","code":null,"state":"1","district_id":"7","created_at":"2021-10-09 16:52:59","updated_at":"2021-10-09 16:52:59","deleted_at":null},
      {"id":"87","name":"املج","name_en":"Umluj","code":null,"state":"1","district_id":"7","created_at":"2021-10-09 16:52:59","updated_at":"2021-10-09 16:52:59","deleted_at":null},
      {"id":"88","name":"ضبا","name_en":"Duba","code":null,"state":"1","district_id":"7","created_at":"2021-10-09 16:52:59","updated_at":"2021-10-09 16:52:59","deleted_at":null},
      {"id":"89","name":"حائل","name_en":"Hail","code":null,"state":"1","district_id":"8","created_at":"2021-10-09 16:52:59","updated_at":"2021-10-09 16:52:59","deleted_at":null},
      {"id":"90","name":"الشنان","name_en":"Ash Shinan","code":null,"state":"1","district_id":"8","created_at":"2021-10-09 16:52:59","updated_at":"2021-10-09 16:52:59","deleted_at":null},
      {"id":"91","name":"طريف","name_en":"Turaif","code":null,"state":"1","district_id":"9","created_at":"2021-10-09 16:52:59","updated_at":"2021-10-09 16:52:59","deleted_at":null},
      {"id":"92","name":"عرعر","name_en":"Ar'ar","code":null,"state":"1","district_id":"9","created_at":"2021-10-09 16:52:59","updated_at":"2021-10-09 16:52:59","deleted_at":null},
      {"id":"93","name":"رفحاء","name_en":"Rafha'","code":null,"state":"1","district_id":"9","created_at":"2021-10-09 16:52:59","updated_at":"2021-10-09 16:52:59","deleted_at":null},
      {"id":"94","name":"جازان","name_en":"Jazan","code":null,"state":"1","district_id":"10","created_at":"2021-10-09 16:52:59","updated_at":"2021-10-09 16:52:59","deleted_at":null},
      {"id":"95","name":"صبيا","name_en":"Sabya","code":null,"state":"1","district_id":"10","created_at":"2021-10-09 16:52:59","updated_at":"2021-10-09 16:52:59","deleted_at":null},
      {"id":"96","name":"ابو عريش","name_en":"Abu Arish","code":null,"state":"1","district_id":"10","created_at":"2021-10-09 16:52:59","updated_at":"2021-10-09 16:52:59","deleted_at":null},
      {"id":"97","name":"صامطة","name_en":"Samtah","code":null,"state":"1","district_id":"10","created_at":"2021-10-09 16:52:59","updated_at":"2021-10-09 16:52:59","deleted_at":null},
      {"id":"98","name":"العارضة","name_en":"Al 'aridah","code":null,"state":"1","district_id":"10","created_at":"2021-10-09 16:52:59","updated_at":"2021-10-09 16:52:59","deleted_at":null},
      {"id":"99","name":"احد المسارحة","name_en":"Ahad Al Musarihah","code":null,"state":"1","district_id":"10","created_at":"2021-10-09 16:52:59","updated_at":"2021-10-09 16:52:59","deleted_at":null},
      {"id":"100","name":"يدمة","name_en":"Yadamah","code":null,"state":"1","district_id":"11","created_at":"2021-10-09 16:52:59","updated_at":"2021-10-09 16:52:59","deleted_at":null},
      {"id":"101","name":"شرورة","name_en":"Sharurah","code":null,"state":"1","district_id":"11","created_at":"2021-10-09 16:52:59","updated_at":"2021-10-09 16:52:59","deleted_at":null},
      {"id":"102","name":"نجران","name_en":"Najran","code":null,"state":"1","district_id":"11","created_at":"2021-10-09 16:52:59","updated_at":"2021-10-09 16:52:59","deleted_at":null},
      {"id":"103","name":"الباحة","name_en":"Al Baha","code":null,"state":"1","district_id":"12","created_at":"2021-10-09 16:52:59","updated_at":"2021-10-09 16:52:59","deleted_at":null},
      {"id":"104","name":"القريات","name_en":"Al Qurayyat","code":null,"state":"1","district_id":"13","created_at":"2021-10-09 16:52:59","updated_at":"2021-10-09 16:52:59","deleted_at":null},
      {"id":"105","name":"صوير","name_en":"Suwayr","code":null,"state":"1","district_id":"13","created_at":"2021-10-09 16:52:59","updated_at":"2021-10-09 16:52:59","deleted_at":null},
      {"id":"106","name":"سكاكا","name_en":"Sakaka","code":null,"state":"1","district_id":"13","created_at":"2021-10-09 16:52:59","updated_at":"2021-10-09 16:52:59","deleted_at":null},
      {"id":"107","name":"دومة الجندل","name_en":"Dawmat Al Jandal","code":null,"state":"1","district_id":"13","created_at":"2021-10-09 16:52:59","updated_at":"2021-10-09 16:52:59","deleted_at":null},
      {"id":"108","name":"الأضارع","name_en":"Al Adari'","code":null,"state":"1","district_id":"13","created_at":"2021-10-09 16:52:59","updated_at":"2021-10-09 16:52:59","deleted_at":null}
    ];

     return cities;
  }

}

