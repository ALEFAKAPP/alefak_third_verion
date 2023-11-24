import 'package:alefakaltawinea_animals_app/shared/constance/colors.dart';
import 'package:alefakaltawinea_animals_app/shared/constance/fonts.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DefaultText extends StatelessWidget {
  final text;
  final double fontSize;
  final bool boldText;
  final Color color;
  final int maxLines;
  DefaultText(
      {this.text,
      this.fontSize = 15,
      this.boldText = false,
      this.color = secondColor,
      this.maxLines = 1});

  @override
  Widget build(BuildContext context) {
    return Text(
      "$text",
      textAlign: TextAlign.start,
      overflow: TextOverflow.fade,
      maxLines: maxLines,
      style: TextStyle(
        fontSize: fontSize,
        fontFamily: boldText == true ? fontPrimaryBold : fontPrimary,
        color: color,
      ),
      softWrap: false,
    );
  }
}

Widget lableText({@required text}) {
  return DefaultText(
    text: text,
    fontSize: textSizeSmall,
    color: thirdColor,
  );
}

Widget TabList({@required title}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: DefaultText(
      text: title,
      fontSize: textSizeSmall,
      color: textSecondaryColor,
    ),
  );
}

Widget largText({@required text}) {
  return DefaultText(
    text: text,
    fontSize: textSizeXLarge,
    color: secondColor,
    boldText: true,
  );
}

class LabelInputField extends StatelessWidget {
  @required
  final text;
  final double fontSize;
  final int maxLine;
  final Color color;
  LabelInputField({this.text, this.fontSize = 14, this.color = thirdColor,this.maxLine = 1});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Constants.SELECTED_LANGUAGE == 'ar'
          ? Alignment.topRight
          : Alignment.topLeft,
      child: Text(
        "$text",
        overflow: maxLine == 1 ?TextOverflow.fade:TextOverflow.ellipsis,
        maxLines: maxLine,
        style: TextStyle(
          fontSize: fontSize,
          fontFamily: fontPrimary,
          color: color,
          fontWeight: FontWeight.bold
        ),
        softWrap: false,
      ),
    );
  }
}

class CustomText extends StatelessWidget {
  final String text;

  final double fontSize;

  final Color color;

  final Alignment alignment;

  final int maxLine;
  final double height;

  CustomText({
    this.text = '',
    this.fontSize = 16,
    this.color = Colors.black,
    this.alignment = Alignment.topLeft,
    this.maxLine = 1,
    this.height = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      child: Text(
        text,
        style: TextStyle(
          color: color,
          height: height,
          fontSize: fontSize,
        ),
        maxLines: maxLine,
      ),
    );
  }
}

Widget text(
  String? text, {
  var fontSize = textSizeLargeMedium,
  Color? textColor,
  var fontFamily,
  var isCentered = false,
  var isBold = false,
  var maxLine = 1,
  var latterSpacing = 0.5,
  bool textAllCaps = false,
  var isLongText = false,
  bool lineThrough = false,
}) {
  return Text(
    textAllCaps ? text!.toUpperCase() : text!,
    textAlign: isCentered ? TextAlign.center : TextAlign.start,
    maxLines: isLongText ? null : maxLine,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(
      fontFamily: fontPrimary,
      fontSize: fontSize,
      color: textColor,
      fontWeight: isBold ? FontWeight.bold : null,
      height: 1.5,
      letterSpacing: latterSpacing,
      decoration:
          lineThrough ? TextDecoration.lineThrough : TextDecoration.none,
    ),
  );
}

Text textProfile(var label) {
  return Text(label,
      style: TextStyle(color: secondColor, fontSize: 18, fontFamily: fontPrimary),
      textAlign: TextAlign.center);
}

Widget appBarTitleWidget(String title, {Color? color, Color? textColor}) {
  return Container(
    width: double.infinity,
    color: color ?? primaryColor,
    child: Text(
      title,
      style: TextStyle(
          color: secondColor,
          fontWeight: FontWeight.bold,
          fontSize: textSizeMedium),
      maxLines: 1,
    ),
  );
}

Row profileText(var label, {var maxline = 1}) {
  return Row(
    children: <Widget>[
      Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
          child: text(label,
              fontSize: textSizeLargeMedium,
              textColor: thirdColor,
              maxLine: maxline)),
    ],
  );
}

Row rowHeading(var label) {
  return Row(
    children: <Widget>[
      Padding(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: DefaultText(
            text: label, color: primaryColor, fontSize: 18, boldText: true),
      ),
    ],
  );
}
