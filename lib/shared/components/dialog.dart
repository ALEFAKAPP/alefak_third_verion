import 'package:alefakaltawinea_animals_app/shared/components/text.dart';
import 'package:alefakaltawinea_animals_app/shared/components/utlite.dart';
import 'package:alefakaltawinea_animals_app/shared/constance/colors.dart';
import 'package:alefakaltawinea_animals_app/shared/constance/fonts.dart';
import 'package:alefakaltawinea_animals_app/shared/constance/size.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../modules/login/login_screen.dart';
import '../../utils/my_utils/myUtils.dart';

void msgreguser(BuildContext context){
  showDialog(context: context, builder: (BuildContext context) {
    return DefaultDialogDelete(
      title: "يجب التسجيل في التطبيق",
      txtBtn1: tr("register"),
      onTap: (){
        MyUtils.navigate(context, LoginScreen());
      },
    );
  });
  }
class DefaultDialogDelete extends StatelessWidget {
  String? title, desc, image, txtBtn1, txtBtn2;
  Function()? onTap;
  DefaultDialogDelete(
      {this.title = 'تاكيد الحذف',
      this.desc = '',
      this.image = '',
      this.txtBtn1 = '',
      this.txtBtn2 = 'الغاء',
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(border_radius_default),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration:  BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(border_radius_default),
          boxShadow: [
            BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: const Offset(0.0, 10.0)),
          ],
        ),
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // Padding(
            //   padding: const EdgeInsets.only(top: 20),
            //   child: ClipRRect(
            //     borderRadius: BorderRadius.only(
            //         topLeft: Radius.circular(8), topRight: Radius.circular(8)),
            //     child: Image(
            //         image: AssetImage('$image'), height: 100, fit: BoxFit.fill),
            //   ),
            // ),
            const SizedBox(
              height: 10,
            ),
            DefaultText(
              text: '$title',
              color: textPrimaryColor,
              fontSize: 18,
              boldText: true,
              maxLines: 2,
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: text(
                "$desc",
                textColor: textSecondaryColor,
                maxLine: 3,
                isCentered: true,
                fontSize: 13.0,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                      child: InkWell(
                    onTap: onTap,
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration:
                          boxDecoration(bgColor: primaryColor, radius: 4),
                      child: Center(
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                  text: "$txtBtn1",
                                  style: TextStyle(
                                      fontSize: 16.0, color: Colors.white,fontFamily: fontPrimary)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: boxDecoration(
                            color: textPrimaryColor,
                            radius: 4,
                            bgColor: backgroundColor),
                        child: Center(
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                    text: "$txtBtn2",
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        color: textPrimaryColor,
                                        fontFamily: fontPrimary)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }
}
