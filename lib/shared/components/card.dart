//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:alefakaltawinea_animals_app/shared/components/text.dart';
// import 'package:alefakaltawinea_animals_app/shared/components/utlite.dart';
// import 'package:alefakaltawinea_animals_app/shared/constance/fonts.dart';
//
// import '../constance/colors.dart';
//
// Widget CardAccount({required String title , required String icon , Function()? function})
// {
//   return Padding(
//     padding: const EdgeInsets.only(bottom: 10),
//     child: InkWell(
//         onTap :function,
//         child: Column(
//           children: [
//             Container(
//               width: Get.width,
//               height: 50,
//               child: Card(
//                 borderOnForeground: false,
//                 color: whiteColor,
//                 elevation: 0.0,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                       Row(
//                         children: [
//                           Image.asset(icon,height: 25,),
//                           SizedBox(width: 20,),
//                           text(title,fontSize: textSizeSMedium,isBold: true,textColor:textSecondaryColor ),
//                         ],
//                       ),
//                       Icon(Icons.arrow_forward_ios,size: 13,color: kTextColor,),
//                   ],
//                 ),
//               ),
//             ),
//             lineWithoutPadding(),
//           ],
//         ),
//       ),
//   ) ;
// }
//
// Widget CardDrawer({required String title , required String icon , Function()? function})
// {
//   return Padding(
//     padding: const EdgeInsets.all(10),
//     child: InkWell(
//       onTap :function,
//       child: Container(
//         width: Get.width,
//         height: 50,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Row(
//               children: [
//                 Image.asset(icon,height: 25,color: whiteColor,),
//                 SizedBox(width: 20,),
//                 text(title,fontSize: textSizeMedium,isBold: true,textColor:whiteColor ),
//               ],
//             ),
//             Padding(
//               padding: const EdgeInsets.only(right: 8.0,left: 8.0),
//               child: Icon(Icons.arrow_forward_ios,size: 15,color: whiteColor,),
//             ),
//           ],
//         ),
//       ),
//     ),
//   ) ;
// }