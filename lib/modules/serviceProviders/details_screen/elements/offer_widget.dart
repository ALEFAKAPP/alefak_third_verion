import 'package:alefakaltawinea_animals_app/modules/serviceProviders/list_screen/data/offer_model.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/baseDimentions.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/baseTextStyle.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/constants.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/myColors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/Material.dart';
import 'package:flutter/cupertino.dart';

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
      margin: EdgeInsets.symmetric(vertical: D.default_2,horizontal: D.default_20),
      padding: EdgeInsets.symmetric(vertical: D.default_10,horizontal: D.default_10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        color: Colors.grey.withOpacity(0.09),),
      child:InkWell(
        onTap: (){
          widget.onSelect(widget.offer);
        },
        child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        SizedBox(width: D.default_10,),
        Icon(widget.isSelected?Icons.radio_button_checked:Icons.radio_button_off,
          color: widget.isSelected?C.BASE_BLUE:Colors.grey,),
        SizedBox(width: D.default_10,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Text(widget.offer.title??"",style: TextStyle(fontSize: D.h2,fontWeight: FontWeight.w800),),
            SizedBox(height: D.default_5,),
            Visibility(
              visible:(widget.offer.description_ar??"").isNotEmpty&&widget.isSelected,
                child: Text(Constants.utilsProviderModel!.isArabic?(widget.offer.description_ar??""):(widget.offer.description_en??""),style: TextStyle(color: Color(0xFF565656),fontSize: D.h2,fontWeight: FontWeight.w400),)),
            SizedBox(height: D.default_5,),
            Visibility(visible: widget.isSelected,child: Text("${tr("num_of_use")} ${widget.offer.usageTimes??""}",style: TextStyle(fontSize: D.h2*0.9,fontWeight: FontWeight.w500),)),

          ],),
        )


    ],),
      ),);
  }

}
