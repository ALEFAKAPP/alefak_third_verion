import 'package:alefakaltawinea_animals_app/core/view_model/BuyCards/BuyCardsViewModel.dart';
import 'package:alefakaltawinea_animals_app/shared/components/text.dart';
import 'package:alefakaltawinea_animals_app/shared/constance/colors.dart';
import 'package:alefakaltawinea_animals_app/shared/constance/fonts.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TypeCard extends StatelessWidget {
  BuyCardViewModel _buyCardViewModel = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
      children: [
        InkWell(
          onTap: ()=>_buyCardViewModel.changeTypeCard(type :1 ),
          child: Container(
            width: Get.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.white,
              border: Border.all(
                color: _buyCardViewModel.typeCard.value == 1 ? primaryColor : kTextLightColor2,
                width: 1.0,
              ),
            ),
            child: Container(
              width: Get.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: _buyCardViewModel.typeCard.value == 1 ? primaryColor : whiteColor,
              ),
              child: Obx(() => Padding(
                padding: const EdgeInsets.only(top: 5.0,left: 10,bottom: 5.0,right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    text(tr('Multiple')),
                    _buyCardViewModel.typeCard.value == 1
                        ?Icon(Icons.check_circle,color: whiteColor)
                        :Icon(Icons.circle_outlined,color: fifthColor),
                  ],
                ),
              )),
            ),
          ),
        ),
        SizedBox(height: 15,),
        InkWell(
          onTap: ()=>_buyCardViewModel.changeTypeCard(type :2 ),
          child: Container(
            width: Get.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.white,
              border: Border.all(
                color: _buyCardViewModel.typeCard.value == 2 ? primaryColor : kTextLightColor2,
                width: 1.0,
              ),
            ),
            child: Container(
              width: Get.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: _buyCardViewModel.typeCard.value == 2 ? primaryColor : whiteColor,
              ),
              child: Obx(() => Padding(
                padding: const EdgeInsets.only(top: 5.0,left: 10,bottom: 5.0,right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    text(tr('Individual')),
                    _buyCardViewModel.typeCard.value == 2
                        ?Icon(Icons.check_circle,color: whiteColor)
                        :Icon(Icons.circle_outlined,color: fifthColor),
                  ],
                ),
              )),
            ),
          ),
        ),
      ],
    ));
  }
}
