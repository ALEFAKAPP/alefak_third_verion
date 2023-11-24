import 'package:alefakaltawinea_animals_app/core/view_model/BuyCards/BuyCardsViewModel.dart';
import 'package:alefakaltawinea_animals_app/shared/components/text.dart';
import 'package:alefakaltawinea_animals_app/shared/constance/colors.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CounterCard extends StatelessWidget {
  BuyCardViewModel _buyCardViewModel = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() =>  Center(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: ()=>_buyCardViewModel.CounterCard(type :'added' ),
            child: Container(
              child: Center(child: text('+',fontSize: 20.0),),
              width: 30.w,
              height: 30.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topRight:Radius.circular(10),bottomRight:Radius.circular(10)),
                color: Colors.white,
                border: Border.all(
                  color: _buyCardViewModel.typeCard.value == 2 ? primaryColor : kTextLightColor2,
                  width: 1.0,
                ),
              ),
            ),
          ),
          Container(
            child: Center(child: text(_buyCardViewModel.numCard.value.toString(),fontSize: 15.0),),
            width: 30.w,
            height: 30.w,
            color: primaryColor,
          ),
          InkWell(
            onTap: ()=>_buyCardViewModel.CounterCard(type :'minus' ),
            child: Container(
              child: Center(child: text('-',fontSize: 20.0),),
              width: 30.w,
              height: 30.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft:Radius.circular(10),bottomLeft:Radius.circular(10)),
                color: Colors.white,
                border: Border.all(
                  color: _buyCardViewModel.typeCard.value == 2 ? primaryColor : kTextLightColor2,
                  width: 1.0,
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
