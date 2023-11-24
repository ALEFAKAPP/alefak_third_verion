import 'package:get/get.dart';
import 'package:alefakaltawinea_animals_app/app_config.dart';
import 'package:alefakaltawinea_animals_app/shared/components/text.dart';
import 'package:alefakaltawinea_animals_app/shared/constance/colors.dart';
import 'package:alefakaltawinea_animals_app/shared/constance/fonts.dart';
import 'package:flutter/material.dart';

import '../constance/constance.dart';
import 'images.dart';

Widget defaultButton({
  @required String? text ,
  Color colorText = whiteColor,
  Color color = primaryColor,
  bool isGradient = false,
  double height = 50,
  double spacingStandard = spacing_standard,
  bool isBorder = false,
  double width = double.infinity,
  Color borderSideColor = primaryColor,
  @required Function()? function,
}){
  return Container(
    width: width,
    height: height,
    decoration: isGradient ? BoxDecoration(
      gradient: gradient,
      borderRadius: BorderRadius.circular(defaultRadius),
    ): BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(defaultRadius),
    ),
    child: MaterialButton(
      elevation: 0.0,
      highlightColor: Colors.black87,
      padding: EdgeInsets.only(top: spacing_middle, bottom: spacing_middle),
      child: DefaultText(text: '$text',color: colorText,fontSize: 15,boldText: true,),
      shape: RoundedRectangleBorder(
          borderRadius:  BorderRadius.circular(spacingStandard),
          side: isBorder? BorderSide(color: borderSideColor) :BorderSide(color: borderSideColor.withOpacity(0)),
      ),
      onPressed: function,
    ),
  );
}

Widget defaultButtonWithIcon({
  @required String? text ,
  @required String? icon ,
  Color colorText = whiteColor,
  Color color = primaryColor,
  bool isGradient = true,
  bool isBorder = false,
  double width = double.infinity,
  double height = 50,
  bool isIconArrow = false,
  Color borderSideColor = primaryColor,
  @required Function()? function,
}){
  return Container(
    width: width,
    height: height,
    decoration: isGradient ? BoxDecoration(
      gradient: gradient,
      borderRadius: BorderRadius.circular(defaultRadius),
    ): BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(defaultRadius),
    ),
    child: MaterialButton(
      elevation: 0.0,
      highlightColor: Colors.black87,
      padding: EdgeInsets.only(top: spacing_middle, bottom: spacing_middle,right: spacing_middle,left: spacing_middle),
      child: Row(
        mainAxisAlignment: isIconArrow == false ?MainAxisAlignment.start :MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                child: assetImageDefault(image: icon ),
              ),
              SizedBox(width: 10,),
            ],
          ),
          Center(child: DefaultText(text: '$text',color: colorText,)),
          isIconArrow == true ? Icon(Icons.arrow_forward,color:colorText ,) : SizedBox(),
        ],
      ),
      shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(spacing_standard),
        side: isBorder? BorderSide(color: borderSideColor) :BorderSide(color: borderSideColor.withOpacity(0)),
      ),
      onPressed: function,
    ),
  );
}

Widget inkWellContainer(
    hint, {
      @required Function()? function,
      @required TextStyle? style,
    }) =>
    InkWell(
      onTap: function,
      child: Container(
        decoration: BoxDecoration(
          color: ColorInputFiled,
          borderRadius: BorderRadius.circular(10.0),
        ),
        width: Get.width,
        height: heightInputFiled,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            hint,
            style: style,
          ),
        ),
      ),
    );
