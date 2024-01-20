import 'package:alefakaltawinea_animals_app/modules/categories_screen/data/home_offers_model.dart';
import 'package:alefakaltawinea_animals_app/modules/serviceProviders/list_screen/data/getServiceProvidersApi.dart';
import 'package:flutter/cupertino.dart';

class HomeOffersProvider with ChangeNotifier{
  bool isLoading=false;
  List<OfferElement> offers=[];
  getALLOffers(int id)async{
    isLoading=true;
    notifyListeners();
    await GetServiceProvidersApi().getHomeOffersById(id).then((value){
      HomeListOfOffersModel homeListOfOffersModel=value.data;
      offers.clear();
      offers.addAll(homeListOfOffersModel.offers);
      isLoading=false;
      notifyListeners();
    });


  }
}