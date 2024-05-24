import 'package:alefakaltawinea_animals_app/modules/search/provider/filter_type_enum.dart';
import 'package:alefakaltawinea_animals_app/modules/search/provider/search_provider.dart';
import 'package:alefakaltawinea_animals_app/modules/search/view/screens/new_search_screen.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/providers.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/Material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../baseScreen/baseScreen.dart';
import '../items/search_filter_item.dart';

class SearchFiltersListScreen extends StatefulWidget {
  const SearchFiltersListScreen({Key? key}) : super(key: key);

  @override
  State<SearchFiltersListScreen> createState() => _SearchFiltersListScreenState();
}

class _SearchFiltersListScreenState extends State<SearchFiltersListScreen> {
  @override
  void initState() {
    context.read<SearchProvider>().allSelectedFilters.clear();
    context.read<SearchProvider>().getAllCities();
    context.read<SearchProvider>().getAnimalsTypes();
    context.read<SearchProvider>().getServiceClassifications();
    context.read<SearchProvider>().getAllClinics();

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
        tag: "SearchScreen",
        showBottomBar: false,
        showSettings: false,
        showWhatsIcon: false,
        body:Column(children: [
          SizedBox(height: 8.h,),
          _header(),
          SizedBox(height: 10.h,),
          _devider(),
          Expanded(child:  ListView(
            addAutomaticKeepAlives: true,
                padding: EdgeInsets.zero,
                children: [
                  Consumer<SearchProvider>(
                      builder: (context, data,_) {
                        return Visibility(
                      visible:data.allCities.isNotEmpty ,
                      child: SearchFilterItem(
                        model: SearchFilterTypModel(
                            isExpanded: data.isCityExpanded, items: List.generate(data.allCities.length, (itemIndex){
                              return SearchFilterItemModel(
                                type: FiltersTypes.CITY,
                                id:data.allCities[itemIndex].id??-1 ,
                                  isSelected: data.allSelectedFilters.where((element) => (element.type==FiltersTypes.CITY&&element.id==(data.allCities[itemIndex].id??-1))).isNotEmpty,
                                  title: data.allCities[itemIndex].name??'');
                        }), title:tr('city')), onSelect: (SearchFilterTypModel model) {
                        data.isCityExpanded=model.isExpanded;
                        for(SearchFilterItemModel itemModel in model.items){
                          if(itemModel.isSelected){
                            if(data.allSelectedFilters.where((element) => element.id==itemModel.id).isEmpty){
                              data.allSelectedFilters.add(itemModel);
                            }
                          }else{
                              data.allSelectedFilters.removeWhere((element) => element.id==itemModel.id);

                          }

                        }

                        data.notifyListeners();

                      },),
                    );
                  }
                ),
                  _devider(),
                  Consumer<SearchProvider>(
                      builder: (context, data,_) {
                        return Visibility(
                          visible:data.animalsTypes.isNotEmpty ,
                          child: SearchFilterItem(
                            model: SearchFilterTypModel(
                                isExpanded: data.isTypeExpanded, items: List.generate(data.animalsTypes.length, (itemIndex){
                              return SearchFilterItemModel(
                                type: FiltersTypes.ANiMAL_TYPE,
                                  id:data.animalsTypes[itemIndex].id??-1 ,
                                  isSelected: data.allSelectedFilters.where((element) => (element.type==FiltersTypes.ANiMAL_TYPE&&element.id==(data.animalsTypes[itemIndex].id??-1))).isNotEmpty,
                                  title: data.animalsTypes[itemIndex].name??'');
                            }), title:tr('animal_type')), onSelect: (SearchFilterTypModel model) {
                            data.isTypeExpanded=model.isExpanded;

                            for(SearchFilterItemModel itemModel in model.items){
                              if(itemModel.isSelected){
                                if(data.allSelectedFilters.where((element) => element.id==itemModel.id).isEmpty){
                                  data.allSelectedFilters.add(itemModel);
                                }
                              }else{
                                data.allSelectedFilters.removeWhere((element) => element.id==itemModel.id);

                              }

                            }
                            data.notifyListeners();

                          },),
                        );
                      }
                  ),
                  _devider(),
                  Consumer<SearchProvider>(
                      builder: (context, data,_) {
                        return Visibility(
                          visible:data.allClinics.isNotEmpty ,
                          child: SearchFilterItem(
                            model: SearchFilterTypModel(
                                isExpanded: data.isClinicExpanded, items: List.generate(data.allClinics.length, (itemIndex){
                              return SearchFilterItemModel(
                                type: FiltersTypes.CLINIC,
                                  id:data.allClinics[itemIndex].id??-1 ,
                                  isSelected: data.allSelectedFilters.where((element) => (element.type==FiltersTypes.CLINIC&&element.id==(data.allClinics[itemIndex].id??-1))).isNotEmpty,
                                  title: data.allClinics[itemIndex].username??'');
                            }), title:tr('clinics')), onSelect: (SearchFilterTypModel model) {
                              data.isClinicExpanded=model.isExpanded;
                              for(SearchFilterItemModel itemModel in model.items){
                                if(itemModel.isSelected){
                                  if(data.allSelectedFilters.where((element) => element.id==itemModel.id).isEmpty){
                                    data.allSelectedFilters.add(itemModel);
                                  }
                                }else{
                                  data.allSelectedFilters.removeWhere((element) => element.id==itemModel.id);

                                }

                              }
                            data.notifyListeners();
                          },),
                        );
                      }
                  ),
                  _devider(),
                  Consumer<SearchProvider>(
                      builder: (context, data,_) {
                        return Visibility(
                          visible:data.serviceClassifications.isNotEmpty ,
                          child: SearchFilterItem(
                            model: SearchFilterTypModel(
                                isExpanded: data.isClassificationExpanded, items: List.generate(data.serviceClassifications.length, (itemIndex){
                              return SearchFilterItemModel(
                                type: FiltersTypes.CLASSIFICATION,
                                  id:data.serviceClassifications[itemIndex].id??-1 ,
                                  isSelected:  data.allSelectedFilters.where((element) => (element.type==FiltersTypes.CLASSIFICATION&&element.id==(data.serviceClassifications[itemIndex].id??-1))).isNotEmpty,
                                  title: data.serviceClassifications[itemIndex].name??'');
                            }), title:tr('services_types')), onSelect: (SearchFilterTypModel model) {
                            data.isClassificationExpanded =model.isExpanded;
                            for(SearchFilterItemModel itemModel in model.items){
                              if(itemModel.isSelected){
                                if(data.allSelectedFilters.where((element) => element.id==itemModel.id).isEmpty){
                                  data.allSelectedFilters.add(itemModel);
                                }
                              }else{
                                data.allSelectedFilters.removeWhere((element) => element.id==itemModel.id);

                              }

                            }
                              data.notifyListeners();
                          },),
                        );
                      }
                  ),
                  _devider(),

        ],),),
          SizedBox(height: 5.h,),
          _showResultsButton(),
          SizedBox(height: 10.h,),

        ],)
    );
  }
  Widget _devider(){
    return Container(
      height: 1,
      width: double.infinity,
      color: Color(0xae6f6f6f),
    );
  }

  Widget _header(){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w,vertical:5.h),
      child: Consumer<SearchProvider>(
        builder: (context,data,_) {
          return Row(
            mainAxisAlignment:MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: (){Get.back();},
                child: Icon(Icons.arrow_back_ios,
                  size: 18,
                ),
              ),
              GestureDetector(
                onTap: (){
                  if(context.read<SearchProvider>().isButtonActive){
                    context.read<SearchProvider>().allSelectedFilters.clear();
                    context.read<SearchProvider>().notifyListeners();
                  }
                },
                  child: Text(tr('reset'),style: TextStyle(color: context.read<SearchProvider>().isButtonActive?Colors.black:Color(0xffABABAB),fontSize: 16.sp,fontWeight: FontWeight.w800),))
          ],);
        }
      ),
    );

  }
  Widget _showResultsButton(){
    return GestureDetector(
      onTap: (){
        Get.to(NewSearchScreen())!.then((value){
          context.read<SearchProvider>().notifyListeners();
        });
      },
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10.h,horizontal: 15.w),
          margin: EdgeInsets.symmetric(horizontal: 20.w),
          color:Color(0xff231F20) ,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            Text(tr('show_result_title'),style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.w500,color: Colors.white),),
            SvgPicture.asset('assets/images/show_search_result_ic.svg',matchTextDirection: false,)
          ],),
        ),
      ),
    );
  }



}
