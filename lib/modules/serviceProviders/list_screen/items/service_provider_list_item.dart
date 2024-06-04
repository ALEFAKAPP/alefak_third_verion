import 'package:alefakaltawinea_animals_app/modules/serviceProviders/details_screen/new_service_provider_details_screen.dart';
import 'package:alefakaltawinea_animals_app/modules/serviceProviders/details_screen/service_provider_details_screen.dart';
import 'package:alefakaltawinea_animals_app/modules/serviceProviders/list_screen/provider/sevice_providers_provicer_model.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/baseDimentions.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/baseTextStyle.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/myColors.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/myUtils.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/my_fonts.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/resources.dart';
import 'package:alefakaltawinea_animals_app/utils/my_widgets/transition_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ServiceProviderListItem extends StatefulWidget {
  int index;
  ServiceProvidersProviderModel? serviceProvidersProviderModel;

   ServiceProviderListItem(this.index,this.serviceProvidersProviderModel);

  @override
  _ServiceProviderListItemState createState() => _ServiceProviderListItemState();
}

class _ServiceProviderListItemState extends State<ServiceProviderListItem> {

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        MyUtils.navigate(context, NewServiceProviderDetailsScreen(widget.serviceProvidersProviderModel!.serviceProviderModel!.data![widget.index]));
      },
    child: Container(
      margin: EdgeInsets.all(5.h),
      height:195.h,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(D.default_10),
          color: Colors.white,
          boxShadow:[BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius:5,
              spreadRadius:5
          )]
      ),
      child: Stack(children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Expanded(child:
          Container(
          padding: EdgeInsets.all(D.default_10),
      decoration: BoxDecoration(
        image: DecorationImage(image: NetworkImage(widget.serviceProvidersProviderModel!.serviceProviderModel!.data![widget.index].bannerPhoto??"",
        ),fit:BoxFit.cover),
        borderRadius: BorderRadius.only(topLeft: Radius.circular(D.default_10),topRight: Radius.circular(D.default_10)),
        color: Colors.grey.withOpacity(0.2),
      ),)),
          SizedBox(height:10.h,),
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(left:10.w,right:10.w,),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(D.default_10),bottomRight: Radius.circular(D.default_10)),
              color: Colors.white,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(child: Text(
                  widget.serviceProvidersProviderModel!.serviceProviderModel!.data![widget.index].name??''
                  ,style: TextStyle(fontWeight: FontWeight.w800,fontSize: 13.5.sp)),),
                InkWell(
                  onTap: (){
                    widget.serviceProvidersProviderModel!.setFav(widget.serviceProvidersProviderModel!.serviceProviderModel!.data![widget.index].id!);
                     setState(() {
                       fav_icon=Res.IC_FAV_BLUE;
                     });
                    },
                  child: TransitionImage(
                    widget.serviceProvidersProviderModel!.serviceProviderModel!.data![widget.index].is_fav==0?
                  fav_icon:Res.IC_FAV_BLUE,
                  height: D.default_20,
                  width: D.default_20,
                ),)

              ],),
          ),
          SizedBox(height: 10.h,),
        ],),
        Positioned(child: Container(
          padding: EdgeInsets.all(D.default_5),
          margin: EdgeInsets.all(10.h),
          width: 50.h,
          height: 50.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(D.default_10),
              color: Colors.white,
              boxShadow:[BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  offset:Offset(0,0),
                  blurRadius:1,
                  spreadRadius: 1
              )]
          ),
          child:TransitionImage(
            widget.serviceProvidersProviderModel!.serviceProviderModel!.data![widget.index].photo!,
            radius: D.default_10,
            fit: BoxFit.cover,
            width: double.infinity,
          ) ,
        ),),
      ],),
    ),);
  }
  String fav_icon= Res.IC_FAV_GREY;

}
