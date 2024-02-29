import 'package:alefakaltawinea_animals_app/core/servies/firebase/analytics_helper.dart';
import 'package:alefakaltawinea_animals_app/modules/adoption/provider/adoption_provider_model.dart';
import 'package:alefakaltawinea_animals_app/modules/baseScreen/baseScreen.dart';
import 'package:alefakaltawinea_animals_app/modules/profile/no_profile_screen.dart';
import 'package:alefakaltawinea_animals_app/shared/components/dialog.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/baseDimentions.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/baseTextStyle.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/constants.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/myColors.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/myUtils.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/resources.dart';
import 'package:alefakaltawinea_animals_app/utils/my_widgets/action_bar_widget.dart';
import 'package:alefakaltawinea_animals_app/utils/my_widgets/laoding_view.dart';
import 'package:alefakaltawinea_animals_app/utils/my_widgets/transition_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

import 'add_adoption_screen.dart';
import 'adoption_register_pop.dart';
import 'animal_details_screen.dart';
import 'data/animal_pager_list_model.dart';
import 'my_adoption_screen.dart';

class AdoptionScreen extends StatefulWidget {
  const AdoptionScreen({Key? key}) : super(key: key);

  @override
  _AdoptionScreenState createState() => _AdoptionScreenState();
}

class _AdoptionScreenState extends State<AdoptionScreen> {
  AdoptionProviderModel? adoptionProviderModel;
  int _currentLoadedPage = 1;
  ScrollController? controller;
  List<Map<String, dynamic>> filteredCities = [];
  final TextEditingController _searchController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  String selectedCity="";



  @override
  void initState() {
    super.initState();
    AnalyticsHelper().setScreen(screenName: "شاشة-التبني");
    controller = ScrollController()..addListener(_scrollListener);
    adoptionProviderModel = Provider.of<AdoptionProviderModel>(context, listen: false);
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      adoptionProviderModel!.getCategoriesList();
    });
    final query = _searchController.text;
    filteredCities = MyUtils.getCities().where((city) {
      final cityNameArabic = city["name"].toString();
      final cityNameEnglish = city["name_en"].toString();
      return cityNameArabic.contains(query) || cityNameEnglish.contains(query);
    }).toList();
  }

  @override
  void dispose() async {
    await adoptionProviderModel!.setShowRegister(false);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    adoptionProviderModel = Provider.of<AdoptionProviderModel>(context, listen: true);
    return BaseScreen(
        showSettings: false,
        showBottomBar: false,
        showWhatsIcon: false,
        tag: "AdoptionScreen",
        body: Container(
          color: Colors.white,
          child: Stack(
          fit: StackFit.expand,
          children: [
            Column(
              children: [
                _header(context),
                SizedBox(height: 10.h,),
                Expanded(
                    child: Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          _categoryList(),
                          SizedBox(height: 10.h,),

                          Row(
                            children: [
                              Expanded(
                                child: _addBtn(),
                              ),
                              Expanded(
                                child: _myOffersBtn(),
                              ),
                            ],
                          ),
                          adoptionProviderModel!.isLoading && adoptionProviderModel!.animalPagerListModel == null
                              ? Expanded(child: LoadingProgress())
                              : adoptionProviderModel!.animalPagerListModel == null
                              ? Container()
                              : Expanded(
                              flex: 1,
                              child: Stack(
                                children: [
                                  _animalsList(),
                                  (adoptionProviderModel!.isLoading && (adoptionProviderModel!.animalPagerListModel!.data ?? []).isNotEmpty)
                                      ? Container(
                                    height: MediaQuery.of(context).size.height,
                                    width: MediaQuery.of(context).size.width,
                                  )
                                      : Container()
                                ],
                              )),
                          adoptionProviderModel!.animalPagerListModel == null
                              ? Container()
                              : (adoptionProviderModel!.isLoading && (adoptionProviderModel!.animalPagerListModel!.data ?? []).isNotEmpty)
                              ? Container(
                            height: D.default_60,
                            width: D.default_250,
                            child: Center(
                              child: SpinKitCircle(
                                color: C.ADAPTION_COLOR,
                              ),
                            ),
                          )
                              : Container()
                        ],
                      ),
                    ))
              ],
            ),
            Constants.currentUser == null && adoptionProviderModel!.shoewRegister ? RegisterationPop() : Container()
          ],
        ),));
  }

  Widget _addBtn() {
    return InkWell(
      onTap: () {
        if (Constants.currentUser != null) {
          MyUtils.navigate(context, AddAdoptionScreen());
        } else {
          msgreguser(context);
          // adoptionProviderModel!.setShowRegister(true);
        }
      },
      child: Container(
          margin: EdgeInsets.only(left: 10.w, right:10.w),
          padding: EdgeInsets.only(top: D.default_10, bottom: D.default_10, left: 10.w, right: 10.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(D.default_15),
            color: C.ADAPTION_COLOR,
          ),
          child: Center(
            child: Text(
              tr("add_adoption"),
              style: S.h2(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          )),
    );
  }

  Widget _myOffersBtn() {
    return InkWell(
      onTap: () {
        if (Constants.currentUser != null) {
          MyUtils.navigate(context, MyAdoptionScreen());
        } else {
          msgreguser(context);
          // adoptionProviderModel!.setShowRegister(true);
        }
      },
      child: Container(
          margin: EdgeInsets.only(left: D.default_20, right: D.default_20),
          padding: EdgeInsets.only(top: D.default_10, bottom: D.default_10, left: D.default_20, right: D.default_20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(D.default_15),
            color: C.ADAPTION_COLOR,
          ),
          child: Center(
            child: Text(
              tr("my_adoption"),
              style: S.h2(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          )),
    );
  }

  Widget _categoryList() {
    return Container(
      margin: EdgeInsets.only(left: D.default_10, right: D.default_10),
      height: D.default_80,
      width: double.infinity,
      child: ListView.builder(
          itemCount: adoptionProviderModel!.categoriesList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Container(
                margin: EdgeInsets.all(D.default_10),
                child: InkWell(
                  onTap: () {
                    _currentLoadedPage = 1;
                    adoptionProviderModel!.setSelectedCategoryIndex(index);
                    adoptionProviderModel!.getAnimals(adoptionProviderModel!.categoriesList[index].id!, 1);
                  },
                  child: TransitionImage(
                    adoptionProviderModel!.categoriesList[index].photo!,
                    radius: D.default_200,
                    width: D.default_60,
                    height: D.default_60,
                    strokeColor: adoptionProviderModel!.selectedCategoryIndex == index ? C.ADAPTION_COLOR : Colors.grey[400],
                    backgroundColor: adoptionProviderModel!.selectedCategoryIndex == index ? C.ADAPTION_COLOR : Colors.grey[400],
                    fit: BoxFit.fitWidth,
                    padding: EdgeInsets.all(D.default_5),
                  ),
                ));
          }),
    );
  }

  Widget _animalsList() {

    List<AnimalData>? data=adoptionProviderModel!.animalPagerListModel!.data!.where((element) => (element.city??"").contains(selectedCity)).toList();
    return data.isNotEmpty
        ? Container(
            padding: EdgeInsets.all(D.default_10),
            child: CustomScrollView(controller: controller, slivers: [
              SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5.w,
                    mainAxisSpacing: 5.w,
                    childAspectRatio: 1,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return _animalsListItem(index);
                    },
                    childCount: data.length,
                    semanticIndexOffset: 1,
                  )),
            ]),
          )
        : _noData();
  }

  Widget _noData() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            tr("no_animals"),
            style: S.h3(color: C.BASE_BLUE),
          )
        ],
      ),
    );
  }

  Widget _animalsListItem(int index) {
    List<AnimalData>? data=adoptionProviderModel!.animalPagerListModel!.data!.where((element) => (element.city??"").contains(selectedCity)).toList();
    return InkWell(
        onTap: () {
          if (Constants.currentUser != null) {
            MyUtils.navigate(context, AnimalDetailsScreen(adoptionProviderModel!.animalPagerListModel!.data!.indexOf(data[index])));
          } else {
            msgreguser(context);
            // adoptionProviderModel!.setShowRegister(true);
          }
        },
        child: Container(
          margin: EdgeInsets.all(0),
          padding: EdgeInsets.all(10.h),
          child: Container(
              width: double.infinity,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.white, boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2), offset: Offset(0, 0), blurRadius: 5, spreadRadius: 2)]),
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(topLeft:Radius.circular(15),topRight:Radius.circular(15)),
                          color: Colors.grey[200],
                        image: DecorationImage(
                          fit: BoxFit.cover,
                            image: NetworkImage(data[index].photo!.isNotEmpty ? data[index].photo! : Res.DEFAULT_IMAGE))
                          ),
                      width: double.infinity,
                      height: 60.h,
                    ),
                  ),
                  SizedBox(height: 5.h,),
                  Text(
                    data[index].name!,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w800),
                  ),
                  Text(
                    tr("more"),
                    style: TextStyle(color: Colors.grey, fontSize: 12.sp, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 5.h,),
                ],
              )),
        ));
  }

  void _scrollListener() {
    print(controller!.position.extentAfter);
    if (controller!.position.extentAfter < 1) {
      _currentLoadedPage = _currentLoadedPage + 1;
      adoptionProviderModel!.getAnimals(adoptionProviderModel!.categoriesList[adoptionProviderModel!.selectedCategoryIndex].id!, _currentLoadedPage);
    }
  }
  Widget _city() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 6.h),
        margin: EdgeInsets.symmetric(horizontal: 10.w),

        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          color: C.BASE_BLUE,),
        child: InkWell(
          onTap: (){
            showBarModalBottomSheet(
              context: context,
              builder: (context) => SingleChildScrollView(
                controller: ModalScrollController.of(context),
                child: Container(
                  height: Get.height * 0.9,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [

                        Expanded(
                          child: ListView.builder(
                            itemCount: filteredCities.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(
                                  Constants.prefs!.get(Constants.LANGUAGE_KEY!) == 'ar'
                                      ? filteredCities[index]['name']
                                      : filteredCities[index]['name_en'],
                                  style: TextStyle(color: Colors.grey),
                                ),
                                onTap: () {
                                  _cityController.text =
                                  Constants.prefs!.get(Constants.LANGUAGE_KEY!) == 'ar'
                                      ? filteredCities[index]['name']
                                      : filteredCities[index]['name_en'];
                                  selectedCity=_cityController.text;
                                  setState(() {

                                  });
                                  Navigator.pop(context, filteredCities[index]['name']);
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
          child: Row(
            children: [
            Icon(Icons.location_on,color: Colors.white,size: 20,),
            SizedBox(width: 3.w,),
            Text(tr("city")+": ",style: TextStyle(color: Colors.white,fontSize: 12.sp,fontWeight: FontWeight.w800),),
            Text(selectedCity.isNotEmpty?selectedCity:tr("all"),style: TextStyle(fontSize: 11.sp,color:Colors.white ),),
              SizedBox(width: 3.w,),


            ],),
        ));

  }

  Widget _header(BuildContext ctx){
    return   Column(
      children: [
        SizedBox(height: 2.h,),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(D.default_10),
              color: Colors.white,
              boxShadow:[BoxShadow(
                  color: Colors.grey.withOpacity(0.05),
                  offset: Offset(0,5),
                  blurRadius:5,
                  spreadRadius:5
              )]
          ),
          padding:  EdgeInsets.symmetric(vertical: 2.h,horizontal: 3.w),
          child: Row(
            children: [
              _city(),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width:10.w),
                    Text(tr("adoption"),style: TextStyle(color: C.BASE_BLUE,fontSize: 17.sp,fontWeight: FontWeight.w800),),
                  ],
                ),
              ),

              //TransitionImage(Res.IC_HOME_BLUE,width: 55.h,height: 55.h,),
              Expanded(child:
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [

                  IconButton(onPressed: () {
                    Navigator.of(ctx).pop();
                  }, icon: Image.asset(Res.IOS_BACK,height: 19.h,width: 19.h,fit: BoxFit.cover,),),
                ],
              )) ,
            ],),
        ),
        SizedBox(height: 3.h,),
      ],
    );
  }

}

class adoptionCategory {
  String name = "test";
  String image = Res.IC_FAV_GREY;
}
