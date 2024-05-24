import 'package:alefakaltawinea_animals_app/modules/user_notifications/user_notificatiions_screen.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/constants.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/myUtils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/Material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../login/provider/user_provider_model.dart';

class HomeTitleBar extends StatefulWidget {
   const HomeTitleBar();

  @override
  State<HomeTitleBar> createState() => _HomeTitleBarState();
}

class _HomeTitleBarState extends State<HomeTitleBar> {
  List<Map<String, dynamic>> filteredCities = [];
   TextEditingController _cityController = TextEditingController();
   @override
  void initState() {
     _cityController.text=Constants.currentUser!.stateName??tr("select_reagion");
     filteredCities.addAll(MyUtils.getCities());
     super.initState();
  }
   @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: Constants.currentUser!=null,
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 1.h,horizontal: 4.w),
      child: Row(children: [
         Expanded(
           flex: 1,
             child: InkWell(
               onTap: (){onAddressClick(context);},
               child: Row(children: [
           Text(_cityController.text,style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w800),),
           SizedBox(width: 2.w,),
           Image.asset('assets/images/home_dropdowen_icon.png',
               width: 3.5.w,
               height: 3.5.w,
           ),
         ],),
             )),
        Expanded(
          flex: 2,
            child: Center(child:Text("${tr("welcome_back")} ${Constants.currentUser!=null?(Constants.currentUser!.name):''}",style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w800),),)),
        Expanded(child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
          InkWell(
            onTap:(){
              Get.to(UserNotificationsScreen());
            },
            child: Image.asset('assets/images/notification_ic.png',
              width: 6.w,
              height: 6.w,
            ),
          )
        ],))

        /// title
        /// notification icon
      ],),),
    );
  }

  onAddressClick(BuildContext context){
    showBarModalBottomSheet(
      context: context,
      builder: (context) => SingleChildScrollView(
        controller: ModalScrollController.of(context),
        child: Container(
          height: Get.height * 0.9,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: TextField(
                //     controller: _searchController,
                //     onChanged: (q){
                //       print(q);
                //     },
                //     decoration: InputDecoration(
                //       hintText: 'Search for a city',
                //     ),
                //   ),
                // ),
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredCities.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          Constants.prefs!.get(Constants.LANGUAGE_KEY!) == 'ar'
                              ? filteredCities[index]['name']
                              : filteredCities[index]['name_en'],
                          style: TextStyle(color: Colors.grey),
                        ),
                        onTap: () {
                          _cityController.text =
                          Constants.prefs!.get(Constants.LANGUAGE_KEY!) == 'ar'
                              ? filteredCities[index]['name']
                              : filteredCities[index]['name_en'];
                          Navigator.pop(context, filteredCities[index]['name']);

                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ).then((value){
      context.read<UserProviderModel>().updateProfile(
        context,
        Constants.currentUser!.name??'',
        Constants.currentUser!.email??'',
        Constants.currentUser!.phone??'',
        _cityController.text,
      );
      setState(() {
      });
    });
  }
}
