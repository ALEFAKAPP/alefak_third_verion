import 'package:alefakaltawinea_animals_app/shared/constance/size.dart';
import 'package:flutter/material.dart';

const primaryColor = Color(0xff0ababa);
const primaryColorChat = primaryColor;
const primaryColorWtihOpcity = Color.fromRGBO(10, 186, 186, .5);
const primaryColor2 = Color(0xffF95AD0);
//for text
const textPrimaryColor = Color.fromRGBO(49, 49, 49, 1.0);
const textSecondaryColor = Color.fromRGBO(115, 115, 115, 1);
const secondColor = Color.fromRGBO(49, 49, 49, 1.0);
const thirdColor = Color.fromRGBO(83, 83, 83, 1.0);
const fifthColor = Color.fromRGBO(162, 153, 153, 1.0);
// const shadowColorGlobal = Color.fromRGBO(219, 218, 218, 1.0);
const ColorInputFiled = Color.fromRGBO(245, 245, 245, 1.0);
const ColorInputFiled2 = Color.fromRGBO(239, 239, 239, 1.0);
const backgroundColor = Color.fromRGBO(245, 245, 245, 1.0);
const backgroundColorPrimary = Color(0xffF8F3EA);
const whiteColor = Color.fromRGBO(255, 255, 255, 1);
const whiteColor2 = Color(0xffFFFAF1);
Color shadowColorGlobal = Colors.grey.withOpacity(0.2);
Color colorCard = Color.fromARGB(255, 239, 240, 241);
Color colorNotification = Color(0xffFFC107);
Color colorSucess = Color(0xff1bcc26);
const Color line_color = Color(0XFFDADADA);
const Color defaultRed = Color(0XFFF20C0C);
const kTextColor = Color(0xFF535353);
const kTextLightColor = Color(0xFF7C7C7C);
const kTextLightColor2 = Color(0xFFCCCCCC);

const gradient = LinearGradient(colors: <Color>[
  Color(0xFF0D47A1),
  Color(0xFF1976D2),
  Color(0xFF42A5F5),
], begin: Alignment.centerLeft, end: Alignment.centerRight);

/// default box shadow
List<BoxShadow> defaultBoxShadow({
  Color? shadowColor,
  double? blurRadius,
  double? spreadRadius,
  Offset offset = const Offset(0.0, 0.0),
}) {
  return [
    BoxShadow(
      color: shadowColor ?? shadowColorGlobal,
      blurRadius: blurRadius ?? defaultBlurRadius,
      spreadRadius: spreadRadius ?? defaultSpreadRadius,
      offset: offset,
    )
  ];
}
