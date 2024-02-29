import 'package:alefakaltawinea_animals_app/core/servies/firebase/analytics_helper.dart';
import 'package:alefakaltawinea_animals_app/modules/baseScreen/baseScreen.dart';
import 'package:alefakaltawinea_animals_app/modules/categories_screen/data/categories_model.dart';
import 'package:alefakaltawinea_animals_app/modules/homeTabsScreen/provider/bottom_bar_provider_model.dart';
import 'package:alefakaltawinea_animals_app/modules/serviceProviders/list_screen/items/service_provider_list_item.dart';
import 'package:alefakaltawinea_animals_app/modules/serviceProviders/list_screen/provider/sevice_providers_provicer_model.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/baseDimentions.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/baseTextStyle.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/myColors.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/resources.dart';
import 'package:alefakaltawinea_animals_app/utils/my_widgets/action_bar_widget.dart';
import 'package:alefakaltawinea_animals_app/utils/my_widgets/laoding_view.dart';
import 'package:alefakaltawinea_animals_app/utils/my_widgets/transition_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'fav_list_item.dart';


class FavScreen extends StatefulWidget {
  FavScreen();
  @override
  _FavScreenState createState() => _FavScreenState();
}

class _FavScreenState extends State<FavScreen>  {
  BottomBarProviderModel?bottomBarProviderModel;
  ServiceProvidersProviderModel? serviceProvidersProviderModel;
  int _currentLoadedPage=1;
  RefreshController _refreshController =
  RefreshController(initialRefresh: false);
  GlobalKey _contentKey = GlobalKey();
  GlobalKey _refresherKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    AnalyticsHelper().setScreen(screenName: "شاشة-المفضلة");
    ///bottom bar selection
    bottomBarProviderModel=Provider.of<BottomBarProviderModel>(context,listen: false);
    bottomBarProviderModel!.setSelectedScreen(1);

    ///service providers data
    serviceProvidersProviderModel=Provider.of<ServiceProvidersProviderModel>(context,listen: false);
    serviceProvidersProviderModel!.getFavsList();
  }
  @override
  Widget build(BuildContext context) {
    serviceProvidersProviderModel=Provider.of<ServiceProvidersProviderModel>(context,listen: true);
    return Column(children: [
      Expanded(child:serviceProvidersProviderModel!.isLoading?LoadingProgress():SmartRefresher(
        key: _refresherKey,
        controller: _refreshController,
        enablePullUp: true,
        child: _listitem(),
        physics: BouncingScrollPhysics(),
        footer: ClassicFooter(
          loadStyle: LoadStyle.ShowWhenLoading,
          completeDuration: Duration(milliseconds: 500),
        ),
        onRefresh: () async {
          serviceProvidersProviderModel!.getFavsList();
        },
        onLoading: () async {
          serviceProvidersProviderModel!.getFavsList();

          //_refreshController.loadFailed();
        },
      )
        ,)
    ],);
  }
  Widget _listitem(){
    return serviceProvidersProviderModel!.favList.isNotEmpty?Container(
      child: ListView.builder(
        itemCount: serviceProvidersProviderModel!.favList.length,
        padding: EdgeInsets.all(D.default_10),
        itemBuilder: (context,index){
          return  serviceProvidersProviderModel!.serviceProviderModel!=null?ServiceProviderListItem(index,serviceProvidersProviderModel):SizedBox();
        }),):_noData();
  }
Widget _noData(){
    return Center(child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        Text(tr('FAV_EMPTY'),style: S.h2(color: C.BASE_BLUE),),
        Text(tr('there_is_no_fav'),style: S.h4(color: Colors.grey),)

      ],),);
}
  Widget _header(BuildContext ctx){
    return   Column(
      children: [
        SizedBox(height: 2.h,),
        Padding(
          padding:  EdgeInsets.symmetric(vertical: 2.h,horizontal: 3.w),
          child: Row(children: [
            SizedBox(width: 15.h,),
            Text(tr('fav_screen_title'),style: TextStyle(color: C.BASE_BLUE,fontSize: 16.sp,fontWeight: FontWeight.w700),),
            Expanded(child:TransitionImage(Res.IC_HOME_BLUE,width: D.default_80,height: D.default_60,),),
            SizedBox(width: 25.h,),
          ],),
        ),
        SizedBox(height: 3.h,),
        Container(height: 1,color: Colors.grey[200],width: double.infinity,)
      ],
    );
  }

}
