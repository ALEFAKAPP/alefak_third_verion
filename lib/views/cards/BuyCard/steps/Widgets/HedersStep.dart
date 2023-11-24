import 'package:alefakaltawinea_animals_app/core/view_model/BuyCards/BuyCardsViewModel.dart';
import 'package:alefakaltawinea_animals_app/shared/components/text.dart';
import 'package:alefakaltawinea_animals_app/shared/constance/colors.dart';
import 'package:alefakaltawinea_animals_app/shared/constance/fonts.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HeadersStep extends StatelessWidget {
  BuyCardViewModel _buyCardViewModel = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(() =>
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,// Center horizontall
      children: [
        Container(
          width: (Get.width / 3.3).w,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Container(
                    width: 30.w,
                    height: 30.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _buyCardViewModel.step.value == 1 ? primaryColor : kTextLightColor,
                      border: Border.all(
                        color: _buyCardViewModel.step.value == 1 ? Color(0xff92FFFFFF) : kTextLightColor2,
                        width: 5.0,
                      ),
                    ),
                    child: Center(
                      child: Text('1', style: TextStyle(color: whiteColor, fontSize: textSizeMedium)),
                    ),
                  ),
                  text(tr('اتمام_الدفع'), fontSize: textSizeSSmall.sp,textColor: _buyCardViewModel.step.value == 1 ? primaryColor : kTextLightColor),
                ],
              ),

            ],
          ),
        ),
        Container(
          width: (Get.width / 3.3).w,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Container(
                    width: 30.w,
                    height: 30.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _buyCardViewModel.step.value == 2 ? primaryColor : kTextLightColor,
                      border: Border.all(
                        color: _buyCardViewModel.step.value == 2 ? Color(0xff92FFFFFF) : kTextLightColor2,
                        width: 5.0,
                      ),
                    ),
                    child: Center(
                      child: Text('2', style: TextStyle(color: whiteColor, fontSize: textSizeMedium)),
                    ),
                  ),
                  text(tr('بيانات_هوية_اليفك'), fontSize: textSizeSSmall.sp,textColor: _buyCardViewModel.step.value == 2 ? primaryColor : kTextLightColor),
                ],
              ),

            ],
          ),
        ),
        Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Container(
                    width: 30.w,
                    height: 30.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _buyCardViewModel.step.value == 3 ? primaryColor : kTextLightColor,
                      border: Border.all(
                        color: _buyCardViewModel.step.value == 3 ? Color(0xff92FFFFFF) : kTextLightColor2 ,
                        width: 5.0,
                      ),
                    ),
                    child: Center(
                      child: Text('3', style: TextStyle(color: whiteColor, fontSize: textSizeMedium)),
                    ),
                  ),
                  text(tr('مبروك_تم_الاشتراك'), fontSize: textSizeSSmall.sp,textColor: _buyCardViewModel.step.value == 3 ? primaryColor : kTextLightColor),
                ],
              ),

            ],
          ),
        ),
        
      ],
    ));
  }
}
