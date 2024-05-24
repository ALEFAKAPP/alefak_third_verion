import 'package:alefakaltawinea_animals_app/modules/offers/offer_details/offer_code_screen.dart';
import 'package:alefakaltawinea_animals_app/modules/serviceProviders/details_screen/elements/use_offer_bottom_sheet.dart';
import 'package:alefakaltawinea_animals_app/modules/serviceProviders/list_screen/data/getServiceProvidersApi.dart';
import 'package:alefakaltawinea_animals_app/modules/serviceProviders/list_screen/data/offer_model.dart';
import 'package:alefakaltawinea_animals_app/modules/serviceProviders/list_screen/data/serviceProvidersModel.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/baseDimentions.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/myColors.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/myUtils.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ServiceProviderDetailsProvider with ChangeNotifier{
int selectedOfferIndex=0;
late OfferModel selectedOffer;
late Data serviceProviderData;
bool isLoading=false;
setIsLoading(bool value){
   isLoading=value;
   notifyListeners();
}

ScrollController offersController=ScrollController();
onSelectOffer(OfferModel value,int index){
   selectedOffer=value;
   selectedOfferIndex=index;
   notifyListeners();
}
showBottomSheet(BuildContext context){
   showModalBottomSheet(
      backgroundColor: Colors.transparent,
       context: context, builder: (BuildContext context) {
      return Column(
         mainAxisAlignment: MainAxisAlignment.end,
         children: [
            UseOfferBottomSheet(website: serviceProviderData.website??"",isOnline:(serviceProviderData.isOnline??"0")=="1",offer: selectedOffer,onUseOffer: (offer){
               MyUtils.navigate(context, OfferCodeScreen(serviceProviderData,offer));
            },)

      ],);
   });
}

void scrollToIndex() {
   Future.delayed(const Duration(milliseconds: 500)).then((value) {
      offersController.animateTo((selectedOfferIndex.toDouble()) * 53.h, duration: const Duration(milliseconds: 10), curve: Curves.easeInOut);

   });
}
getShop(int shopId)async{
   setIsLoading(true);
   final respons=await GetServiceProvidersApi().getShop(shopId);
   serviceProviderData=respons.data;
   setIsLoading(false);

}
}
