import 'package:alefakaltawinea_animals_app/modules/search/data/search_api.dart';
import 'package:alefakaltawinea_animals_app/modules/search/model/clinic_model.dart';
import 'package:alefakaltawinea_animals_app/modules/search/view/items/search_filter_item.dart';
import 'package:alefakaltawinea_animals_app/modules/serviceProviders/list_screen/data/serviceProvidersModel.dart';
import 'package:alefakaltawinea_animals_app/modules/spalshScreen/data/regions_model.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/constants.dart';
import 'package:flutter/material.dart';

import '../model/animal_type_model.dart';
import 'filter_type_enum.dart';

class SearchProvider with ChangeNotifier{
  List<RegionsModel> allCities=[];
  List<AimalTypeModel>animalsTypes=[];
  List<AimalTypeModel>serviceClassifications=[];
  List<ClinicModel> allClinics=[];
  List<SearchFilterItemModel>allSelectedFilters=[];
  ServiceProviderModel? searchResult;
  bool get isButtonActive =>allSelectedFilters.isNotEmpty;
  bool isCityExpanded=false;
  bool isTypeExpanded=false;
  bool isClinicExpanded=false;
  bool isClassificationExpanded=false;
  bool isNearToYouActive=false;
  bool isLoading=true;
  setIsLoading(bool value){
    isLoading=value;
    notifyListeners();
  }




  init(){
    allCities.clear();
  }
  getAllCities()async{
    allCities.clear();
    final response=await SearchApi().getCities();
    allCities.addAll(response.data??[]);
    notifyListeners();
  }
  getAllClinics()async{
    allClinics.clear();
    final response=await SearchApi().getAllClinics();
    List<ClinicModel> clinics=response.data;
    allClinics.addAll(clinics);
    notifyListeners();
  }
  onShowAll(){
    allSelectedFilters.clear();
    notifyListeners();
    getSearchData();
  }

  getAnimalsTypes()async{
    animalsTypes.clear();
    final response=await SearchApi().getAnimalsTypes();
    animalsTypes.addAll(response.data??[]);
    notifyListeners();
  }
  getServiceClassifications()async{
    serviceClassifications.clear();
    final response=await SearchApi().getServiceClassifications();
    serviceClassifications.addAll(response.data??[]);
    notifyListeners();
  }
  getSearchData()async {
    searchResult=null;
    setIsLoading(true);
    final response=await SearchApi().getSearchData(getFiltersMap(),1);
    searchResult=response.data;
    for(int i=1;i<(searchResult!.lastPage??0);i++){
      final response2=await SearchApi().getSearchData(getFiltersMap(),i+1);
      ServiceProviderModel data=response2.data;
      searchResult!.data!.addAll(data.data??[]);
    }
    setIsLoading(false);
  }
  Map<String,dynamic> getFiltersMap(){
    Map<FiltersTypes,List<SearchFilterItemModel>>filters={};
    Map<String,dynamic>body={"category_id":1};

    if(isNearToYouActive&&Constants.currentUser!=null){
      body["is_nearest"]=1;
      body["latitude"]=Constants.currentUser!.latitude;
      body["longitude"]=Constants.currentUser!.longitude;
    }
    ///sort filters by type
    for(SearchFilterItemModel filterModel in allSelectedFilters){
      if(filters[filterModel.type]==null){filters[filterModel.type]=[];}
      filters[filterModel.type]!.add(filterModel);
    }
    /// set multi select filters
    filters.forEach((key, value) {
      if(key==FiltersTypes.CITY){
        for(int i=0;i<value.length;i++){
          body["state_id[$i]"]=value[i].id;
        }
      }
      if(key==FiltersTypes.CLASSIFICATION){
        for(int i=0;i<value.length;i++){
          body["classification_id[$i]"]=value[i].id;
        }
      }
      if(key==FiltersTypes.CLINIC){
        for(int i=0;i<value.length;i++){
          body["shop_id[$i]"]=value[i].id;
        }
      }
      if(key==FiltersTypes.ANiMAL_TYPE){
        for(int i=0;i<value.length;i++){
          body["tag_id[$i]"]=value[i].id;
        }
      }

    });

    return body;
  }
}