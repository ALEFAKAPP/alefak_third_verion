import 'package:alefakaltawinea_animals_app/app_config.dart';
import 'package:alefakaltawinea_animals_app/core/servies/firebase/analytics_helper.dart';
import 'package:alefakaltawinea_animals_app/shared/components/buttons.dart';
import 'package:alefakaltawinea_animals_app/shared/components/dialog.dart';
import 'package:alefakaltawinea_animals_app/shared/components/text.dart';
import 'package:alefakaltawinea_animals_app/shared/components/utlite.dart';
import 'package:alefakaltawinea_animals_app/shared/constance/colors.dart';
import 'package:alefakaltawinea_animals_app/shared/constance/fonts.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/constants.dart';
import 'package:alefakaltawinea_animals_app/views/cards/BuyCard/steps/StepTow.dart';
import 'package:alefakaltawinea_animals_app/views/cards/BuyCard/steps/Widgets/CouponSection.dart';
import 'package:alefakaltawinea_animals_app/views/cards/BuyCard/steps/Widgets/HedersStep.dart';
import 'package:alefakaltawinea_animals_app/views/cards/BuyCard/steps/Widgets/TypeCard.dart';
import 'package:alefakaltawinea_animals_app/views/cards/BuyCard/steps/Widgets/_Counter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/Material.dart';
import 'package:get/get.dart';
import 'package:alefakaltawinea_animals_app/core/view_model/BuyCards/BuyCardsViewModel.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../modules/cart/subscriptions_screen.dart';
import '../../../../utils/my_utils/myUtils.dart';

class BuyCard extends StatefulWidget {
  @override
  State<BuyCard> createState() => _BuyCardState();
}

class _BuyCardState extends State<BuyCard> {
  BuyCardViewModel _buyCardViewModel = Get.put(BuyCardViewModel());
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      if(Constants.currentUser==null){
        MyUtils.navigateReplaceCurrent(context, SubscriptionScreen());
      }
      if((Constants.currentUser!.valid_subscriptions??0)<1){
        MyUtils.navigateReplaceCurrent(context, SubscriptionScreen());
      }
    });
    _buyCardViewModel.step.value=1;
    AnalyticsHelper().setScreen(screenName: "شاشة-إصدار البطاقة");
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showDialog(
          context: context,
          builder: (context) => DefaultDialogDelete(
            title: tr('هل_تريد_إلغاء_العملية'),
            txtBtn1: tr('yes'),
            txtBtn2: tr('no'),
            onTap: () {
              Get.back();
              Get.back();
            },
          ),
        );

        return shouldPop ?? false; 
      },
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          title:text( tr('اصدار_البطاقة')),
          centerTitle: true,
          backgroundColor: primaryColor,
        ),
        body:  Padding(
          padding:  EdgeInsets.all(0),
          child: Column(
            children: [
              SizedBox(height: 10,),      // الجزء الثابت في الأعلى
              Container(
                height: 70, // ارتفاع الجزء الثابت في الأعلى
                child: HeadersStep(),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        text(tr('desc_futer_card'),fontSize: 15.0.sp,textColor: Colors.red),
                        SizedBox(height: 10,),
                        TypeCard(),
                        SizedBox(height: 15,),
                        CounterCard(),
                        SizedBox(height: 15,),
                        Obx(() => Container(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    text(tr('num_card'),fontSize: textSizeMedium.sp),
                                    Row(
                                      children: [
                                        text('${_buyCardViewModel.numCard}',fontSize: textSizeMedium.sp),
                                        text(tr('بطاقة'),fontSize: textSizeMedium.sp),
                                      ],
                                    ),
                                  ],
                                ),
                                Obx(() =>
                                _buyCardViewModel.discount.value >0
                                    ?Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    text(tr('discount'),fontSize: textSizeMedium.sp,textColor: defaultRed),
                                    Row(
                                      children: [
                                        text('-',fontSize: textSizeMedium.sp,textColor: defaultRed),
                                        text('${_buyCardViewModel.discount}',fontSize: textSizeMedium.sp,textColor: defaultRed),
                                        text(tr('curncy'),fontSize: textSizeMedium.sp,textColor: defaultRed),
                                      ],
                                    ),
                                  ],
                                )
                                    :Container()
                                  ,),
                                line(),

                                SizedBox(height: 5,),
                                defaultButton(
                                    color: primaryColor,
                                    spacingStandard : 10,
                                    text: tr('next'),
                                    function: () {
                                      _buyCardViewModel.BuyCard();
                                    }),
                              ],
                            ),
                          ),
                        )),

                      ],
                    ),
                  ),
                ),
              ),
              // المحتوى القابل للتمرير

              // الجزء الثابت في الأسفل
            ],
          ),
        ),
      ),
    );
  }

}
