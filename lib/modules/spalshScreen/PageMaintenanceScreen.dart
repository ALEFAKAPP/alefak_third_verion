import 'package:alefakaltawinea_animals_app/shared/constance/fonts.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/myColors.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/my_fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';

class PageMaintenanceScreen extends StatelessWidget {
  const PageMaintenanceScreen({Key? key}) : super(key: key);

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
                SizedBox(height: 50,),

                Text(tr("ناسف"),style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: C.BASE_BLUE,fontFamily: fontPrimary), ),
                SizedBox(height: 20),
                Text(tr("التطبيق_في_وضع_الصيانة"),style: TextStyle(fontSize: 20,fontFamily: fontPrimary)),
                SizedBox(height: 20,),
                // const SizedBox(height: 10,),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
