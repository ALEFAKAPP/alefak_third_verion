import 'package:alefakaltawinea_animals_app/modules/adoption/provider/adoption_provider_model.dart';
import 'package:alefakaltawinea_animals_app/modules/baseScreen/baseScreen.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/baseDimentions.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/baseTextStyle.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/myColors.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/myUtils.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/resources.dart';
import 'package:alefakaltawinea_animals_app/utils/my_widgets/action_bar_widget.dart';
import 'package:alefakaltawinea_animals_app/utils/my_widgets/transition_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/my_widgets/adoption_alert.dart';
import 'data/animal_pager_list_model.dart';

class AnimalDetailsScreen extends StatefulWidget {
  int index;
   AnimalDetailsScreen(this.index);

  @override
  _AnimalDetailsScreenState createState() => _AnimalDetailsScreenState();
}

class _AnimalDetailsScreenState extends State<AnimalDetailsScreen> {
  AdoptionProviderModel? adoptionProviderModel;
  bool showPhone=false;
  void initState() {
    super.initState();
    adoptionProviderModel=Provider.of<AdoptionProviderModel>(context,listen: false);

  }

  @override
  Widget build(BuildContext context) {
    adoptionProviderModel=Provider.of<AdoptionProviderModel>(context,listen: true);
    return BaseScreen(
      showSettings: false,
      showBottomBar: false,
      showWhatsIcon: false,
      padding: EdgeInsets.zero,

      tag: "AdoptionScreen",
      body: Stack(
        alignment:AlignmentDirectional.topEnd ,
        children: [
          Container(
            height: 220.h,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                  image:NetworkImage(adoptionProviderModel!.animalPagerListModel!.data![widget.index].photo??""))
            ),
          ),
          _whiteContainer(),
          Container(
            margin: EdgeInsets.symmetric(vertical:40.h,horizontal: 10.w),
            padding: EdgeInsets.all(2.h),

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.white.withOpacity(0.5),

            ),
            child: IconButton(
              padding: EdgeInsets.zero,
              onPressed: (){
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_forward_ios,size: 20,),),)
        ],
      ),
    );
  }


  Widget _whiteContainer() {
    return Container(
      margin: EdgeInsets.only(top: 200.h),
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30)),
          color: Color(0xffF0F0F0),
          ),
      child: Column(
        children: [
          detailsCrd(),
          Container(
            width: double.infinity,
            padding:  EdgeInsets.symmetric(horizontal: 15.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 15.h,),
              Text(tr("alert"),style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w800),),
                SizedBox(height: 2.h,),
                Text(tr("adoption_alert_body"),style: TextStyle(height: 1.7,color: Color(0xff4d4d4d),fontSize: 13.sp,fontWeight: FontWeight.w400),)

              ],),
          ),
          SizedBox(height:13.h,),
          InkWell(
            onTap: (){
              AnimalData data=adoptionProviderModel!.animalPagerListModel!.data![widget.index];
            _callPhone(data.phone??"");
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical:11.5.h),
              margin: EdgeInsets.only(left: 25.w,right:25.w),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15),),
                color: C.BASE_BLUE,
              ),
              child: Center(child: Text(tr("contact_pet_owner"),style: TextStyle(color: Colors.white,fontSize: 14.sp,fontWeight: FontWeight.w800),),),),),
        ],
      ),
    );
  }
  Widget detailsCrd(){
    AnimalData data=adoptionProviderModel!.animalPagerListModel!.data![widget.index];
    return Container(
      height: 305.h,
      padding: EdgeInsets.only(top:5.h,bottom: 22.h,right: 20.w,left: 20.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(30),),
        color: Colors.white,
      ),

      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Text(data.name??"..........",textAlign: TextAlign.center,style: TextStyle(fontSize: 24.sp,fontWeight: FontWeight.w800),),
          SizedBox(height: 15.h,),
          _infoItem(tr("age"),data.age!),
          _infoItem(tr("gendar"),data.gender!),
          _infoItem(tr("type"),data.type!),
          _infoItem(tr("vaccation"),data.vaccination!),
          _infoItem(tr("city"),data.city!),
          _infoItem(tr("reason"),data.reasonToGiveUp!),
          _infoItem(tr("status"),data.healthStatus!),
          _infoItem(tr("condition"),data.conditions!),
          _infoItem(tr("add_date"),data.createdAt!=null?data.createdAt!.split("T")[0]:"......."),
        ],
      ),
    );
  }
  Widget _infoItem(String title,String content){
    return Container(
      padding: EdgeInsets.only(left: 5.w,right: 5.w,top:2.h,bottom: 2.h),
      margin: EdgeInsets.only(bottom: 3.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5),),
        color: Color(0xffF0F0F0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Text("${title}:  ",style: TextStyle(fontSize: 13.sp,fontWeight: FontWeight.w800),),
          Expanded(child: Text("${content}",style: TextStyle(fontSize: 13.sp,fontWeight: FontWeight.w500),)),
        ],),);
  }
  _callPhone(String phone)async{

    final Uri phoneCallUri = Uri(scheme: 'tel', path:phone);
    if (await canLaunch(phoneCallUri.toString())) {
      await launch(phoneCallUri.toString());
    } else {
      Fluttertoast.showToast(msg: tr("cant_call_number")+"\n$phone",backgroundColor: Colors.red,textColor: Colors.white,);

    }
  }

}
