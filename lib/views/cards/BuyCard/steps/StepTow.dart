import 'dart:io';
import 'package:alefakaltawinea_animals_app/core/view_model/BuyCards/BuyCardsViewModel.dart';
import 'package:alefakaltawinea_animals_app/shared/components/buttons.dart';
import 'package:alefakaltawinea_animals_app/shared/components/dialogGalleryOrCamera.dart';
import 'package:alefakaltawinea_animals_app/shared/components/input_forms.dart';
import 'package:alefakaltawinea_animals_app/shared/components/text.dart';
import 'package:alefakaltawinea_animals_app/shared/constance/colors.dart';
import 'package:alefakaltawinea_animals_app/shared/constance/fonts.dart';
import 'package:alefakaltawinea_animals_app/views/cards/BuyCard/steps/Widgets/HedersStep.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class StepTow extends StatelessWidget {
  BuyCardViewModel _buyCardViewModel = Get.find();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: text(tr('بيانات البطاقة')),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      body: Form(
        key:_formKey ,
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            Container(
              height: 80, // ارتفاع الجزء الثابت في الأعلى
              child: HeadersStep(),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    for (int index = 0; index < _buyCardViewModel.numCard.value; index++)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            text('${tr('بيانات_البطاقة_رقم')}  ${index + 1}',isBold: true,fontSize: textSizeMedium),
                            SizedBox(height: 10,),
                            DottedBorder(
                              dashPattern: [8, 4],
                              strokeWidth: 2,
                              color: fifthColor,
                              borderType: BorderType.RRect,
                              radius: Radius.circular(10),
                              padding: EdgeInsets.all(0),
                              child: Container(
                                width: Get.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 1.0,
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    GetBuilder<BuyCardViewModel>(
                                      builder: (_buyCardsViewModel) {
                                      return Container(
                                            width:Get.width *.35,
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                  const EdgeInsets.only(top: 5, bottom: 5),
                                                  child: InkWell(
                                                    onTap: () {
                                                      FocusManager.instance.primaryFocus
                                                          ?.unfocus();
                                                      showSelectionDialog(
                                                          context, _buyCardViewModel, index);
                                                    },
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(5.0),
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.all(
                                                              Radius.circular(10)),
                                                          color: ColorInputFiled,
                                                        ),
                                                        width: 100.w,
                                                        height: 100.h,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment.center,
                                                          mainAxisAlignment:
                                                          MainAxisAlignment.center,
                                                          children: [
                                                                  _buyCardViewModel
                                                                      .images.isNotEmpty &&
                                                                      _buyCardViewModel
                                                                          .images[index] !=
                                                                          null
                                                                      ? Center(
                                                                    child: Stack(
                                                                      // crossAxisAlignment:
                                                                      // CrossAxisAlignment.end,
                                                                      children: [
                                                                        Container(
                                                                          width: 100.w,
                                                                          height: 100.h,
                                                                          decoration: BoxDecoration(
                                                                            borderRadius: BorderRadius.all(
                                                                                Radius.circular(10)),
                                                                            color: ColorInputFiled,
                                                                          ),
                                                                          child: Image.file(
                                                                            File(
                                                                              _buyCardsViewModel
                                                                                  .images[index]!
                                                                                  .path,
                                                                            ),
                                                                            fit: BoxFit.fill,
                                                                          ),
                                                                        ),
                                                                        Positioned(
                                                                          top: 0,
                                                                          child: InkWell(
                                                                              onTap: () {
                                                                                _buyCardsViewModel
                                                                                    .resetImage(
                                                                                    index);
                                                                              },
                                                                              child:
                                                                              CircleAvatar(
                                                                                backgroundColor:
                                                                                Colors.red,
                                                                                radius: 10,
                                                                                child: Padding(
                                                                                  padding:
                                                                                  const EdgeInsets
                                                                                      .all(
                                                                                      0.0),
                                                                                  child: Icon(
                                                                                    Icons.close,
                                                                                    size: 15,
                                                                                    color: Colors
                                                                                        .white,
                                                                                  ),
                                                                                ),
                                                                              )),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  )
                                                                      : Center(
                                                                    heightFactor: 1.5,
                                                                    child: Image.asset(
                                                                      'assets/images/ic_home_grey.png',
                                                                      height: 30,
                                                                    ),
                                                                  )

                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                text(tr('صورة_اليفك'), fontSize: textSizeSmall)
                                              ],
                                            ),
                                          );
                                    }
                                  ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          width:Get.width *.55,

                                          child: Column(
                                            children: [
                                              LabelInputField(text: tr('اسم_اليفك')),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Container(
                                                child: formField(
                                                  context,
                                                  tr('ادخل_اسم_اليفك'),
                                                  keyboardType: TextInputType.text,
                                                  controller: _buyCardViewModel.name_alefk[index],
                                                  validator: (val) {
                                                    if (_buyCardViewModel.name_alefk[index].text.isNotEmpty)
                                                      return null;
                                                    else
                                                      return tr('ادخل_اسم_اليفك');
                                                  },
                                                  // onSaved: _authViewModel.sendOtp
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              LabelInputField(text: tr('حدد_النوع')),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              InkWell(
                                                onTap: (){
                                                  FocusManager.instance.primaryFocus?.unfocus();
                                                  showBarModalBottomSheet(
                                                    context: context,
                                                    builder: (context) => SingleChildScrollView(
                                                      controller: ModalScrollController.of(context),
                                                      child: Container(
                                                        height: Get.height * 0.7,
                                                        child: Padding(
                                                          padding: const EdgeInsets.all(8.0),
                                                          child: Column(
                                                            children: [
                                                              Expanded(
                                                                child: ListView.builder(
                                                                  itemCount: _buyCardViewModel.types.length,
                                                                  itemBuilder: (context, i) {
                                                                    return ListTile(
                                                                      title: Text(
                                                                        _buyCardViewModel.types[i],
                                                                        style: TextStyle(color: Colors.grey),
                                                                      ),
                                                                      onTap: () {
                                                                        _buyCardViewModel.type_alefk[index].text = _buyCardViewModel.types[i] ;
                                                                        Get.back();
                                                                      },
                                                                    );
                                                                  },
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: Container(
                                                  child: formField(
                                                    context,
                                                    tr('اضغط لتحديد النوع'),
                                                    keyboardType: TextInputType.text,
                                                    isEnabled:false,
                                                    controller: _buyCardViewModel.type_alefk[index],
                                                    validator: (val) {
                                                      if (_buyCardViewModel.type_alefk[index].text.isNotEmpty)
                                                        return null;
                                                      else
                                                        return tr('يرجى تحديد النوع');
                                                    },
                                                    // onSaved: _authViewModel.sendOtp
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              LabelInputField(text: tr('حدد_الجنس')),

                                              Container(
                                                height: 50,
                                                width: Get.width,
                                                child: Obx(()=>Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                  children: [
                                                    InkWell(
                                                      onTap: (){
                                                        _buyCardViewModel.sex[index] = 'male';
                                                      },
                                                      child: Container(
                                                        height: 30,
                                                        width: Get.width/4,
                                                        decoration: BoxDecoration(
                                                          color: _buyCardViewModel.sex[index] == 'male' ? primaryColor : ColorInputFiled2,
                                                          borderRadius: BorderRadius.all( Radius.circular(10.0)),
                                                        ),
                                                        child: Center(child: DefaultText(text: tr("male"),boldText: true,
                                                          color: _buyCardViewModel.sex[index] == 'male' ?whiteColor : secondColor,
                                                          fontSize: textSizeSmall,)),
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: (){
                                                        _buyCardViewModel.sex[index] = 'feminine';
                                                      },
                                                      child: Container(
                                                        height: 30,
                                                        width: Get.width/4,
                                                        decoration: BoxDecoration(
                                                          color: _buyCardViewModel.sex[index] == 'feminine' ? primaryColor : ColorInputFiled2,
                                                          borderRadius: BorderRadius.all( Radius.circular(10.0)),
                                                        ),
                                                        child: Center(child: DefaultText(text: tr("female"),boldText: true,
                                                          color: _buyCardViewModel.sex[index] == 'feminine' ?whiteColor : secondColor,
                                                          fontSize: textSizeSmall,)),
                                                      ),
                                                    ),
                                                  ],
                                                )),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    defaultButton(
                        color: primaryColor,
                        spacingStandard : 10,
                        text: tr('Next'),
                        function: () {
                          var isValid = _formKey.currentState?.validate();
                          if (!isValid!) {
                            return;
                          }
                          _buyCardViewModel.saveDataCard();
                          // _buyCardViewModel.BuyCard();
                        }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
