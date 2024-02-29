import 'package:alefakaltawinea_animals_app/modules/cart/provider/cart_provider.dart';
import 'package:alefakaltawinea_animals_app/modules/login/login_screen.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/baseDimentions.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/constants.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/myColors.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/myUtils.dart';
import 'package:alefakaltawinea_animals_app/views/cards/BuyCard/steps/StepOne.dart';
import 'package:easy_localization/easy_localization.dart'hide TextDirection;
import 'package:flutter/Material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/shims/dart_ui_real.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:sprintf/sprintf.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../shared/components/text.dart';
import '../../list_screen/data/offer_model.dart';

class UseOfferBottomSheet extends StatefulWidget {
  final OfferModel offer;
  final bool? isOnline;
  final String? website;
  final Function(OfferModel offer) onUseOffer;
  const UseOfferBottomSheet({ this.website,this.isOnline,required this.offer,required this.onUseOffer,Key? key}) : super(key: key);

  @override
  State<UseOfferBottomSheet> createState() => _UseOfferBottomSheetState();
}

class _UseOfferBottomSheetState extends State<UseOfferBottomSheet> {

  late SheetsTypes selectedCard;
  @override
  void initState() {
    if(Constants.currentUser!=null&&context.read<CartProvider>().myCarts.isNotEmpty){
      selectedCard=SheetsTypes.first;
    }else if(Constants.currentUser!=null&&context.read<CartProvider>().myCarts.isEmpty){
      selectedCard=SheetsTypes.doNotHaveCard;
    }else if(Constants.currentUser==null){
      selectedCard=SheetsTypes.guest;
    }

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height:295.h,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 1.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,),
       child: Constants.currentUser==null?guest():context.read<CartProvider>().myCarts.isEmpty ?
      donthaveCarts():
      Column(children: [
        SizedBox(height: 15.h,),
        Text("${sprintf(tr("discount_value"),[discound()])}",style:TextStyle(color: C.BASE_BLUE,fontSize: 18.5.sp,fontWeight: FontWeight.w900),),
        SizedBox(height: 1.h,),
        Container(color: C.BASE_BLUE.withOpacity(0.2),width: D.default_150,height: 2.5,),
        SizedBox(height: 1.h,),
        Text("${sprintf(tr("discount_value"),[discound()])} ${tr("on")} ${widget.offer.title}",style:TextStyle(color: Color(0xff565556),fontSize: 13.sp,fontWeight: FontWeight.w200),),
        selectSheet()
      ],),
    );
  }
  Widget selectSheet(){
    switch(selectedCard){
      case SheetsTypes.first: return doYouWantTOUse();
      case SheetsTypes.close: return doYouWantTOClose();
      case SheetsTypes.offlineCode: return offlineCode();
      case SheetsTypes.onlineCode: return onlineCode();
      case SheetsTypes.guest: return offlineCode();
      default :return doYouWantTOUse();
    }
  }
  Widget doYouWantTOUse(){
    return Container(
      width: double.infinity,
      height: 160.h,
      margin: EdgeInsets.only(left: D.default_10,right: D.default_10,top:35.h,),
      padding: EdgeInsets.all(D.default_10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Color(0xffF2F2F2),),
      child: Column(children: [
        SizedBox(height: 13.h,),
        Text(tr("first_offer_sheet_title"),style:TextStyle(fontSize: 19.sp,fontWeight: FontWeight.w900),),
        SizedBox(height: 3.h,),
        Text(tr("second_offer_sheet_title"),style:TextStyle(color: Color(0xff565556),fontSize: D.h2,fontWeight: FontWeight.w200),),
        SizedBox(height: 4.h,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          InkWell(
            onTap: (){
              setState(() {
                if(widget.isOnline??false){
                  selectedCard=SheetsTypes.onlineCode;
              }else{
                selectedCard=SheetsTypes.offlineCode;
                }

              });
            },
              child: Container(
                width: 125.w,
                margin: EdgeInsets.symmetric(vertical:D.default_25,horizontal: D.default_8),
                padding: EdgeInsets.all(4.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: C.BASE_BLUE),
                  color: C.BASE_BLUE,),
                child: Text(tr("yes"),style: TextStyle(color: Colors.white,fontSize: 18.sp,fontWeight: FontWeight.w900),textAlign: TextAlign.center,),
              )),
          InkWell(
              onTap: (){
                setState(() {
                  selectedCard=SheetsTypes.close;
                });
              },
              child: Container(
                width: 125.w,
                margin: EdgeInsets.symmetric(vertical:D.default_25,horizontal: D.default_8),
                padding: EdgeInsets.all(4.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.black),
                  color: Colors.transparent,),
                child: Text(tr("no"),style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.w900),textAlign: TextAlign.center,),
              ))
        ],)

      ],),

    );
  }
  Widget doYouWantTOClose(){
    return Container(
      width: double.infinity,
      height: 160.h,
      margin: EdgeInsets.only(left: D.default_10,right: D.default_10,top:35.h,),
      padding: EdgeInsets.all(D.default_10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Color(0xffF2F2F2),),
      child: Column(children: [
        SizedBox(height: 13.h,),
        Text(tr("close_offer_sheet_title"),style:TextStyle(fontSize: 19.sp,fontWeight: FontWeight.w900),),
        SizedBox(height: 3.h,),
        Text(tr("close_offer_sheet_subtitle"),style:TextStyle(color: Color(0xff565556),fontSize: 14.sp,fontWeight: FontWeight.w200),),
        SizedBox(height: 3.h,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          InkWell(
              onTap: (){
                Navigator.pop(context);
              },
              child: Container(
                width: 125.w,
                margin: EdgeInsets.symmetric(vertical:D.default_25,horizontal: D.default_8),
                padding: EdgeInsets.all(4.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: C.BASE_BLUE),
                  color: C.BASE_BLUE,),
                child: Text(tr("yes"),style: TextStyle(color: Colors.white,fontSize: 18.sp,fontWeight: FontWeight.w900),textAlign: TextAlign.center,),
              )),
          InkWell(
              onTap: (){
                setState(() {
                  selectedCard=SheetsTypes.first;
                });
              },
              child: Container(
                width: 125.w,
                margin: EdgeInsets.symmetric(vertical:D.default_25,horizontal: D.default_8),
                padding: EdgeInsets.all(4.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.black),
                  color: Colors.transparent,),
                child: Text(tr("no"),style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.w900),textAlign: TextAlign.center,),
              ))
        ],)

      ],),

    );
  }
  Widget offlineCode(){
    return Container(
      margin: EdgeInsets.only(left: D.default_10,right: D.default_10,top:25.h,),
      width: double.infinity,
      child: Column(children: [
        Text("تم تفعيل العرض بنجاح",style:TextStyle(color:C.BASE_BLUE,fontSize: 20.sp,fontWeight: FontWeight.w900),),
        SizedBox(height: 4.h,),
        Container(
          padding: EdgeInsets.symmetric(vertical:1.5.h,horizontal: 20.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3),
            color: Color(0xff3B3735),),
          child: Text("${DateTime.now().toString().split(" ")[0]}  ${DateTime.now().toString().split(" ")[1].toString().split(".")[0]}",textAlign: TextAlign.center,style: TextStyle(fontSize: 11.sp,fontWeight: FontWeight.w700,color: Colors.white),),
        ),

        SizedBox(height: 21.h,),
        Text("وجه الشاشة للموظف\n لاكمال استخدام العرض",textAlign: TextAlign.center
          ,style:TextStyle(color: Color(0xff565556),fontSize: 19.sp,fontWeight: FontWeight.w500),),
        InkWell(
            onTap: (){
              widget.onUseOffer(widget.offer);
            },
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(vertical:11.h,),
              padding: EdgeInsets.all(7.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: C.BASE_BLUE),
                color: C.BASE_BLUE,),
              child: Text(tr("show_code"),style: TextStyle(color: Colors.white,fontSize: 20.sp,fontWeight: FontWeight.w900),textAlign: TextAlign.center,),
            ))

      ],),

    );
  }
  Widget guest(){
    return Column(
      children: [
        SizedBox(height: 44.h,),
        Text(tr("please_login"),style:TextStyle(color: C.BASE_BLUE,fontSize: 22.sp,fontWeight: FontWeight.w900),),
        SizedBox(height: 14.h,),
        Container(
        width: double.infinity,
        height: 160.h,
        margin: EdgeInsets.symmetric(vertical:D.default_25,horizontal: D.default_8),
        padding: EdgeInsets.all(D.default_10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Color(0xffF2F2F2),),
        child: Column(children: [
          SizedBox(height: 15.h,),
          Text(tr("login_to_complete"),textAlign: TextAlign.center,style:TextStyle(color: Color(0xff2A2A2A),fontSize: 18.sp,fontWeight: FontWeight.w500,height:1.6),),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            InkWell(
                onTap: (){
                  MyUtils.navigate(context, LoginScreen());
                },
                child: Container(
                  width: 130.w,
                  margin: EdgeInsets.symmetric(vertical:13.h,horizontal: D.default_8),
                  padding: EdgeInsets.all(5.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: C.BASE_BLUE),
                    color: C.BASE_BLUE,),
                  child: Text(tr("login_header"),style: TextStyle(color: Colors.white,fontSize: 17.sp,fontWeight: FontWeight.w900),textAlign: TextAlign.center,),
                )),
            InkWell(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Container(
                  width: 130.w,
                  margin: EdgeInsets.symmetric(vertical:13.h,horizontal: D.default_8),
                  padding: EdgeInsets.all(5.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.black),
                    color: Colors.white,),
                  child: Text(tr("cancel"),style: TextStyle(fontSize: 17.sp,fontWeight: FontWeight.w900),textAlign: TextAlign.center,),
                ))
          ],)

        ],),

      )],
    );
  }
  Widget donthaveCarts(){
    return Column(
      children: [
        SizedBox(height: 44.h,),
        Text(tr("please_create_cart"),style:TextStyle(color: C.BASE_BLUE,fontSize: 22.sp,fontWeight: FontWeight.w900),),
        SizedBox(height: 14.h,),
        Container(
          width: double.infinity,
          height: 160.h,
          margin: EdgeInsets.symmetric(vertical:D.default_25,horizontal: D.default_8),
          padding: EdgeInsets.all(D.default_10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Color(0xffF2F2F2),),
          child: Column(children: [
            SizedBox(height: 15.h,),
            Text(tr("please_create_cart_full"),textAlign:TextAlign.center ,style:TextStyle(color: Color(0xff2A2A2A),fontSize: 18.sp,fontWeight: FontWeight.w500,height:1.6),),
            SizedBox(height: 1.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              InkWell(
                  onTap: ()async{
                    if (Constants.APPLE_PAY_STATE) {
                      MyUtils.navigate(context, BuyCard());
                    } else {
                      await Fluttertoast.showToast(
                          msg: tr("Your request has been successfully received"));
                    }                  },
                  child: Container(
                    width: 130.w,
                    margin: EdgeInsets.symmetric(vertical:13.h,horizontal: D.default_8),
                    padding: EdgeInsets.all(5.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: C.BASE_BLUE),
                      color: C.BASE_BLUE,),
                    child: Text(tr("create_cart"),style: TextStyle(color: Colors.white,fontSize: D.h1,fontWeight: FontWeight.w900),textAlign: TextAlign.center,),
                  )),
              InkWell(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 130.w,
                    margin: EdgeInsets.symmetric(vertical:13.h,horizontal: D.default_8),
                    padding: EdgeInsets.all(5.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.black),
                      color: Colors.white,),
                    child: Text(tr("cancel"),style:TextStyle(fontSize: 17.sp,fontWeight: FontWeight.w900),textAlign: TextAlign.center,),
                  ))
            ],)

          ],),

        )],
    );
  }
  Widget onlineCode(){
    return Column(
      children: [
        SizedBox(height: 10.h,),
        Text(tr("offer_code"),style:TextStyle(color: Colors.black,fontSize: 17.sp,fontWeight: FontWeight.w800),),
        SizedBox(height: 20.h,),
        Directionality(
          textDirection: TextDirection.rtl,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 30.w,),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal:10.w,vertical:7.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topRight: Radius.circular(10),bottomRight: Radius.circular(10)),
                    color: Color(0xffF2F2F2),),
                  child: Text(widget.offer.code??"",textAlign: TextAlign.center,style:TextStyle(color: Colors.black,fontSize: 18.sp,fontWeight: FontWeight.w500,overflow:TextOverflow.ellipsis ),),),
              ),
            InkWell(
              onTap: ()async{
                await Clipboard.setData(new ClipboardData(text: widget.offer.code));
                await Fluttertoast.showToast(
                    backgroundColor: Color(0xffa4a4a4),
                    msg: tr("done_copy"));
              },
              child: Container(
                width: 100.w,
                padding: EdgeInsets.symmetric(horizontal:10.w,vertical:7.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10)),
                  color: C.BASE_BLUE,),
                child: Text(tr("copy",),textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 18.sp,fontWeight:FontWeight.w600)),),
            ),
              SizedBox(width: 30.w,),


            ],),
        ),

        SizedBox(height:55.h,),

        InkWell(
            onTap: (){
              _launchURLBrowser(widget.website??"");
              Fluttertoast.showToast(msg: widget.website??"",backgroundColor: Colors.red,textColor: Colors.white,);

            },
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(vertical:5.h,horizontal: 5.w),
              padding: EdgeInsets.all(10.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: C.BASE_BLUE),
                color: C.BASE_BLUE,),
              child: Text(tr("go_to_shop"),style: TextStyle(color: Colors.white,fontSize: 18.sp,fontWeight: FontWeight.w500),textAlign: TextAlign.center,),
            )),
        SizedBox(height: 3.h,),
      ],
    );
  }

  _launchURLBrowser(String link) async {
    if (await canLaunch(link)) {
      await launch(link);
    } else {
      Fluttertoast.showToast(msg: tr("cant_opn_url"),backgroundColor: Colors.red,textColor: Colors.white,);
    }
  }
  String discound(){
    double price=double.parse(widget.offer.price??'0');
    double discount=double.parse(widget.offer.discountValue??'0');
    String iintValue=(((price-discount)/price)*100).toString();
    //String iintValue=((double.parse(widget.offer.discountValue??'0')/double.parse(widget.offer.price??'0'))*100).toString();
    return iintValue.split(".")[0]+"."+(iintValue.split(".")[1].length>1?iintValue.split(".")[1].substring(0,1):"0") ;
}


}
enum SheetsTypes{
  first,
  offlineCode,
  close,
  onlineCode,
  guest,
  doNotHaveCard
}
