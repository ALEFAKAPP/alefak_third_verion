// import 'package:alefakaltawinea_animals_app/shared/constance/colors.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// class drawer extends StatelessWidget {
//
//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       backgroundColor: primaryColor,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           SizedBox(height: 30.0,),
//           CardDrawer(
//               title: 'الملف الشخصي'.tr,
//               icon: 'assets/icons/user_1.png',
//               function: () {
//                 Get.to(MyProfile());
//                 // Get.to(ChangePhoneNumber());
//               }),
//           CardDrawer(
//               title: 'الاعدادات'.tr,
//               icon: 'assets/icons/setting.png',
//               function: () {
//                 Get.to(Settings());
//               }),
//           CardDrawer(
//               title: 'Connect us'.tr,
//               icon: 'assets/icons/customer-service.png',
//               function: () {
//                 Get.to(ConnectUs());
//               }),
//           CardDrawer(
//               title: 'Rate our app'.tr,
//               icon: 'assets/icons/star.png',
//               function: () {
//                 launchUrl(Uri.parse("https://play.google.com/store/games?device=phone"));
//               }),
//           CardDrawer(
//               title: 'تسجيل الخروج'.tr,
//               icon: 'assets/icons/logout.png',
//               function: () {
//                 showDialog(
//                   context: context,
//                   builder: (BuildContext context) =>
//                       DefaultDialogDelete(
//                         title: 'تأكيد الخروج'.tr,
//                         desc:
//                         'هل أنت متأكد من عملية تسجيل الخروج من التطبيق؟'
//                             .tr,
//                         image: 'assets/icons/check-out.png',
//                         txtBtn1: 'خروج'.tr,
//                         txtBtn2: 'إلغاء'.tr,
//                         onTap: () {
//                           _myAccountViewModel.logout();
//                         },
//                       ),
//                 );
//               }),
//
//         ],
//       ),
//     );
//   }
// }
