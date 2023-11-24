// import 'package:flutter/material.dart';
// import 'package:hafiz/shared/components/text.dart';
//
// class CustomDialog extends StatelessWidget {
//   String? title ;
//   String? description ;
//   CustomDialog({required this.title ,required this.description});
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
//       elevation: 0.0,
//       backgroundColor: Colors.transparent,
//       child: dialogContent(context),
//     );
//   }
//
//   Widget dialogContent(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(left: 0.0,right: 0.0),
//       child: Stack(
//         children: <Widget>[
//           Container(
//             padding: EdgeInsets.only(
//               top: 18.0,
//             ),
//             margin: EdgeInsets.only(top: 13.0,right: 8.0),
//             decoration: BoxDecoration(
//                 color: Colors.white,
//                 shape: BoxShape.rectangle,
//                 borderRadius: BorderRadius.circular(16.0),
//                 boxShadow: <BoxShadow>[
//                   BoxShadow(
//                     color: Colors.black26,
//                     blurRadius: 0.0,
//                     offset: Offset(0.0, 0.0),
//                   ),
//                 ]),
//             child: Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: <Widget>[
//                   SizedBox(
//                     height: 20.0,
//                   ),
//                   text('$title',isBold: true,fontSize: 16.0),
//                   SizedBox(
//                     height: 10.0,
//                   ),
//                   text('$description',fontSize: 15.0,maxLine: 100),
//                   SizedBox(height: 24.0),
//                 ],
//               ),
//             ),
//           ),
//           Positioned(
//             right: 0.0,
//             child: GestureDetector(
//               onTap: (){
//                 Navigator.of(context).pop();
//               },
//               child: Align(
//                 alignment: Alignment.topRight,
//                 child: CircleAvatar(
//                   radius: 14.0,
//                   backgroundColor: Colors.white,
//                   child: Icon(Icons.close, color: Colors.red),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }