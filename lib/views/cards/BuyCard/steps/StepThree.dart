import 'package:alefakaltawinea_animals_app/core/view_model/BuyCards/BuyCardsViewModel.dart';
import 'package:alefakaltawinea_animals_app/shared/components/Scaffold.dart';
import 'package:alefakaltawinea_animals_app/shared/components/buttons.dart';
import 'package:alefakaltawinea_animals_app/shared/components/text.dart';
import 'package:alefakaltawinea_animals_app/shared/constance/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StepThree extends StatelessWidget {
  BuyCardViewModel _buyCardViewModel = Get.find();

  @override
  Widget build(BuildContext context) {
    return ScaffoldMain(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              'assets/images/79952-successful.gif',
              width: Get.width,
            ),
            largText(text: tr('تهانينا')),
            text(tr('تم_اضافة_بطاقاتك_بنجاح'), isCentered: true,textColor: fifthColor,maxLine: 3,fontSize: 14.0),
            SizedBox(
              height: 20,
            ),

            defaultButton(
              text: tr('الانتقال_الى_بطاقاتي'),
              width: Get.width/2,
              color: primaryColor,
              function: () {
                _buyCardViewModel.goToMyCards();
              },
            ),
          ],
        ),
      ),
    );
  }
}
