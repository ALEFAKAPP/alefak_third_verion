// import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
// import 'package:alefakaltawinea_animals_app/auto_size_text.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:alefakaltawinea_animals_app/core/view_model/start/navigationViewModel.dart';
// import 'package:alefakaltawinea_animals_app/shared/components/text.dart';
// import 'package:alefakaltawinea_animals_app/shared/constance/colors.dart';
// import 'package:alefakaltawinea_animals_app/shared/constance/fonts.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:alefakaltawinea_animals_app/views/Blogs/Blogs.dart';
// import 'package:alefakaltawinea_animals_app/views/Consultations/MyConsultations.dart';
// import 'package:alefakaltawinea_animals_app/views/home/MainHome.dart';
// import 'package:alefakaltawinea_animals_app/views/myAccounts/MyAccounts.dart';
// import 'package:alefakaltawinea_animals_app/views/myAccounts/Notifications.dart';
//
// import '../../core/view_model/util/util_view_model.dart';
//
// class BottomNavigationBarDefault extends StatelessWidget {
//   BottomNavigationBarDefault({Key? key}) : super(key: key);
//
//   final NavigationViewModel _navigationViewModel =   Get.put(NavigationViewModel());
//
//
//   final UtilViewModel _utilViewModel = Get.put(UtilViewModel());
//
//   Widget tabItem(var pos, var icon, var name) {
//     return InkWell(
//       onTap: () {
//         _navigationViewModel.tabIndex.value = pos;
//       },
//       child: Padding(
//         padding: EdgeInsets.all(5.0),
//         child: Obx(
//           () => Container(
//             alignment: Alignment.center,
//             child: Container(
//               width: 50,
//               // padding: EdgeInsets.only(right: 10,left: 10,top: 5,bottom: 5),
//               decoration: BoxDecoration(
//                 color: _navigationViewModel.tabIndex.value == pos
//                     ? whiteColor
//                     : primaryColor,
//                 borderRadius: BorderRadius.all(Radius.circular(50)),
//               ),
//               child: _navigationViewModel.tabIndex.value == pos
//                   ? Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: <Widget>[
//                         FaIcon(
//                           icon,
//                           color: primaryColor,
//                           size: Get.width * .06,
//                         ),
//                       ],
//                     )
//                   : Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: <Widget>[
//                         FaIcon(
//                           icon,
//                           color: whiteColor,
//                           size: Get.width * .04,
//                         ),
//                         SizedBox(
//                           height: 8,
//                         ),
//                         text(name,
//                             textColor: whiteColor, fontSize: textSizeSSSmall)
//                       ],
//                     ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   List<Widget> _options = <Widget>[
//     MyConsultations(),
//     Notifications(),
//     Blogs(),
//     MyAccounts(),
//     // NotificationView(),
//     // Profile(),
//   ];
//   final iconList = <IconData>[
//     Icons.sticky_note_2,
//     Icons.notifications_on,
//     Icons.edit_note,
//     Icons.person,
//   ];
//
//   final textList = <String>[
//     "إستشاراتي".tr,
//     "notifications".tr,
//     "blog".tr,
//     "حسابي".tr,
//   ];
//
//
//   var _bottomNavIndex = 0; //default index of a first screen
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton:  FloatingActionButton(
//         child: FaIcon(FontAwesomeIcons.houseChimneyWindow,color: Colors.black87,),
//         onPressed: () {
//           _navigationViewModel.tabIndex.value = 5;
//         },
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       bottomNavigationBar: Obx(() => AnimatedBottomNavigationBar.builder(
//         itemCount: iconList.length,
//         tabBuilder: (int index, bool isActive) {
//           final color = isActive ? primaryColor  : textSecondaryColor;
//           return Column(
//             mainAxisSize: MainAxisSize.min,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(
//                 iconList[index],
//                 size: 24,
//                 color: color,
//               ),
//               const SizedBox(height: 4),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 8),
//                 child:
//                     AutoSizeText(
//                     '${textList[index]}',
//                     minFontSize: 7,
//                     maxFontSize: 10,
//                     // stepGranularity: 10,
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                     style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10),
//                     )
//               )
//             ],
//           );
//         },
//         // backgroundColor: Color(0xff373A36),
//         activeIndex: _navigationViewModel.tabIndex.value,
//         splashColor: primaryColor ,
//         // notchAndCornersAnimation: borderRadiusAnimation,
//         splashSpeedInMilliseconds: 300,
//         notchSmoothness: NotchSmoothness.defaultEdge,
//         gapLocation: GapLocation.center,
//         leftCornerRadius: 0,
//         rightCornerRadius: 0,
//         onTap: (index) => _navigationViewModel.tabIndex.value = index,
//         // hideAnimationController: _hideBottomBarAnimationController,
//         shadow: BoxShadow(
//           offset: Offset(0, 1),
//           blurRadius: 12,
//           spreadRadius: 0.5,
//           color:shadowColorGlobal,
//         ),
//       ),
//       ),
//       body: Obx(() => _navigationViewModel.tabIndex.value == 5 ? MainHome(): _options.elementAt(_navigationViewModel.tabIndex.value)),
//     );
//   }
// }
