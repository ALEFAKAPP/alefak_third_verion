// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:hafiz/shared/constance/colors.dart';
//
// import '../helpers/helpers.dart';
//
// Widget defultCard({
//   @required String? title,
//   @required String? nameCity,
//   @required String? nameArea,
//   @required String? userName,
//   @required String? nameCategory,
//   @required String? publishedDate,
//   @required String? image,
//   @required Function()? onTap,
//   //  ValueChanged? onTap,
//   @required var iconButton,
//   bool isIcon = false,
//   @required var context,
// }) =>
//     Padding(
//       padding: const EdgeInsets.only(top: 10, right: 5, left: 5),
//       child: Card(
//           elevation: 0.0,
//           margin: EdgeInsets.zero,
//           // shape: RoundedRectangleBorder(
//           //   borderRadius: BorderRadius.circular(10.0),
//           // ),
//           color: Color(0xFFEFEFEE),
//           child: InkWell(
//               onTap: onTap,
//               child: Container(
//                 child: Row(children: [
//                   isIcon == false
//                       ? Container(
//                           // height: sizeDefaulte(context, .12),
//                           // width: sizeDefaulteW(context, .24),
//                           height: Get.height * .12,
//                           width: Get.width * .3,
//                           decoration: BoxDecoration(
//                             borderRadius:
//                                 BorderRadius.all(Radius.circular(4.0)),
//                             color: Colors.black12,
//                             border: Border.all(color: Colors.transparent),
//                           ),
//                           child: image != null
//                               // ? cachedNetworkImageDefault(
//                               //     url: "${Helper().getPathImageNetwrok(image)}",
//                               //     height: 200,
//                               //   )
//                               // : defaultAssetImage(
//                               //     height: 200,
//                               //   ),
//                               ? CachedNetworkImage(
//                                   fit: BoxFit.cover,
//                                   imageUrl:
//                                       "${Helper().getPathImageNetwrok(image)}",
//                                   progressIndicatorBuilder: (context, url,
//                                           downloadProgress) =>
//                                       Center(
//                                           child: CircularProgressIndicator(
//                                               backgroundColor: primaryColor,
//                                               value:
//                                                   downloadProgress.progress)),
//                                   errorWidget: (context, url, error) => Icon(
//                                     Icons.image,
//                                     size: 40,
//                                     color: Colors.grey,
//                                   ),
//                                 )
//                               : Icon(Icons.camera_alt_rounded),
//                         )
//                       : Stack(
//                           children: [
//                             Container(
//                               height: Get.height * .12,
//                               width: Get.width * .3,
//                               decoration: BoxDecoration(
//                                 borderRadius:
//                                     BorderRadius.all(Radius.circular(4.0)),
//                                 color: Colors.black12,
//                                 border: Border.all(color: Colors.transparent),
//                               ),
//                               child: image != null
//                                   // ? cachedNetworkImageDefault(
//                                   //     url: "${Helper().getPathImageNetwrok(image)}",
//                                   //     height: 200,
//                                   //   )
//                                   // : defaultAssetImage(
//                                   //     height: 200,
//                                   //   ),
//                                   ? CachedNetworkImage(
//                                       fit: BoxFit.cover,
//                                       imageUrl:
//                                           "${Helper().getPathImageNetwrok(image)}",
//                                       progressIndicatorBuilder: (context, url,
//                                               downloadProgress) =>
//                                           Center(
//                                               child: CircularProgressIndicator(
//                                                   backgroundColor: primaryColor,
//                                                   value: downloadProgress
//                                                       .progress)),
//                                       errorWidget: (context, url, error) =>
//                                           Icon(
//                                         Icons.image,
//                                         size: 40,
//                                         color: Colors.grey,
//                                       ),
//                                     )
//                                   : Icon(Icons.camera_alt_rounded),
//                             ),
//                             Positioned(left: 0, top: 0, child: iconButton)
//                           ],
//                         ),
//                   SizedBox(
//                     width: 5,
//                   ),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       SizedBox(
//                         width: Get.width * 0.5,
//                         child: Text(
//                           title!,
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                           softWrap: false,
//                           style: TextStyle(
//                               color: primaryColor, fontSize: Get.width * .04),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(top: 3.0, bottom: 8.0),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Row(
//                                   children: [
//                                     Icon(
//                                       Icons.access_time,
//                                       size: 12,
//                                     ),
//                                     SizedBox(width: 2),
//                                     SizedBox(
//                                       width: Get.width * 0.26,
//                                       child: publishedDate == null
//                                           ? Text("")
//                                           : Text(
//                                               publishedDate,
//                                               maxLines: 1,
//                                               overflow: TextOverflow.ellipsis,
//                                               softWrap: false,
//                                               style: TextStyle(fontSize: 11),
//                                             ),
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(
//                                   height: 5,
//                                 ),
//                                 Row(
//                                   children: [
//                                     Icon(
//                                       Icons.location_on,
//                                       size: 12,
//                                     ),
//                                     SizedBox(width: 2),
//                                     SizedBox(
//                                       width: Get.width * 0.26,
//                                       child: Text(
//                                         "$nameArea - $nameCity",
//                                         maxLines: 1,
//                                         overflow: TextOverflow.ellipsis,
//                                         softWrap: false,
//                                         style: TextStyle(fontSize: 11),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                             SizedBox(
//                               width: 10,
//                             ),
//                             Column(
//                               children: [
//                                 Row(
//                                   children: [
//                                     Icon(
//                                       Icons.account_circle,
//                                       size: 12,
//                                     ),
//                                     SizedBox(width: 2),
//                                     SizedBox(
//                                       width: Get.width * 0.26,
//                                       child: userName == null
//                                           ? Text("")
//                                           : Text(
//                                               userName,
//                                               maxLines: 1,
//                                               overflow: TextOverflow.ellipsis,
//                                               softWrap: false,
//                                               style: TextStyle(fontSize: 11),
//                                             ),
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(
//                                   height: 3,
//                                 ),
//                                 Row(
//                                   children: [
//                                     Icon(
//                                       Icons.now_widgets,
//                                       size: 12,
//                                     ),
//                                     SizedBox(width: 2),
//                                     SizedBox(
//                                       width: Get.width * 0.26,
//                                       child: Text(
//                                         nameCategory!,
//                                         maxLines: 1,
//                                         overflow: TextOverflow.ellipsis,
//                                         softWrap: false,
//                                         style: TextStyle(fontSize: 11),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       )
//                     ],
//                   ),
//                 ]),
//               ))),
//     );
