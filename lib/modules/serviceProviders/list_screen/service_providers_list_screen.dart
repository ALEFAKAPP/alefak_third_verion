import 'package:alefakaltawinea_animals_app/modules/baseScreen/baseScreen.dart';
import 'package:alefakaltawinea_animals_app/modules/categories_screen/data/categories_model.dart';
import 'package:alefakaltawinea_animals_app/modules/homeTabsScreen/provider/bottom_bar_provider_model.dart';
import 'package:alefakaltawinea_animals_app/modules/serviceProviders/list_screen/items/service_provider_list_item.dart';
import 'package:alefakaltawinea_animals_app/modules/serviceProviders/list_screen/provider/sevice_providers_provicer_model.dart';
import 'package:alefakaltawinea_animals_app/modules/settings/settings_screen.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/baseDimentions.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/baseTextStyle.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/myColors.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/myUtils.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/resources.dart';
import 'package:alefakaltawinea_animals_app/utils/my_widgets/action_bar_widget.dart';
import 'package:alefakaltawinea_animals_app/utils/my_widgets/laoding_view.dart';
import 'package:alefakaltawinea_animals_app/utils/my_widgets/transition_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';


class ServiceProviderListScreen extends StatefulWidget {
  int categoryId;
  String title;

   ServiceProviderListScreen(this.categoryId,this.title);

  @override
  _ServiceProviderListScreenState createState() => _ServiceProviderListScreenState();
}

class _ServiceProviderListScreenState extends State<ServiceProviderListScreen>  {
  BottomBarProviderModel?bottomBarProviderModel;
  ServiceProvidersProviderModel? serviceProvidersProviderModel;
  int _currentLoadedPage=1;
  ScrollController? controller;

  RefreshController _refreshController =
  RefreshController(initialRefresh: false);
  GlobalKey _contentKey = GlobalKey();
  GlobalKey _refresherKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    controller = ScrollController()..addListener(_scrollListener);

    WidgetsBinding.instance!.addPostFrameCallback((_) async {

      ///bottom bar selection
      bottomBarProviderModel=Provider.of<BottomBarProviderModel>(context,listen: false);
      bottomBarProviderModel!.setSelectedScreen(0);

      ///service providers data
      serviceProvidersProviderModel=Provider.of<ServiceProvidersProviderModel>(context,listen: false);
      serviceProvidersProviderModel!.getServiceProvidersList(widget.categoryId, _currentLoadedPage);
    });

  }
  @override
  Widget build(BuildContext context) {
    serviceProvidersProviderModel=Provider.of<ServiceProvidersProviderModel>(context,listen: true);
    return BaseScreen(
      tag: "ServiceProviderListScreen",
      showBottomBar: false,
      showSettings: false,
        body: Container(
            color:Colors.white,
          child: Column(children: [
            _header(context),

      Expanded(child: Stack(
        fit: StackFit.expand,
        children: [
          serviceProvidersProviderModel!.isLoading&&((serviceProvidersProviderModel!.serviceProviderModel)!=null?serviceProvidersProviderModel!.serviceProviderModel!.data!.isEmpty:true)?LoadingProgress():_listitem(),
          serviceProvidersProviderModel!.serviceProviderModel!=null?serviceProvidersProviderModel!.isLoading&&serviceProvidersProviderModel!.serviceProviderModel!.data!.isNotEmpty?
          Container():Container():Container(),
          serviceProvidersProviderModel!.isLoading?Container(color: Colors.white.withOpacity(0.3),height: MediaQuery.of(context).size.height,width: MediaQuery.of(context).size.width,):Container()
        ],)),
            serviceProvidersProviderModel!.serviceProviderModel!=null?serviceProvidersProviderModel!.isLoading&&serviceProvidersProviderModel!.serviceProviderModel!.data!.isNotEmpty?
            Container(height: D.default_60,width: D.default_250,child: Center(child: SpinKitCircle(
              color: Colors.white,
            ),),):Container():Container()

    ],),
        ));
  }
  Widget _listitem(){
    return
     serviceProvidersProviderModel!.serviceProviderModel != null &&
     serviceProvidersProviderModel!.serviceProviderModel!.data!.isNotEmpty?Container(
      margin: EdgeInsets.only(bottom: D.default_10),
      child: ListView.builder(
          controller: controller,
          itemCount: serviceProvidersProviderModel!.serviceProviderModel!.data!.length,
        padding: EdgeInsets.all(D.default_10),
        itemBuilder: (context,index){
          return  ServiceProviderListItem(index,serviceProvidersProviderModel);
        }),):Center(child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(tr("no_offers"),style: S.h3(color:Colors.white,))
      ],),);
  }
  void _scrollListener() {
    print(controller!.position.extentAfter);
    if ((!serviceProvidersProviderModel!.isLoading)&&(controller!.position.extentAfter < serviceProvidersProviderModel!.serviceProviderModel!.data!.length-1)) {
      _currentLoadedPage=_currentLoadedPage+1;
       serviceProvidersProviderModel!.getServiceProvidersList(widget.categoryId, _currentLoadedPage);
    }
  }
  Widget _header(BuildContext ctx){
    return   Column(
      children: [
        SizedBox(height: 2.h,),
        Padding(
          padding:  EdgeInsets.symmetric(vertical: 2.h,horizontal: 3.w),
          child: Row(children: [
            SizedBox(width: 15.h,),
            Text(widget.title,style: TextStyle(color: C.BASE_BLUE,fontSize: 14.sp,fontWeight: FontWeight.w700),),
            Expanded(child:TransitionImage(Res.IC_HOME_BLUE,width: D.default_80,height: D.default_80,),),
            SizedBox(width: 25.h,),
            IconButton(onPressed: () {
              Navigator.of(ctx).pop();
            }, icon: Icon(Icons.arrow_forward_ios,color: Colors.black,size: D.default_30,),) ,
          ],),
        ),
        SizedBox(height: 3.h,),
        Container(height: 1,color: Colors.grey[200],width: double.infinity,)
      ],
    );
  }
}
