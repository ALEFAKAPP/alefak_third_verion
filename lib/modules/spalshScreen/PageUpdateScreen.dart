import 'package:alefakaltawinea_animals_app/shared/constance/fonts.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/baseDimentions.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/baseTextStyle.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/myColors.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/my_fonts.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class PageUpdateScreen extends StatelessWidget {
  const PageUpdateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Container(color: primaryColor),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Image.asset(
                    "assets/images/logo_color.png",
                    width: Get.width / 1.5,
                  ),
                ),
                Text(tr("title_update"),style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: C.BASE_BLUE,fontFamily:fontPrimary), ),
                SizedBox(height: 20),
                Center(child: Text(tr("description_update"),style: TextStyle(fontSize: 17,fontFamily: fontPrimary),textAlign: TextAlign.center,)),
                SizedBox(height: 20,),
                _button(tr("update_btn"), () async {
                  if(GetPlatform.isAndroid ){
                    final String url =  'https://play.google.com/store/apps/details?id=com.alefakeltawinea.alefakaltawinea_animals_app';
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      Fluttertoast.showToast(msg: tr("cant_opn_url"),backgroundColor: Colors.red,textColor: Colors.white,);
                    }

                  }else if(GetPlatform.isIOS){
                    final String url = 'https://apps.apple.com/uy/app/alefak-%D8%A3%D9%84%D9%8A%D9%81%D9%83-%D8%A7%D9%84%D8%AA%D8%B9%D8%A7%D9%88%D9%86%D9%8A%D8%A9/id1632037683';
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      Fluttertoast.showToast(msg: tr("cant_opn_url"),backgroundColor: Colors.red,textColor: Colors.white,);
                    }
                  }
                },
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _button(String title, Function ontClick) {
    return InkWell(onTap: ()async {
      ontClick();
    }, child: Container(
      padding: EdgeInsets.all(D.default_5),
      height: D.height(7.5),
      width: D.height(26),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(D.default_100),),
      ),
      child: Center(child: Container(
        padding: EdgeInsets.all(D.default_5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(D.default_100),),
          color: C.BASE_BLUE,
        ),
        child: Center(child: Text(title, style: S.h1Bold(fontSize:D.h2,color: Colors.white,font: MyFonts.VEXA),
          textAlign: TextAlign.center,),),

      ),),
    ));
  }

}
