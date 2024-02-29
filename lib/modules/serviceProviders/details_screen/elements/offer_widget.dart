import 'package:alefakaltawinea_animals_app/modules/serviceProviders/list_screen/data/offer_model.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/baseDimentions.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/baseTextStyle.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/constants.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/myColors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/Material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewOfferWidget extends StatefulWidget {
  final OfferModel offer;
  final bool isSelected;
  final Function(OfferModel selectedOffer) onSelect;
  const NewOfferWidget({
    required this.offer,
    required this.onSelect,
    required this.isSelected,
    Key? key}) : super(key: key);

  @override
  State<NewOfferWidget> createState() => _NewOfferWidgetState();
}

class _NewOfferWidgetState extends State<NewOfferWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.h,horizontal: D.default_20),
      padding: EdgeInsets.only(top: 12.h,bottom:2.h,left: D.default_10,right: D.default_10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        color: Color(0x9df0f0f0),),
      child:InkWell(
        onTap: (){
          widget.onSelect(widget.offer);
        },
        child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        SizedBox(width: D.default_10,),
        Icon(widget.isSelected?Icons.radio_button_checked:Icons.radio_button_off,
          color: widget.isSelected?C.BASE_BLUE:Colors.grey,size: 22,),
        SizedBox(width: 20.w,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Text(widget.offer.title??"",style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w800),),
            SizedBox(height: D.default_5,),
            Visibility(
              visible:(widget.offer.description_ar??"").isNotEmpty&&widget.isSelected,
                child: Text(Constants.utilsProviderModel!.isArabic?(widget.offer.description_ar??""):(widget.offer.description_en??""),style: TextStyle(color: Color(0xFF565656),fontSize: 13.5.sp,fontWeight: FontWeight.w400),)),
            SizedBox(height: 6.h,),
            Visibility(visible: widget.isSelected,child: Text("${tr("num_of_use")} ${(widget.offer.usageTimes??"")=="55555"?tr("unlimited"):(widget.offer.usageTimes??"")}",style: TextStyle(fontSize: 13.5.sp,fontWeight: FontWeight.w100),)),

          ],),
        )


    ],),
      ),);
  }

}
