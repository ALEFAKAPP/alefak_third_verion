import 'package:alefakaltawinea_animals_app/shared/components/text.dart';
import 'package:alefakaltawinea_animals_app/shared/constance/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

AppBar appBar( String title, {List<Widget>? actions,elevation = 2.0,centerTitle = false, bool showBack = true, Color? color, Color? iconColor, Color? textColor}) {
  return AppBar(
    automaticallyImplyLeading: false,
    elevation : elevation,
    centerTitle: centerTitle,
    backgroundColor: color ?? whiteColor,
    leading: showBack
        ? IconButton(
      onPressed: () {
        Get.back();
      },
      icon: Icon(Icons.arrow_back, color: Colors.black87),
    )
        : null,
    title: appBarTitleWidget(title, textColor: textColor, color: whiteColor),
    actions: actions,
  );
}

AppBar appBarWithTabBar( String title, {List<Widget>? actions,required bottom,elevation = 2.0, bool showBack = true, Color? color, Color? iconColor, Color? textColor}) {
  return AppBar(
    automaticallyImplyLeading: false,
    elevation : elevation,
    backgroundColor: color ?? whiteColor,
    bottom: bottom,
    leading: showBack
        ? IconButton(
      onPressed: () {
        Get.back();
      },
      icon: Icon(Icons.arrow_back, color: Colors.black87),
    )
        : null,
    title: appBarTitleWidget(title, textColor: textColor, color: whiteColor),
    actions: actions,
  );
}

