
import 'package:alefakaltawinea_animals_app/modules/categories_screen/mainCategoriesScreen.dart';
import 'package:alefakaltawinea_animals_app/modules/categories_screen/new_main_categories_screen.dart';
import 'package:alefakaltawinea_animals_app/modules/fav/favourite_screen.dart';
import 'package:alefakaltawinea_animals_app/modules/homeTabsScreen/provider/bottom_bar_provider_model.dart';
import 'package:alefakaltawinea_animals_app/modules/login/login_screen.dart';
import 'package:alefakaltawinea_animals_app/modules/neerToYou/NearToyouScreen.dart';
import 'package:alefakaltawinea_animals_app/modules/profile/no_profile_screen.dart';
import 'package:alefakaltawinea_animals_app/modules/profile/profileScreen.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/baseDimentions.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/baseTextStyle.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/constants.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/myColors.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/myUtils.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/resources.dart';
import 'package:alefakaltawinea_animals_app/utils/my_widgets/transition_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import '../cart/add_cart_screen.dart';
import '../my_cards/my_cards_screen.dart';
import '../notifications/notifications_screen.dart';
import '../registeration/registration_screen.dart';
import '../serviceProviderAccount/SpHomeScreen.dart';
import '../serviceProviderAccount/code_scanner_screen.dart';
import 'provider/intro_provider_model.dart';


class HomeTabsScreen extends StatefulWidget {
  IntroProviderModel?introProviderModel;
  bool showIntro;
  int?selectedTab;
  

   HomeTabsScreen(this.introProviderModel,this.showIntro,{this.selectedTab=-1}) ;

  @override
  _HomeTabsScreenState createState() => _HomeTabsScreenState();
}

class _HomeTabsScreenState extends State<HomeTabsScreen> with TickerProviderStateMixin{
  BottomBarProviderModel?bottomBarProviderModel;
  bool isServiceProvider=false;
@override
  void initState() {
    super.initState();
}

  @override
  Widget build(BuildContext context) {
  if(Constants.currentUser!=null){
    if(Constants.currentUser!.userTypeId.toString()=="6"){
      isServiceProvider=true;
    }
    else{
      isServiceProvider=false;

    }
  }
    bottomBarProviderModel=Provider.of<BottomBarProviderModel>(context,listen: true);
  if((!isServiceProvider)&&widget.selectedTab!=bottomBarProviderModel!.selectedScreen){
    if(widget.selectedTab==0){
      bottomBarProviderModel!.setSelectedScreen(0);
      MyUtils.navigateAsFirstScreen(context, NewMainCategoriesScreen());    }
    if(widget.selectedTab==1){
      //bottomBarProviderModel!.setSelectedScreen(1);
    }
    if(widget.selectedTab==2){
      bottomBarProviderModel!.setSelectedScreen(2);
      MyUtils.navigate(context, NearToYouScreen());
    }
    if(widget.selectedTab==3){
      bottomBarProviderModel!.setSelectedScreen(3);
      if(Constants.currentUser!=null){
        MyUtils.navigate(context, MyCardsScreen());
      }else{
        MyUtils.navigate(context, LoginScreen());
      }
    }
    if(widget.selectedTab==4){
      bottomBarProviderModel!.setSelectedScreen(4);
      if(Constants.currentUser!=null){
        MyUtils.navigate(context, ProfileScreen());
      }else{
        MyUtils.navigate(context, LoginScreen());
      }
    }
  }
    return  _bottomBar();
  }
 

  Widget _bottomBar(){
    return Container(
      padding: EdgeInsets.all(D.default_10),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(0),
          color: Colors.white.withOpacity(0.8),

      ),
      child: Column(
        children: [
          Row(
            children: isServiceProvider?[
              _SpHomeBtn(),
              _SpScanCodeBtn(),
            ]:[
              _homeBtn(),
              //_favBtn(),
              _closestBtn(),
              _myCardsBtn(),
              _profileBtn()

            ],
          ),
          SizedBox(height: 30.h,)
        ],
      ),
    ) ;
  }
  Widget _homeBtn(){
    return Expanded(
      child: InkWell(onTap: (){
        bottomBarProviderModel!.setSelectedScreen(0);
        MyUtils.navigateAsFirstScreen(context, NewMainCategoriesScreen());
      }
        ,child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:[
          TransitionImage(bottomBarProviderModel!.selectedScreen==0?Res.IC_HOME_BLUE:Res.IC_HOME_GREY,width: 24.h,height: 24.h,),
          Center(child:Text(tr("home"),style: TextStyle(color: bottomBarProviderModel!.selectedScreen==0?C.BASE_BLUE:Colors.grey,fontSize: 10.sp,fontWeight: FontWeight.w700),),)
        ]
    ),));
  }
  Widget _favBtn(){
    return Expanded(
      child: InkWell(onTap: (){
        bottomBarProviderModel!.setSelectedScreen(1);
        if(Constants.currentUser!=null){
          MyUtils.navigate(context, FavScreen());
        }else{
          MyUtils.navigate(context, LoginScreen());
        }

      }
        ,child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:[
          TransitionImage(bottomBarProviderModel!.selectedScreen==1?Res.IC_FAV_BLUE:Res.IC_FAV_GREY,width: D.default_25,height: D.default_25,),
          Center(child:Text(tr("fav"),style: S.h3(color: bottomBarProviderModel!.selectedScreen==1?C.BASE_BLUE:Colors.grey),),)
        ]
    ),));
  }
  Widget _myCardsBtn(){
    return Expanded(
      child: InkWell(onTap: (){
        bottomBarProviderModel!.setSelectedScreen(3);
        if(Constants.currentUser!=null){
          MyUtils.navigate(context, MyCardsScreen());
        }else{
          MyUtils.navigate(context, LoginScreen());
        }
      }
        ,child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:[
          TransitionImage("assets/images/card_ic.png",width: 24.h,height: 24.h,),
          Center(child:Text(tr("card"),style: TextStyle(color: bottomBarProviderModel!.selectedScreen==3?C.BASE_BLUE:Colors.grey,fontSize: 10.sp,fontWeight: FontWeight.w700),),)
        ]
    ),));
  }
  Widget _profileBtn(){
    return Expanded(
      child: InkWell(onTap: (){
        bottomBarProviderModel!.setSelectedScreen(4);
        if(Constants.currentUser!=null){
          MyUtils.navigate(context, ProfileScreen());
        }else{
          MyUtils.navigate(context, LoginScreen());
        }
        //bottomBarProviderModel!.setSelectedScreen(4);

      }
        ,child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:[
          TransitionImage(bottomBarProviderModel!.selectedScreen==4?Res.IC_PROFILE_BLUE:Res.IC_PROFILE_GREY,width: 21.h,height: 21.h,),
          Center(child:Text(tr("profile"),style: TextStyle(color: bottomBarProviderModel!.selectedScreen==4?C.BASE_BLUE:Colors.grey,fontSize: 10.sp,fontWeight: FontWeight.w700),),)
        ]
    ),));
  }
  Widget _closestBtn(){
    return Expanded(
      child:InkWell(onTap: (){
        bottomBarProviderModel!.setSelectedScreen(2);
        MyUtils.navigate(context, NearToYouScreen());
      }
          ,child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            TransitionImage(bottomBarProviderModel!.selectedScreen==2?Res.IC_NEAR_BLUE:Res.IC_NEAR_GREY,width: 22.h,height: 22.h,),
            Center(child:Text(tr("closest"),style: TextStyle(color: bottomBarProviderModel!.selectedScreen==2?C.BASE_BLUE:Colors.grey,fontSize: 10.sp,fontWeight: FontWeight.w700),),)
          ]
      ),));
  }
  Widget _SpHomeBtn(){
    return Expanded(
        child: InkWell(onTap: (){
          bottomBarProviderModel!.setSelectedScreen(0);
          MyUtils.navigateAsFirstScreen(context, SpHomeScreen());
        }
          ,child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:[
                TransitionImage(bottomBarProviderModel!.selectedScreen==0?Res.IC_HOME_BLUE:Res.IC_HOME_GREY,width: 24.h,height: 24.h,),
                Center(child:Text(tr("home"),style: TextStyle(color: bottomBarProviderModel!.selectedScreen==2?C.BASE_BLUE:Colors.grey,fontSize: 10.sp,fontWeight: FontWeight.w700),),)
              ]
          ),));
  }
  Widget _SpScanCodeBtn(){
    return Expanded(
        child: InkWell(onTap: (){
          bottomBarProviderModel!.setSelectedScreen(1);
          MyUtils.navigateAsFirstScreen(context, CodeScannerScreen());
        }
          ,child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:[
                TransitionImage(bottomBarProviderModel!.selectedScreen==1?"assets/images/qr_icon_blue.png":"assets/images/qr_icon_black.png",width: 24.h,height: 24.h,),
                Center(child:Text(tr("code_tap"),style: TextStyle(color: bottomBarProviderModel!.selectedScreen==2?C.BASE_BLUE:Colors.grey,fontSize: 10.sp,fontWeight: FontWeight.w700),),)
              ]
          ),));
  }


}

