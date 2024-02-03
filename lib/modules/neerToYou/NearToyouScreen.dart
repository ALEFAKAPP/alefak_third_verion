import 'dart:async';

import 'package:alefakaltawinea_animals_app/core/servies/firebase/analytics_helper.dart';
import 'package:alefakaltawinea_animals_app/modules/baseScreen/baseScreen.dart';
import 'package:alefakaltawinea_animals_app/modules/categories_screen/data/categories_model.dart';
import 'package:alefakaltawinea_animals_app/modules/categories_screen/provider/categories_provider_model.dart';
import 'package:alefakaltawinea_animals_app/modules/serviceProviders/details_screen/new_service_provider_details_screen.dart';
import 'package:alefakaltawinea_animals_app/modules/serviceProviders/list_screen/provider/sevice_providers_provicer_model.dart';
import 'package:alefakaltawinea_animals_app/utils/location/location_utils.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/baseDimentions.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/baseTextStyle.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/myColors.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/myUtils.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/resources.dart';
import 'package:alefakaltawinea_animals_app/utils/my_widgets/laoding_view.dart';
import 'package:alefakaltawinea_animals_app/utils/my_widgets/transition_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../serviceProviders/details_screen/service_provider_details_screen.dart';

class NearToYouScreen extends StatefulWidget {
  const NearToYouScreen({Key? key}) : super(key: key);

  @override
  _NearToYouScreenState createState() => _NearToYouScreenState();
}

class _NearToYouScreenState extends State<NearToYouScreen> {
  static Position? _position;
  static final CameraPosition _myCameraPosition = CameraPosition(
      bearing: 0.0,
      tilt: 0.0,
      target: LatLng(_position!.latitude, _position!.longitude));

  ServiceProvidersProviderModel? serviceProvidersProviderModel;
  CategoriesProviderModel? categoriesProviderModel;

  @override
  void initState() {
    super.initState();
    AnalyticsHelper().setScreen(screenName: "شاشة-الأقرب إليك");
    serviceProvidersProviderModel =
        Provider.of<ServiceProvidersProviderModel>(context, listen: false);
    categoriesProviderModel =
        Provider.of<CategoriesProviderModel>(context, listen: false);
    //selectedCategory = categoriesProviderModel!.categoriesList[0];
    getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    serviceProvidersProviderModel =
        Provider.of<ServiceProvidersProviderModel>(context, listen: true);
    categoriesProviderModel =
        Provider.of<CategoriesProviderModel>(context, listen: true);
    return BaseScreen(
        showSettings: false,
        showBottomBar: true,
        tag: "",
        body: Stack(
          children: [
            Container(
              child: Center(
                child: _position != null
                    ? Column(
                        children: [
                          Expanded(
                              child: serviceProvidersProviderModel!.isLoading
                                  ? _buildMap()
                                  : _buildMap()),

                        ],
                      )
                    : LoadingProgress(),
              ),
            ),
            serviceProvidersProviderModel!.currentSelectedShop != null
                ? _shopItem()
                : Container(),
            Positioned(child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
              _newTabsContainer()
            ],)),
            serviceProvidersProviderModel!.isLoading?LoadingProgress():SizedBox()
          ],
        ));
  }

  Future<void> getCurrentLocation() async {
    await LocationUtils.getLocationPermission();
    _position = await Geolocator.getLastKnownPosition().whenComplete(() {
      setState(() {
        _getMyCurrentLocation();
      });
    });
  }

  Widget _buildMap() {
    return GoogleMap(
      minMaxZoomPreference:MinMaxZoomPreference(10, 30),
      initialCameraPosition:
          serviceProvidersProviderModel!.currentCameraPosition != null
              ? serviceProvidersProviderModel!.currentCameraPosition!
              : _myCameraPosition,
      mapType: MapType.normal,
      myLocationEnabled: true,
      myLocationButtonEnabled: false,
      zoomControlsEnabled: true,
      onMapCreated: (GoogleMapController controller) {
        serviceProvidersProviderModel!.mapController.complete(controller);
      },
      markers: serviceProvidersProviderModel!.markers,
    );
  }

  Future<void> _getMyCurrentLocation() async {
    final GoogleMapController controller =
        await serviceProvidersProviderModel!.mapController.future;
    serviceProvidersProviderModel!.currentCameraPosition=CameraPosition(
        bearing: 0.0,
        tilt: 0.0,
        zoom: 14,
        target: LatLng(_position!.latitude, _position!.longitude));
    await controller.animateCamera(CameraUpdate.newCameraPosition(serviceProvidersProviderModel!.currentCameraPosition!));
      await serviceProvidersProviderModel!.getAllClosestList(
          context,
          _position!.latitude.toString(),
          _position!.longitude.toString(),
          categoriesProviderModel!.categoriesList
      );


  }




  Widget _shopItem() {
    return  serviceProvidersProviderModel!.currentSelectedShop!=null?InkWell(
      onTap: (){
        MyUtils.navigate(context, NewServiceProviderDetailsScreen(serviceProvidersProviderModel!.currentSelectedShop!));
      },
      child: Container(
          margin: EdgeInsets.all(D.default_10),
          padding: EdgeInsets.all(D.default_10),
          height: D.default_100,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(D.default_10)),
              border: Border.all(color: Color(serviceProvidersProviderModel!.selectedCategory!=null?int.parse(serviceProvidersProviderModel!.selectedCategory!.color!.replaceAll("#", "0xff")):serviceProvidersProviderModel!.selectedMarkerColor!)),
              color: Colors.white,
              boxShadow:[BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  offset:Offset(4,4),
                  blurRadius:4,
                  spreadRadius: 2
              )]
          ),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(D.default_10)),
                  color: Colors.white,
                  border: Border.all(color: Color(serviceProvidersProviderModel!.selectedCategory!=null?int.parse(serviceProvidersProviderModel!.selectedCategory!.color!.replaceAll("#", "0xff")):serviceProvidersProviderModel!.selectedMarkerColor!))
                ),
                margin: EdgeInsets.all(D.default_10),
                child: TransitionImage(
                  "${serviceProvidersProviderModel!.currentSelectedShop!.photo}",
                  fit: BoxFit.cover,
                  radius: D.default_10,
                ),
              ),
              Expanded(
                  child: Text(
                "${serviceProvidersProviderModel!.currentSelectedShop!.name}",
                style: S.h4(color: Color(serviceProvidersProviderModel!.selectedCategory!=null?int.parse(serviceProvidersProviderModel!.selectedCategory!.color!.replaceAll("#", "0xff")):serviceProvidersProviderModel!.selectedMarkerColor!))),
              )
            ],
          )),
    ):Container();
  }
  Widget _newIem(int index) {
    return InkWell(
      onTap: (){
        onItemClick(index);
      },
      child: Container(
      margin: EdgeInsets.all(D.default_10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(D.default_10),
          color: Colors.white,
          boxShadow:[BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius:1,
              spreadRadius: 1
          )]
      ),
      child: Column(children: [
        SizedBox(height: 5.h,),
        Expanded(
            child: TransitionImage(
              getItemImage(index),
            )),
        SizedBox(height: 3.h,),
        Container(
          height: D.default_30,
          child: Center(
            child: Text(getItemTitle(index),
                style: TextStyle(color: C.BASE_BLUE,fontWeight: FontWeight.w600,fontSize: 12.sp)),
          ),),
        SizedBox(height: 5.h,)
      ],),),);
  }
  String getItemImage(int index){
      return categoriesProviderModel!.categoriesList.where((element) => (element.id??0)==1||(element.id??0)==4).toList()[index].photo??Res.IC_HOME_BLUE;
  }
  String getItemTitle(int index){
    return categoriesProviderModel!.categoriesList.where((element) => (element.id??0)==1||(element.id??0)==4).toList()[index].name??"";
  }
  onItemClick(int index)async{
      serviceProvidersProviderModel!.markers.clear();
      await serviceProvidersProviderModel!.getClosestList(
            context,
          categoriesProviderModel!.categoriesList.where((element) => (element.id??0)==1||(element.id??0)==4).toList()[index].id??0,
            _position!.latitude.toString(),
            _position!.longitude.toString(),
          categoriesProviderModel!.categoriesList.where((element) => (element.id??0)==1||(element.id??0)==4).toList()
        );
  }
  Widget _newTabsContainer(){
    return Container(
      padding: EdgeInsets.only(top: 10.h),
        decoration:BoxDecoration(
            borderRadius: BorderRadius.only(topRight:Radius.circular(D.default_15),topLeft:Radius.circular(D.default_10)),
          color: Colors.black.withOpacity(0.6),
        ),
      height: D.size(88),
      child: Column(children: [
      Expanded(child: Row(children:List.generate(
          categoriesProviderModel!.categoriesList.where((element) => (element.id??0)==1||(element.id??0)==4).toList().length,
              (index) {
        return Expanded(child: _newIem(index));
      }),),),
        SizedBox(height:5.h,),
        InkWell(
          onTap: ()async{
            serviceProvidersProviderModel!.selectedCategory =null;
            await serviceProvidersProviderModel!.getAllClosestList(
            context,
            _position!.latitude.toString(),
            _position!.longitude.toString(),
            categoriesProviderModel!.categoriesList.where((element) => (element.id??0)==1||(element.id??0)==4).toList(),
            );
          },
          child: Container(
          margin: EdgeInsets.symmetric(horizontal:5.w),
          padding: EdgeInsets.all(10.h),
    decoration:BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(D.default_15)),
    color: Colors.white,
    ),
          child: Center(child: Text(tr("all"), style:TextStyle(color: C.BASE_BLUE,fontWeight: FontWeight.w600,fontSize: 12.sp)),),),
        ),
        SizedBox(height:10.h,)

    ]),);
  }
}
