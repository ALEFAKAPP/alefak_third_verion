
import 'package:alefakaltawinea_animals_app/shared/constance/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

BoxDecoration boxDecoration({double radius = 2, Color color = Colors.transparent, Color? bgColor, var showShadow = false}) {
  return BoxDecoration(
    color: bgColor ?? backgroundColor,
    boxShadow: showShadow ? defaultBoxShadow(shadowColor: shadowColorGlobal) : [BoxShadow(color: Colors.transparent)],
    border: Border.all(color: color),
    borderRadius: BorderRadius.all(Radius.circular(radius)),
  );
}

//------------------------------------------- Icon Image -------------------------------------------------------------------------

Widget iconImage({src,height = 25.0}){
  return Image.asset('$src',height:height ,);
}

//-------------------------------------------View-------------------------------------------------------------------------
Widget line() {
  return Padding(
    padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
    child: Divider(color: line_color, height: 0.5),
  );
}

Widget lineWithoutPadding() {
  return Padding(
    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
    child: Divider(color: ColorInputFiled2, height: 0.5),
  );
}
Widget SizeBoxDefilt({height = 15.0}){
  return SizedBox(height: height,);
}