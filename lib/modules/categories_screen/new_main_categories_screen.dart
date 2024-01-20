import 'package:alefakaltawinea_animals_app/core/servies/firebase/analytics_helper.dart';
import 'package:alefakaltawinea_animals_app/modules/ads/provider/ads_slider_provider.dart';
import 'package:alefakaltawinea_animals_app/modules/baseScreen/baseScreen.dart';
import 'package:alefakaltawinea_animals_app/modules/categories_screen/data/home_offers_model.dart';
import 'package:alefakaltawinea_animals_app/modules/notifications/data/notification_model.dart';
import 'package:alefakaltawinea_animals_app/modules/notifications/provider/notification_provider.dart';
import 'package:alefakaltawinea_animals_app/modules/serviceProviders/details_screen/service_provider_details_screen.dart';
import 'package:alefakaltawinea_animals_app/modules/serviceProviders/list_screen/hom_offers_all_list.dart';
import 'package:alefakaltawinea_animals_app/modules/serviceProviders/list_screen/service_providers_list_screen.dart';
import 'package:alefakaltawinea_animals_app/modules/settings/settings_screen.dart';
import 'package:alefakaltawinea_animals_app/modules/spalshScreen/data/regions_api.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/baseTextStyle.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/constants.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/myColors.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/myUtils.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/my_fonts.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/providers.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/resources.dart';
import 'package:alefakaltawinea_animals_app/utils/my_widgets/transition_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../shared/constance/fonts.dart';
import '../../utils/my_utils/baseDimentions.dart';
import '../search/search_screen.dart';
import 'data/home_singl_offer_model.dart';
import 'provider/categories_provider_model.dart';

class NewMainCategoriesScreen extends StatefulWidget {
  Function? navigateTo;
   NewMainCategoriesScreen({
    this.navigateTo,
    Key? key}) : super(key: key);

  @override
  State<NewMainCategoriesScreen> createState() => _NewMaiinCategoriesScreenState();
}

class _NewMaiinCategoriesScreenState extends State<NewMainCategoriesScreen> {
  AdsSliderProviderModel?adsSliderProviderModel;

  CategoriesProviderModel?categoriesProviderModel;
  RegionsApi regionsApi=RegionsApi();
  UtilsProviderModel? utilsProviderModel;

  @override
  void initState() {
    super.initState();
    AnalyticsHelper().setScreen(screenName: "شاشة-الرئيسية");
    categoriesProviderModel=Provider.of<CategoriesProviderModel>(context,listen: false);
    utilsProviderModel=Provider.of<UtilsProviderModel>(context,listen: false);
    WidgetsBinding.instance!.addPostFrameCallback((_)async{
      //adsSliderProviderModel!.getAdsSlider();
      categoriesProviderModel!.getCategoriesList();
      categoriesProviderModel!.getHomeOffersList();
      //await context.read<NotificationProvider>().getNotificationsList();
      notificationNavigation();
    });

  }
  notificationNavigation(){
    widget.navigateTo!=null?widget.navigateTo!():(){};

  }
  @override
  Widget build(BuildContext context) {
    utilsProviderModel=Provider.of<UtilsProviderModel>(context,listen: false);
    categoriesProviderModel=Provider.of<CategoriesProviderModel>(context,listen: true);
    adsSliderProviderModel=Provider.of<AdsSliderProviderModel>(context,listen: true);

    if(adsSliderProviderModel!.adsSliderModelList.isEmpty){
      Future.delayed(Duration(milliseconds: 4000)).then((value){
        if(adsSliderProviderModel!.adsSliderModelList.isEmpty){
          adsSliderProviderModel!.getAdsSlider();
        }}
      );}
    return BaseScreen(
        tag: "MainCategoriesScreen",
        showBottomBar: true,
        showSettings: false,
        showIntro: false,
        body:Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Column(children: [
              _header(),
             Expanded(child: ListView(
               padding: EdgeInsets.symmetric(vertical: 20.h),
               children: [
                 SizedBox(height: D.default_30,),
                 Text("${Constants.currentUser!=null?(Constants.currentUser!.name):''} ${tr("what_alifak_want")}",style:S.h1Bold(),textAlign: TextAlign.center,),
                 SizedBox(height: D.default_20,),
                 Container(
                   margin:  EdgeInsets.symmetric(horizontal: D.default_70),
                   padding:  EdgeInsets.symmetric(vertical: D.default_10,horizontal: D.default_10),
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(D.default_10),
                     color: C.BASE_BLUE,
                   ),
                   child: Text(tr("know_about_alifak"),style:
                   S.h2(),textAlign:TextAlign.center ,),
                 ),
                 
                 SizedBox(height: D.default_50,),
                 gatigoriesList(),
                 SizedBox(height: D.default_50,),
                 Consumer<CategoriesProviderModel>(
                     builder: (context,model,_) {
                       return Column(children: List.generate(model.homeOffersLists.length, (index){
                         return  offersList(
                           id: model.homeOffersLists[index].id,
                             title: Constants.utilsProviderModel!.isArabic?
                         model.homeOffersLists[index].nameAr:model.homeOffersLists[index].nameEn,
                         data: model.homeOffersLists[index].offers);
                       }));
                   }
                 ),
               ],
             ))
            ],),
          ),
        )
    );

  }
  Widget _header(){
    return   Column(
      children: [
        SizedBox(height: 2.h,),
        Padding(
          padding:  EdgeInsets.symmetric(vertical: 2.h,horizontal: 3.w),
          child: Row(children: [
            IconButton(onPressed: () {
              MyUtils.navigate(context, SettingScreen());
            }, icon: Icon(Icons.segment,color: C.BASE_BLUE,size: D.default_35,),) ,
            Expanded(child:TransitionImage(Res.IC_HOME_BLUE,width: D.default_80,height: D.default_80,),),
            IconButton(onPressed: () {
             // MyUtils.navigate(context, SearchScreen(""));
            }, icon: Icon(Icons.search,color: C.BASE_BLUE,size: D.default_35,),) ,
          ],),
        ),
        SizedBox(height: 3.h,),
        Container(height: 1,color: Colors.grey[200],width: double.infinity,)
      ],
    );
  }
  
  Widget gatigoriesList(){
    return Consumer<CategoriesProviderModel>(
      builder: (context,model,_) {
        return model.categoriesList.isNotEmpty?
        Container(
          height: D.default_140,
          width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: D.default_7),
            child: ListView(
            scrollDirection: Axis.horizontal,
              children:List.generate(model.categoriesList.length, (index) {return GestureDetector(
                onTap: (){_onCategoryClick(model.categoriesList[index].id??-1,index,context);},
            child:Container(
              width: 100,
              margin: EdgeInsets.symmetric(horizontal: D.default_7,vertical:D.default_7),
              padding: EdgeInsets.symmetric(horizontal: D.default_5,vertical: D.default_5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(D.default_10),
                  color: Colors.white,
                  boxShadow:[BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius:3,
                      spreadRadius: 2
                  )]
              ),
              child: Column(children: [
                (model.categoriesList[index].photo??'').isEmpty?
                Image.asset(Res.IC_HOME_BLUE,height: D.default_70,):
                Image.network(model.categoriesList[index].photo??'',height: D.default_70,errorBuilder:(ctx,object,_) {
                  return Image.asset(Res.IC_HOME_BLUE,height: D.default_70,);
                },),
                Expanded(child: Center(child: Text(model.categoriesList[index].name??"",textAlign: TextAlign.center,style: TextStyle(color: C.BASE_BLUE,fontFamily: fontPrimary,fontWeight: FontWeight.w800,fontSize: 11.sp),)))
              ],),
            ),

        );
  }))) :SizedBox();
      }
    );
}
Widget offersList({required int id,required String title,required List<OfferElement>data}){
    return data.isNotEmpty?Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child:
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            SizedBox(width: 8.w,),
            Expanded(child: Text(title,style: TextStyle(fontSize: 14.sp,fontFamily: fontPrimary,fontWeight: FontWeight.w900),)),
            GestureDetector(
                onTap: (){
                  MyUtils.navigate(context,HomeOffersAllList(title:title,listId: id,));

                  /// navigate to all offers screen
                },
                child:Text(tr("home_offers_more"),style: TextStyle(color: Colors.grey,fontSize: 12.sp,fontFamily: fontPrimary,fontWeight: FontWeight.w800),))
          ],),
          SizedBox(height: 5.h,),
          SizedBox(
            height: 200.h,
            width:double.infinity,
            child: data.isNotEmpty?ListView.builder(
                padding: EdgeInsets.zero,
                scrollDirection: Axis.horizontal,
                itemCount:data.length ,
                itemBuilder: (ctx,index){

                  return InkWell(
                    onTap: (){
                      MyUtils.navigate(context, ServiceProviderDetailsScreen(data[index].offer.shop));
                    },
                    child: Container(
                      margin: EdgeInsets.all(D.default_10),
                      width: D.default_350,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(D.default_10),
                          color: Colors.white,
                          boxShadow:[BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              blurRadius:5,
                              spreadRadius: 3
                          )]
                      ),
                      child: Stack(children: [
                        Column(
                          crossAxisAlignment:CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 130.h,
                              padding: EdgeInsets.all(D.default_10),
                              decoration: BoxDecoration(
                                image: DecorationImage(image: NetworkImage("",
                                ),fit:BoxFit.cover),
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(D.default_10),topRight: Radius.circular(D.default_10)),
                                color: Colors.white,
                              ),),
                            Padding(
                              padding:  EdgeInsets.all(5.h),
                              child: Text(data[index].offer.shop.name??'',style: TextStyle(fontWeight: FontWeight.w900,fontFamily:fontPrimary,fontSize: 11.sp )),
                            ),
                            Expanded(child: Padding(
                              padding:  EdgeInsets.all(5.h),
                              child: Text(
                                  Constants.utilsProviderModel!.isArabic?data[index].offer.shop.offers![0].title??'':data[index].offer.shop.offers![0].titleEn??''
                                  ,style: TextStyle(fontWeight: FontWeight.w500,fontFamily:fontPrimary,fontSize: 10.sp,color: Colors.grey )),
                            ),),

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
                            "",
                            radius: D.default_10,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ) ,
                        ),),
                      ],),
                    ),);
                }):Center(child: Text(tr("no_offers")),),
          )
        ],)
      ,):SizedBox();
}
  void _onCategoryClick(int id,int index,BuildContext ctx){
    if(id==-1){
    }else{
      MyUtils.navigate(ctx, ServiceProviderListScreen(ctx.read<CategoriesProviderModel>().categoriesList[index],ctx.read<CategoriesProviderModel>().categoriesList[index].name??''));
    }
  }
}
