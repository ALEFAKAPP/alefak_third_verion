import 'package:alefakaltawinea_animals_app/modules/baseScreen/baseScreen.dart';
import 'package:alefakaltawinea_animals_app/modules/serviceProviders/list_screen/data/serviceProvidersModel.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/myColors.dart';
import 'package:alefakaltawinea_animals_app/utils/my_widgets/transition_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/Material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../utils/my_utils/myUtils.dart';
import '../../../utils/my_widgets/video_player.dart';
import '../../offers/offer_details/offer_code_screen.dart';
import '../list_screen/data/offer_model.dart';
import 'elements/use_offer_bottom_sheet.dart';

class NewOfferDetailsScreen extends StatefulWidget {
  final Data serviceProvider;
  final OfferModel offer;
  final String category;
  const NewOfferDetailsScreen({required this.category,required this.offer,required this.serviceProvider,Key? key}) : super(key: key);

  @override
  State<NewOfferDetailsScreen> createState() => _NewOfferDetailsScreenState();
}

class _NewOfferDetailsScreenState extends State<NewOfferDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body:
    Column(
      children: [
        Container(
          height: 220.h,
          width: double.infinity,
          child: Stack(
            children:[
              Container(
                  width:double.infinity,
                  color: Colors.grey[200],
                  child:TransitionImage((widget.offer.photo??"").isNotEmpty?(widget.offer.photo??"").contains("https://alefak.com/uploads/")?(widget.offer.photo??""):"https://alefak.com/uploads/"+(widget.offer.photo??"")
                      :(widget.serviceProvider.bannerPhoto??'').contains("https://alefak.com/uploads/")?(widget.serviceProvider.bannerPhoto??''):"https://alefak.com/uploads/"+(widget.serviceProvider.bannerPhoto??''),
                  height: 220.h,
                  fit: BoxFit.cover
                    ,)
              ),
              Row(
                mainAxisAlignment:MainAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical:40.h,horizontal: 10.w),
                    padding: EdgeInsets.all(2.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.white.withOpacity(0.8),

                    ),
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_forward_ios,size: 20,),),)
                ],)

            ] ,
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(top: 6.h,bottom: 6.h
                ),
                width: double.infinity,
                color: C.BASE_BLUE,
                child: Text(widget.category,textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 18.sp,fontWeight: FontWeight.w800),),
              ),
              Row(
                mainAxisAlignment:MainAxisAlignment.start,
                children: [
                  SizedBox(width:10.w,),
                  Container(
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.all(10.h),
                    width: 50.h,
                    height: 50.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow:[BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            offset:Offset(0,0),
                            blurRadius:3,
                            spreadRadius: 2
                        )]
                    ),
                    child:TransitionImage(
                      (widget.serviceProvider.photo??'').contains("https://alefak.com/uploads/")?(widget.serviceProvider.photo??''):"https://alefak.com/uploads/"+(widget.serviceProvider.photo??''),
                      radius:10,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ) ,
                  ),
                  SizedBox(width:5.w,),
                  Expanded(child: Text(widget.serviceProvider.name??'',style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w800),)),
                  SizedBox(width:5.w,)
                ],),
              _devider(),

              Padding(
                padding: EdgeInsets.symmetric(vertical:10.h,horizontal: 20.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _tab(tr('Terms_and_Conditions'),"assets/images/terms_conditions_ic.png",(){
                      showBottomSheet(context);
                    }),
                    _tab(tr('location'),"assets/images/offer_location_ic.png",(){
                      _launchMapsUrl(double.parse((widget.serviceProvider.latitude??'0')),double.parse((widget.serviceProvider.longitude??'0')));
                    }),
                    _tab(tr('how_to_use_offer'),"assets/images/how_to_use_ic.png",(){
                      showVideoBottomSheet(context);
                    }),
                  ],),
              ),
              _devider(),
              SizedBox(height: 30.h,),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Text(widget.offer.title??"",style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.w800),)),
              SizedBox(height: 10.h,),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Text(widget.offer.description_ar??"",style: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.w500),)),
              SizedBox(height: 10.h,),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Text("${tr("السعر")} ${double.parse(widget.offer.discountValue??'0')} ${"ريال"} بدلا من ${double.parse(widget.offer.price??'0')} (وفر ${double.parse(widget.offer.price??'0')-double.parse(widget.offer.discountValue??'0')} ريال ) ",style: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.w500),)),

              Expanded(child: SizedBox()),
              GestureDetector(
                onTap: (){showOfferBottomSheet(context);},
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.w),
                  padding: EdgeInsets.symmetric(vertical: 12.h,horizontal: 50.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: C.BASE_BLUE,),
                  width:  double.infinity,child: Text(tr("use_offer"),textAlign: TextAlign.center,style: TextStyle(color:Colors.white,fontSize: 18.sp,fontWeight: FontWeight.w800),),),
              ),
              SizedBox(height: 50.h,),


            ],
          ),
        ),
      ],
    ),);
  }
  Widget _tab(String title,String image,Function onClick){

    return GestureDetector(
      onTap: (){onClick();},
      child: Column(children: [

        Image.asset(image,width: 20.w,height: 20.w,),
        SizedBox(height: 5.h,),
        Text(title,style: TextStyle(fontSize: 12.sp),)
      ],),
    );
  }
  Widget _devider(){
    return Container(
      height: 1,
      width: double.infinity,
      color: Color(0xae6f6f6f).withOpacity(0.2),
    );
  }
  showBottomSheet(BuildContext context){
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context, builder: (BuildContext context) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            margin:EdgeInsets.symmetric(horizontal:110.w,vertical: 10.h ),
            width: double.infinity,height: 4,color:Colors.white.withOpacity(0.4),),
          Container(
            height:295.h,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 1.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white,),
            child:
            Column(children: [
              SizedBox(height: 10.h,),
              Padding(
                padding:  EdgeInsets.symmetric(vertical:10.h,horizontal: 10.w),
                child: Row(children: [
                  Image.asset("assets/images/terms_conditions_ic.png",width: 25.w,height: 25.w,),
                  SizedBox(width: 5.h,),
                  Text(tr("Terms_and_Conditions"),style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w800),),
                  Expanded(child: SizedBox()),
                  GestureDetector(
                    onTap: (){
                      Get.back();
                    },
                      child: Icon(Icons.cancel,color: Colors.grey,size: 25.w,))
                ],),
              ),
              _devider(),
              SizedBox(height: 10.h,),
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(vertical: 10.h,horizontal: 10.w),
                  itemCount: (widget.offer.features??[]).length,
                  separatorBuilder: (_,index){return SizedBox(height: 5.h);},
                  itemBuilder: (_,index){
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      Icon(Icons.circle,size: 10.w,),
                      SizedBox(width: 5.w,),
                      Expanded(child: Text("${widget.offer.features![index].ar}"
                        ,style: TextStyle(fontWeight: FontWeight.w600,fontSize:12.sp),))
                    ],);
                  },),
              )
            ],),
          )

        ],);
    });
  }
  showVideoBottomSheet(BuildContext context){
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context, builder: (BuildContext context) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            margin:EdgeInsets.symmetric(horizontal:110.w,vertical: 10.h ),
            width: double.infinity,height: 4,color:Colors.white.withOpacity(0.4),),
          Container(
            height:350.h,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 1.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white,),
            child:
            Column(children: [
              SizedBox(height: 10.h,),
              Padding(
                padding:  EdgeInsets.symmetric(vertical:10.h,horizontal: 10.w),
                child: Row(children: [
                  Image.asset("assets/images/how_to_use_ic.png",width: 25.w,height: 25.w,),
                  SizedBox(width: 5.h,),
                  Text(tr("how_to_use_offer"),style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w800),),
                  Expanded(child: SizedBox()),
                  GestureDetector(
                      onTap: (){
                        Get.back();
                      },
                      child: Icon(Icons.cancel,color: Colors.grey,size: 25.w,))
                ],),
              ),
              _devider(),
              SizedBox(height: 10.h,),
              Expanded(
                child:Container(
                  color: Colors.black,
                  child: VideoApp(),),
              )
            ],),
          )

        ],);
    });
  }
  void _launchMapsUrl(double lat, double lon) async {
    final url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lon';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Fluttertoast.showToast(msg: tr("cant_opn_url"),backgroundColor: Colors.red,textColor: Colors.white,);

    }
  }
  showOfferBottomSheet(BuildContext context){
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context, builder: (BuildContext context) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          UseOfferBottomSheet(website: widget.serviceProvider.website??"",isOnline:(widget.serviceProvider.isOnline??"0")=="1",offer: widget.offer,onUseOffer: (offer){
            MyUtils.navigate(context, OfferCodeScreen(widget.serviceProvider,offer));
          },)

        ],);
    });
  }
}
