import 'package:alefakaltawinea_animals_app/core/view_model/BuyCards/BuyCardsViewModel.dart';
import 'package:alefakaltawinea_animals_app/shared/components/input_forms.dart';
import 'package:alefakaltawinea_animals_app/shared/components/text.dart';
import 'package:alefakaltawinea_animals_app/shared/constance/colors.dart';
import 'package:alefakaltawinea_animals_app/shared/constance/fonts.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CouponSection extends StatelessWidget {
  BuyCardViewModel _buyCardViewModel = Get.find();

  @override
  Widget build(BuildContext context) {
    return Stack(
      // fit: StackFit.expand,
      children: [
        Container(
          child :formField(
            context,
            tr('كود_الخصم'),
            filColor: Colors.white,
            controller: _buyCardViewModel.couponController,
            keyboardType: TextInputType.text,
            // onSaved: _authViewModel.sendOtp
          ),
        ),
        Positioned(
          left: 0, // Adjust the position of the icon as needed
          top: 0, // Adjust the position of the icon as needed
          child: InkWell(
            onTap: (){
              _buyCardViewModel.checkCoupon(context);
            },
            child:
            Obx(() => Row(
              children: [
                _buyCardViewModel.coupon.value.isNotEmpty
                    ?InkWell(
                      onTap: (){
                        _buyCardViewModel.deleteCoupon();
                       },
                      child: Padding(
                  padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                  child: Center(child: text('x',fontSize: textSizeNormal,textColor: defaultRed),),
                ),
                    )
                    :Container(),

                Container(
                  width: (Get.width*0.3),
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft:Radius.circular(10),bottomLeft:Radius.circular(10)),
                    color: primaryColor,
                  ),
                  child: Center(child: Padding(
                    padding: const EdgeInsets.only(left: 20.0,right: 20.0),
                    child: text(tr('تطبيق')),
                  )),
                ),
              ],
            ),),
          ),
        ),
      ],
    );
  }
}
