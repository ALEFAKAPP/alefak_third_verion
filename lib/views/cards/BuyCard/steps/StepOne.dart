import 'package:alefakaltawinea_animals_app/app_config.dart';
import 'package:alefakaltawinea_animals_app/shared/components/buttons.dart';
import 'package:alefakaltawinea_animals_app/shared/components/dialog.dart';
import 'package:alefakaltawinea_animals_app/shared/components/text.dart';
import 'package:alefakaltawinea_animals_app/shared/components/utlite.dart';
import 'package:alefakaltawinea_animals_app/shared/constance/colors.dart';
import 'package:alefakaltawinea_animals_app/shared/constance/fonts.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/constants.dart';
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

class BuyCard extends StatefulWidget {
  @override
  State<BuyCard> createState() => _BuyCardState();
}

class _BuyCardState extends State<BuyCard> {
  BuyCardViewModel _buyCardViewModel = Get.put(BuyCardViewModel());

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
                        text(tr('desc_futer_card'),fontSize: 15.0.sp),
                        InkWell(
                            onTap:(){
                              showBarModalBottomSheet(
                                context: context,
                                builder: (context) => SingleChildScrollView(
                                  controller: ModalScrollController.of(context),
                                  child: Container(
                                    height: Get.height * 0.9,
                                    child: Stack(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(0.0),
                                          child: CachedNetworkImage(
                                            imageUrl: urlImage +  Constants.APP_INFO!.futureCard!,
                                            progressIndicatorBuilder: (context, url, downloadProgress) =>
                                                Center(child: SizedBox(width: 50.0,height: 50.0,child: CircularProgressIndicator(value: downloadProgress.progress,strokeWidth: 2,))),
                                            errorWidget: (context, url, error) => Icon(Icons.error),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: (){
                                            Get.back();
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Align(
                                              alignment: Alignment.topLeft,
                                              child: Container(
                                                width: 40,
                                                height: 40,
                                                padding: const EdgeInsets.all(5.0),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  color: Colors.black,
                                                ),
                                                child: Row(
                                                  children: [
                                                    Icon(Icons.arrow_drop_down_circle_outlined,size: 30,color: Colors.white ,),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },child: text(tr('لمعرفة_المزيد_اضغط_هنا'),fontSize: 15.0.sp,textColor: defaultRed)),
                        SizedBox(height: 10,),
                        TypeCard(),
                        SizedBox(height: 15,),
                        CounterCard(),
                        SizedBox(height: 15,),
                        CouponSection(),
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
                                    text(tr('sub_total'),fontSize: textSizeMedium.sp,isBold: true),
                                    Row(
                                      children: [
                                        text('${_buyCardViewModel.subtotal}',fontSize: textSizeMedium.sp,isBold: true),
                                        text(tr('curncy'),fontSize: textSizeMedium.sp,isBold: true),
                                      ],
                                    ),
                                  ],
                                ),
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
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    text(tr('المبلغ_الإجمالي'),textColor: primaryColor,isBold: true),
                                    Row(
                                      children: [
                                        text('${_buyCardViewModel.total}',textColor: primaryColor,isBold: true),
                                        text(tr('curncy'),textColor: primaryColor,isBold: true),
                                      ],
                                    ),
                                  ],
                                ),
                                text(tr('not_pay_card'),fontSize: textSizeSMedium),
                                SizedBox(height: 5,),
                                defaultButton(
                                    color: primaryColor,
                                    spacingStandard : 10,
                                    text: tr('الدفع'),
                                    function: () {
                                      // _buyCardViewModel.changeStateAfterPayment();
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
