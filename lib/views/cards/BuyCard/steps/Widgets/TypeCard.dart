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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: Get.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topRight:Radius.circular(10),topLeft:Radius.circular(10)),
                    color: _buyCardViewModel.typeCard.value == 1 ? primaryColor : whiteColor,
                  ),
                  child: Obx(() => Padding(
                    padding: const EdgeInsets.only(top: 5.0,left: 10,bottom: 0,right: 10),
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
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                  child: Divider(color: fifthColor, height: 0.5),
                ),
                text('${tr('desc_multiple')} ${_buyCardViewModel.priceAdditionalCard.value} ${tr('curncy')}',fontSize: textSizeSmall.sp,maxLine: 2,isBold: true),

              ],
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: Get.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topRight:Radius.circular(10),topLeft:Radius.circular(10)),
                    color: _buyCardViewModel.typeCard.value == 2 ? primaryColor : whiteColor,
                  ),
                  child: Obx(() => Padding(
                    padding: const EdgeInsets.only(top: 5.0,left: 10,bottom: 0,right: 10),
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
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                  child: Divider(color: fifthColor, height: 0.5),
                ),
                text(tr('desc_individual'),fontSize: textSizeSmall.sp,maxLine: 2,isBold: true),

              ],
            ),
          ),
        ),
      ],
    ));
  }
}
