// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:hafiz/shared/constance/colors.dart';
//
// messageAllert(String msg, context) {
//   showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return new CupertinoAlertDialog(
//           title: Text(msg),
//           actions: [
//             CupertinoDialogAction(
//               isDefaultAction: true,
//               child: Column(
//                 children: <Widget>[
//                   Text('موافق'.tr,
//                       style: TextStyle(
//                         color: primaryColor,
//                       )),
//                 ],
//               ),
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//             ),
//           ],
//         );
//       });
// }
//
// messageAllertt(String msg, context) {
//   showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return new CupertinoAlertDialog(
//           title: Text(msg),
//           actions: [
//             CupertinoDialogAction(
//               isDefaultAction: true,
//               child: Column(
//                 children: <Widget>[
//                   Text('موافق'.tr,
//                       style: TextStyle(
//                         color: primaryColor,
//                       )),
//                 ],
//               ),
//               onPressed: () {
//                 SystemNavigator.pop();
//               },
//             ),
//           ],
//         );
//       });
// }
//
// Widget showDialogeSuccsess({
//   @required String? text,
//   var function,
// }) =>
//     AlertDialog(
//       content: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Container(
//               height: 100,
//               width: 100,
//               child: Image.asset("assets/images/checked.png")),
//           SizedBox(height: 30),
//           Text(
//             '$text',
//             style: TextStyle(fontSize: Get.width * 0.04, color: primaryColor),
//           ),
//         ],
//       ),
//       actionsOverflowButtonSpacing: 20,
//       actions: [
//         ElevatedButton(
//             onPressed: function,
//             child: Text("موافق".tr),
//             style: ElevatedButton.styleFrom(backgroundColor: primaryColor)),
//       ],
//     );
//
// showDialogForSure({
//   @required var context,
//   @required var title,
//   @required var text,
//   String textBut1 = 'إلفاء',
//   String textBut2 = 'تأكيد',
//   var function,
// }) =>
//     AlertDialog(
//       title: Text(title),
//       content: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Text(
//             text,
//           ),
//         ],
//       ),
//       actionsOverflowButtonSpacing: 20,
//       actions: [
//         ElevatedButton(
//             style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
//             onPressed: () {
//               Get.back();
//             },
//             child: Text(textBut1)),
//         ElevatedButton(
//             style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
//             onPressed: function,
//             child: Text(
//               textBut2,
//               style: TextStyle(color: Colors.white),
//             )),
//       ],
//     );
