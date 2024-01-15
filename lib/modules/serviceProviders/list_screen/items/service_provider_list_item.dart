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
  Color? color;
  ServiceProvidersProviderModel? serviceProvidersProviderModel;

   ServiceProviderListItem(this.index,this.serviceProvidersProviderModel,{this.color=C.BASE_BLUE});

  @override
  _ServiceProviderListItemState createState() => _ServiceProviderListItemState();
}

class _ServiceProviderListItemState extends State<ServiceProviderListItem> {

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        MyUtils.navigate(context, ServiceProviderDetailsScreen(widget.serviceProvidersProviderModel!.serviceProviderModel!.data![widget.index]));
      },
    child: Container(
      margin: EdgeInsets.all(D.default_10),
      height: D.default_230,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(D.default_10),
          color: Colors.white,
          boxShadow:[BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius:3,
              spreadRadius:2
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
        image: DecorationImage(image: NetworkImage(widget.serviceProvidersProviderModel!.serviceProviderModel!.data![widget.index].bannerPhoto!,
        ),fit:BoxFit.cover),
        borderRadius: BorderRadius.only(topLeft: Radius.circular(D.default_10),topRight: Radius.circular(D.default_10)),
        color: Colors.white,
      ),)),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal:D.default_10,vertical:D.default_10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(D.default_10),bottomRight: Radius.circular(D.default_10)),
              color: Colors.white,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(child: Text(
                  widget.serviceProvidersProviderModel!.serviceProviderModel!.data![widget.index].name!
                  ,style: TextStyle(fontFamily: MyFonts.VazirBlack,fontWeight: FontWeight.w700,fontSize: 12.sp)),),
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
          Padding(
            padding: EdgeInsets.symmetric(horizontal: D.default_10),
            child: Text(
                widget.serviceProvidersProviderModel!.serviceProviderModel!.data![widget.index].offers![0].title??''
                ,style: TextStyle(color: Colors.grey[600],fontFamily: MyFonts.VazirBlack,fontWeight: FontWeight.w700,fontSize: 10.sp)),
          ),
          SizedBox(height: 10.h,),
        ],),
        Positioned(child: Container(
          padding: EdgeInsets.all(D.default_5),
          margin: EdgeInsets.all(D.default_10),
          width: D.default_60,
          height: D.default_60,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(D.default_10),
              color: Colors.white,
              boxShadow:[BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  offset:Offset(4,4),
                  blurRadius:4,
                  spreadRadius: 2
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
