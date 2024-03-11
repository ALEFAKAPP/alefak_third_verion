import 'package:alefakaltawinea_animals_app/core/servies/firebase/analytics_helper.dart';
import 'package:alefakaltawinea_animals_app/modules/adoption/adpotion_screen.dart';
import 'package:alefakaltawinea_animals_app/modules/ads/ads_slider.dart';
import 'package:alefakaltawinea_animals_app/modules/ads/provider/ads_slider_provider.dart';
import 'package:alefakaltawinea_animals_app/modules/baseScreen/baseScreen.dart';
import 'package:alefakaltawinea_animals_app/modules/categories_screen/data/home_offers_model.dart';
import 'package:alefakaltawinea_animals_app/modules/homeTabsScreen/homeTabsScreen.dart';
import 'package:alefakaltawinea_animals_app/modules/notifications/data/notification_model.dart';
import 'package:alefakaltawinea_animals_app/modules/notifications/provider/notification_provider.dart';
import 'package:alefakaltawinea_animals_app/modules/serviceProviders/details_screen/new_service_provider_details_screen.dart';
import 'package:alefakaltawinea_animals_app/modules/serviceProviders/details_screen/service_provider_details_screen.dart';
import 'package:alefakaltawinea_animals_app/modules/serviceProviders/list_screen/data/getServiceProvidersApi.dart';
import 'package:alefakaltawinea_animals_app/modules/serviceProviders/list_screen/data/serviceProvidersModel.dart';
import 'package:alefakaltawinea_animals_app/modules/serviceProviders/list_screen/hom_offers_all_list.dart';
import 'package:alefakaltawinea_animals_app/modules/serviceProviders/list_screen/service_providers_list_screen.dart';
import 'package:alefakaltawinea_animals_app/modules/settings/contact_us_screen.dart';
import 'package:alefakaltawinea_animals_app/modules/settings/settings_screen.dart';
import 'package:alefakaltawinea_animals_app/modules/spalshScreen/PageMaintenanceScreen.dart';
import 'package:alefakaltawinea_animals_app/modules/spalshScreen/data/regions_api.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/apis.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/baseTextStyle.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/constants.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/myColors.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/myUtils.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/my_fonts.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/providers.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/resources.dart';
import 'package:alefakaltawinea_animals_app/utils/my_widgets/laoding_view.dart';
import 'package:alefakaltawinea_animals_app/utils/my_widgets/transition_image.dart';
import 'package:alefakaltawinea_animals_app/views/cards/BuyCard/steps/StepOne.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../shared/constance/fonts.dart';
import '../../utils/my_utils/baseDimentions.dart';
import '../homeTabsScreen/provider/intro_provider_model.dart';
import '../search/search_screen.dart';
import '../serviceProviders/list_screen/shops_tab_screen.dart';
import '../settings/about_screen.dart';
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

class _NewMaiinCategoriesScreenState extends State<NewMainCategoriesScreen> with AutomaticKeepAliveClientMixin<NewMainCategoriesScreen> {
  AdsSliderProviderModel?adsSliderProviderModel;

  CategoriesProviderModel?categoriesProviderModel;
  RegionsApi regionsApi=RegionsApi();
  UtilsProviderModel? utilsProviderModel;
  bool isloading=true;

  @override
  void initState() {
    super.initState();
    AnalyticsHelper().setScreen(screenName: "شاشة-الرئيسية");
    categoriesProviderModel=Provider.of<CategoriesProviderModel>(context,listen: false);
    utilsProviderModel=Provider.of<UtilsProviderModel>(context,listen: false);
    WidgetsBinding.instance!.addPostFrameCallback((_)async{
      await adsSliderProviderModel!.getAdsSlider();
      await categoriesProviderModel!.getCategoriesList();
      await categoriesProviderModel!.getHomeOffersList();
      notificationNavigation();
      FirebaseDynamicLinks.instance.onLink.listen(
            (pendingDynamicLinkData) async{
          if (pendingDynamicLinkData != null) {
            Map<String,dynamic>  deepLink = pendingDynamicLinkData.link.queryParameters;
            switch(deepLink["type"]){
              case "buy_card": MyUtils.navigate(context,BuyCard());
              break;
              case "category":_onCategoryClick(int.parse(deepLink["category_id"]??"0"),context);
              break;
              case "service_provider":
                GetServiceProvidersApi api=GetServiceProvidersApi();
                await api.getServiceProvider(int.parse((deepLink["service_provider_id"]??"0"))).then((value){
                  Data provider=value.data;
                  Get.to(()=>NewServiceProviderDetailsScreen(provider));
                });
              break;
              case "offer":
                GetServiceProvidersApi api=GetServiceProvidersApi();
                await api.getServiceProvider(int.parse((deepLink["service_provider_id"]??"0"))).then((value){

                  Data provider=value.data;
                  int offerIndex=provider.offers!.indexOf(provider.offers!.where((element) => element.id.toString()==deepLink["offer_id"]).first);
                  Get.to(()=>NewServiceProviderDetailsScreen(provider,offerIndex:offerIndex));
                });
              break;
              case "profile":await Get.offAll(HomeTabsScreen(IntroProviderModel(),false));
              break;
              case "about":await Get.to(AboutAppScreen());
              break;
              case "contact_us":await Get.to(ContactUsScreen());
              break;
            }

          }
        },
      );
      setState(() {
        isloading=false;
      });
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


    return BaseScreen(
        tag: "MainCategoriesScreen",
        padding: EdgeInsets.zero,
        showBottomBar: true,
        showSettings: false,
        showIntro: false,
        body:Scaffold(
          backgroundColor: Color(0xffFFFFFF),
          body: SafeArea(
            child: Column(children: [
              _header(),
             Expanded(child: isloading?LoadingProgress():ListView(
               padding: EdgeInsets.only(bottom: 70.h),
               children: [
                 AdsSlider(),
                 SizedBox(height: 10.h),
                 Text("${Constants.currentUser!=null?(Constants.currentUser!.name):''} ${tr("what_alifak_want")}",style:TextStyle(fontSize: 15.sp,fontWeight: FontWeight.w800),textAlign: TextAlign.center,),
                 SizedBox(height: 3.h,),
                 gatigoriesList(),
                 SizedBox(height: 5.h,),
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
    return   Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(bottomRight:Radius.circular(D.default_10),bottomLeft:Radius.circular(D.default_10) ),
          color: Colors.white,
          boxShadow:[BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              offset: Offset(0,5),
              blurRadius:8,
              spreadRadius: 3
          )]
      ),
      child: Column(
        children: [
          SizedBox(height: 2.h,),
          Padding(
            padding:  EdgeInsets.symmetric(vertical: 2.h,horizontal: 3.w),
            child: Row(children: [
              IconButton(onPressed: () {
                MyUtils.navigate(context, SettingScreen());
              }, icon: Icon(Icons.segment,color: C.BASE_BLUE,size: D.default_35,),) ,
              Expanded(child:InkWell(
                onTap: (){MyUtils.navigate(context, AboutAppScreen());},
                child: Container(
                  margin:  EdgeInsets.symmetric(horizontal: 20.w),
                  padding:  EdgeInsets.symmetric(vertical: 3.h,horizontal: 2.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: C.BASE_BLUE,
                  ),
                  child: Text(tr("know_about_alifak"),style:
                  TextStyle(color: Colors.white,fontSize: 13.sp,fontWeight: FontWeight.w700),textAlign:TextAlign.center ,),
                ),
              ),),
              SizedBox(width: 30.w,) ,
            ],),
          ),
          SizedBox(height: 3.h,),
          Container(height: 1,color: Colors.grey[200],width: double.infinity,)
        ],
      ),
    );
  }
  
  Widget gatigoriesList(){
    return Consumer<CategoriesProviderModel>(
      builder: (context,model,_) {
        return model.categoriesList.isNotEmpty?
        Container(
          height: 95.h,
          padding: EdgeInsets.symmetric(vertical: 7.h),
          width: double.infinity,
            color: Color(0x9bf8f8f8),
            margin: EdgeInsets.symmetric(horizontal: D.default_7),
            child: ListView(
            scrollDirection: Axis.horizontal,
              children:List.generate(model.categoriesList.length, (index) {return GestureDetector(
                onTap: (){_onCategoryClick(model.categoriesList[index].id??-1,context);},
            child:Container(
              width: 100.w,
              margin: EdgeInsets.symmetric(horizontal: 3.h,vertical:3.h),
              padding: EdgeInsets.symmetric(horizontal: 3.w,vertical: 3.w),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow:[BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      blurRadius:8,
                      spreadRadius: 1
                  )]

              ),
              child: Column(children: [
                (model.categoriesList[index].photo??'').isEmpty?
                Image.asset(Res.IC_HOME_BLUE,height: 30.h,):
                Image.network(
                  model.categoriesList[index].photo??'',
                  height: 40.h,
                  errorBuilder:(ctx,object,_) {
                  return Image.asset(Res.IC_HOME_BLUE,height: 45.h,);
                },),
                Expanded(child: Center(child: Text(model.categoriesList[index].name??"",textAlign: TextAlign.center,style: TextStyle(color: C.BASE_BLUE,fontWeight: FontWeight.w600,fontSize: 12.sp,height: 1.2  ),)))
              ],),
            ),

        );
  }))) :SizedBox();
      }
    );
}
Widget offersList({required int id,required String title,required List<OfferElement>data}){
  //data.removeWhere((element) => element.offer.expirationDate.isBefore(DateTime.now()));
    return data.isNotEmpty?Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child:
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            SizedBox(width: 8.w,),
            Expanded(child: Text(title,style: TextStyle(fontSize: 16.sp,fontFamily: fontPrimary,fontWeight: FontWeight.w900))),
            GestureDetector(
                onTap: (){
                  MyUtils.navigate(context,HomeOffersAllList(title:title,listId: id,));
                },
                child:Text(tr("home_offers_more"),style: TextStyle(color: Colors.grey,fontSize: 13.sp,fontFamily: fontPrimary,fontWeight: FontWeight.w800),))
          ],),
          SizedBox(height: 6.h,),
          SizedBox(
            height: 190.h,
            width:double.infinity,
            child: data.isNotEmpty?ListView.builder(
                padding: EdgeInsets.zero,
                scrollDirection: Axis.horizontal,
                itemCount:data.length ,
                itemBuilder: (ctx,index){
                  return InkWell(
                    onTap: (){
                      MyUtils.navigate(context, NewServiceProviderDetailsScreen(data[index].offer.shop,offerIndex:data[index].offer.shop.offers!.indexOf(data[index].offer.shop.offers!.where((element) => element.id==data[index].offer.id).first)));
                    },
                    child: Container(
                      margin: EdgeInsets.all(D.default_10),
                      width: 270.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow:[BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              blurRadius:8,
                              spreadRadius: 1
                          )]
                      ),
                      child: Stack(children: [
                        Column(
                          crossAxisAlignment:CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 120.h,
                              padding: EdgeInsets.all(D.default_10),
                              decoration: BoxDecoration(
                                color:Colors.grey.withOpacity(0.3),
                                image: DecorationImage(

                                    image: NetworkImage(
                                      ((data[index].offer.shop.offers!.where((element) => element.id==data[index].offer.id).first.photo)??"").isNotEmpty?
                                      "${'https://alefak.com/uploads/'}"+((data[index].offer.shop.offers!.where((element) => element.id==data[index].offer.id).first.photo)??""):("${'https://alefak.com/uploads/'}"+data[index].offer.shop.bannerPhoto.toString())??Res.IC_HOME_BLUE,
                                ),fit:BoxFit.cover),
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(D.default_10),topRight: Radius.circular(D.default_10)),
                              ),),
                            SizedBox(height: 5.h,),
                            Padding(
                              padding:  EdgeInsets.symmetric(horizontal:8.h,vertical: 2.h),
                              child: Text(data[index].offer.shop.name??'',overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontWeight: FontWeight.w700,fontFamily:fontPrimary,fontSize: 14.sp )),
                            ),
                            Padding(
                              padding:  EdgeInsets.symmetric(horizontal:8.h),
                              child: Text(
                                  Constants.utilsProviderModel!.isArabic?data[index].offer.title??'':data[index].offer.title??''
                                  ,overflow: TextOverflow.ellipsis
                                  ,style: TextStyle(fontWeight: FontWeight.w200,fontSize: 13.sp,color: Color(0xff2B2B2B) )),
                            ),

                          ],),
                        Positioned(child: Container(
                          padding: EdgeInsets.all(D.default_5),
                          margin: EdgeInsets.all(10.h),
                          width: 50.h,
                          height: 50.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(D.default_10),
                              color: Colors.white,
                              boxShadow:[BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  offset:Offset(0,0),
                                  blurRadius:1,
                                  spreadRadius: 1
                              )]
                          ),
                          child:TransitionImage(
                             ("${'https://alefak.com/uploads/'}"+data[index].offer.shop.photo.toString()),
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
  void _onCategoryClick(int id,BuildContext ctx){
    if(id==-1){
    }else{
      if(id==4){
        MyUtils.navigate(ctx, ShopTabsScreen());
        return;
      }
      if(id==5){
        MyUtils.navigate(ctx, AdoptionScreen());
        return;
      }
      MyUtils.navigate(ctx, ServiceProviderListScreen(id,ctx.read<CategoriesProviderModel>().categoriesList.where((element) => element.id==id).first.name??''));
    }
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;


}
