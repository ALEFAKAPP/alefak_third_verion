import 'package:alefakaltawinea_animals_app/modules/baseScreen/baseScreen.dart';
import 'package:alefakaltawinea_animals_app/modules/offers/offers_list/service_provider_offers_list_screen.dart';
import 'package:alefakaltawinea_animals_app/modules/serviceProviders/details_screen/elements/offer_widget.dart';
import 'package:alefakaltawinea_animals_app/modules/serviceProviders/list_screen/data/getServiceProvidersApi.dart';
import 'package:alefakaltawinea_animals_app/modules/serviceProviders/list_screen/data/serviceProvidersModel.dart';
import 'package:alefakaltawinea_animals_app/modules/settings/settings_screen.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/baseDimentions.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/baseTextStyle.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/constants.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/myColors.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/myUtils.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/providers.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/resources.dart';
import 'package:alefakaltawinea_animals_app/utils/my_widgets/transition_image.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../utils/my_utils/input _validation_mixing.dart';


import '../serviceProviders/details_screen/service_provider_details_provider.dart';




class SpHomeScreen extends StatefulWidget {
  SpHomeScreen() ;

  @override
  _SpHomeScreenState createState() => _SpHomeScreenState();
}

class _SpHomeScreenState extends State<SpHomeScreen>with InputValidationMixin {
  final _controller = PageController();
  final _tabsController = PageController();
  bool isOnline=false;

  int _currentSliderPager=0;
  int _currentTab=0;
  Data? provider;

  getProviderData()async{
    GetServiceProvidersApi api=GetServiceProvidersApi();
    await api.getServiceProvider(Constants.currentUser!.id).then((value){
      provider=value.data;
      context.read<ServiceProviderDetailsProvider>().serviceProviderData=provider!;
      if((provider!.offers??[]).isNotEmpty){
        context.read<ServiceProviderDetailsProvider>().selectedOfferIndex=0;
        context.read<ServiceProviderDetailsProvider>().selectedOffer=provider!.offers![context.read<ServiceProviderDetailsProvider>().selectedOfferIndex];
        context.read<ServiceProviderDetailsProvider>().scrollToIndex();
      }
      setState(() {});
    });
  }
  @override
  void initState() {
    getProviderData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
        tag: "",
        showBottomBar: true,
        showSettings: false,
        padding: EdgeInsets.zero,
        body:provider!=null?Column(
          children: [
            SizedBox(height: 20.h,),
            _header(),
           Expanded(child:  Stack(
             alignment: AlignmentDirectional.topEnd,
             children: [
               Container(
                   height: 230.h,
                   color: Colors.grey[200],
                   child:PageView(
                     children: _sliderItem(),
                     controller: _controller,
                     onPageChanged: (currentpage) {
                       setState(() {
                         _currentSliderPager=currentpage;
                       });
                     },
                   )
               ),
               Container(
                 margin: EdgeInsets.only(top:195.h),
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.only(topLeft:Radius.circular(30,),topRight:Radius.circular(30)),
                   color: Colors.white,

                 ),
                 child: Consumer<ServiceProviderDetailsProvider>(
                     builder: (context, _provider,_) {
                       return Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           SizedBox(height: 20.h,),
                           Padding(
                             padding:  EdgeInsets.only(left:D.default_20,right: D.default_10),
                             child: Row(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 Container(
                                   padding: EdgeInsets.all(D.default_5),
                                   margin: EdgeInsets.only(left:D.default_10,right: D.default_10),
                                   width: 48.h,
                                   height: 48.h,
                                   decoration: BoxDecoration(
                                       borderRadius: BorderRadius.circular(D.default_10),
                                       color: Colors.white,
                                       boxShadow:[BoxShadow(
                                           color: Colors.grey.withOpacity(0.1),
                                           blurRadius:4,
                                           spreadRadius: 2
                                       )]
                                   ),
                                   child:TransitionImage(
                                     (provider!.photo??"").contains("https")?(provider!.photo??""):"https://alefak.com/uploads/${(provider!.photo??"")}",
                                     radius: D.default_10,
                                     fit: BoxFit.cover,
                                     width: double.infinity,
                                   ) ,
                                 ),
                                 Expanded(child: Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [
                                     Text(
                                       provider!.name!
                                       ,style: TextStyle(fontSize: 17.sp,fontWeight: FontWeight.w800),),
                                     links(),
                                   ],
                                 ))
                               ],),
                           ),
                           SizedBox(height: 20.h,),
                           Padding(
                             padding:  EdgeInsets.symmetric(horizontal: D.default_10),
                             child: Row(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: List.generate(isOnline?1:2, (index){
                                 return Expanded(
                                   child: Padding(
                                     padding:  EdgeInsets.symmetric(horizontal: 5.w),
                                     child: InkWell(
                                       onTap: (){
                                         setState(() {
                                           _currentTab=index;
                                           _tabsController.animateToPage(index,duration: Duration(milliseconds: 100), curve: Curves.ease);
                                         });
                                       },
                                       child: Column(children: [
                                         Text(index==0?tr("offers"):tr("address"),style: TextStyle(color: _currentTab==index?Colors.black:Colors.grey,fontSize: 18.sp,fontWeight: FontWeight.w800),),
                                         SizedBox(height: 3.h,),
                                         Container(
                                           width:isOnline?double.infinity:D.default_180,
                                           margin: EdgeInsets.symmetric(horizontal:D.default_20),
                                           height: 2.2,color: _currentTab==index?C.BASE_BLUE:Colors.transparent,)
                                       ],),
                                     ),
                                   ),
                                 );
                               }),),
                           ),
                           SizedBox(height: 13.h,),
                           Expanded(child: PageView(
                             children:[
                               (provider!.offers??[]).isNotEmpty?
                               ListView.separated(
                                   padding: EdgeInsets.zero,
                                   controller:_provider.offersController ,
                                   itemBuilder: (ctx,index){
                                     return NewOfferWidget(
                                         onSelect: (selectedOffer){
                                           _provider.onSelectOffer(selectedOffer,index);
                                           _provider.scrollToIndex();
                                         },
                                         offer: provider!.offers![index],
                                         isSelected: _provider.selectedOfferIndex==index);
                                   },
                                   separatorBuilder: (ctx,index){
                                     return SizedBox(height: 5.h,);
                                   }, itemCount:(provider!.offers??[]).length):Center(child: Text(tr("no_offers")),),
                               isOnline?SizedBox():
                               (provider!.addresses??[]).isNotEmpty?
                               ListView.separated(
                                   padding: EdgeInsets.zero,
                                   itemBuilder: (ctx,index){
                                     return addressItem(provider!.addresses![index]);
                                   },
                                   separatorBuilder: (ctx,index){
                                     return SizedBox(height: 5.h,);
                                   },
                                   itemCount:(provider!.addresses??[]).length):
                               Column(children: [
                                 addressItem(AddressModel(
                                   phone:provider!.phone,
                                   contactPhone: provider!.contact_phone,
                                   latitude: provider!.latitude,
                                   longitude: provider!.longitude,
                                   address: provider!.address,
                                   addressEn: provider!.address,

                                 ))
                               ],)
                             ],
                             physics: NeverScrollableScrollPhysics(),
                             controller: _tabsController,
                             onPageChanged: (currentpage) {
                               setState(() {
                                 _currentTab=currentpage;
                               });
                             },
                           ),),
                           (provider!.offers??[]).isNotEmpty
                               ?Container(
                             height: 77.h,
                             width: double.infinity,
                             decoration:BoxDecoration(
                               color: Colors.white,
                             ),
                             padding:  EdgeInsets.symmetric(horizontal:D.default_20,vertical: 2.h),
                             child: Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 Text("${tr("offer_terms")}:",style: TextStyle(color: Color(0xFF565656),fontWeight:FontWeight.w800,fontSize:15.sp ),),
                                 Expanded(child: SingleChildScrollView(
                                   child: Text((List.generate(_provider.selectedOffer.features!.length, (index) =>UtilsProviderModel().isArabic?_provider.selectedOffer.features![index].ar:_provider.selectedOffer.features![index].en)).join(",").replaceAll("-",""),
                                     style: TextStyle(color: Color(0xFF686868),fontSize: 14.sp,height: 1.2),),
                                 ),)
                               ],),
                           ):SizedBox(),

                         ],);
                     }
                 ),
               ),
             ],
           )),
          ],
        ):SizedBox()
    );
  }
  List<Widget >_sliderItem(){
    List<Widget>items=[];
    items.add(
        Container(
          child:
          Column(children: [
            Expanded(child: TransitionImage(
              (provider!.bannerPhoto??"").contains("https")?(provider!.bannerPhoto??""):"https://alefak.com/uploads/${(provider!.bannerPhoto??"")}",
              fit: BoxFit.cover,
              width: double.infinity,
              radius: D.default_10,
            )),

          ],),)
    );
    for(int i=0;i<provider!.photos!.length;i++){
      items.add(
          Container(child:
          Column(children: [
            Expanded(child: TransitionImage(
              provider!.photos![i].photo!,
              fit: BoxFit.cover,
              width: double.infinity,
              radius: D.default_10,
            )),

          ],),)
      );
    }
    return items;
  }
  Widget links(){
    return SizedBox(height: D.default_50,child: ListView(
      scrollDirection: Axis.horizontal,
      children: List.generate((provider!.links??[]).length, (index){
        return linkItem(
            link: provider!.links![index].icon,
            onClick: (){
              _launchURLBrowser(provider!.links![index].link??'');
            });
      }),));

  }
  Widget linkItem({String? link, String? asset,required Function onClick}){
    return InkWell(
      onTap: (){
        onClick();
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: D.default_5,vertical:D.default_10),
        width: D.default_30,
        height: D.default_30,
        decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fitHeight,
              image: (asset!=null?AssetImage(asset??""):NetworkImage(link??"")) as ImageProvider<Object>),
          borderRadius: BorderRadius.circular(D.default_100),
        ),
      ),);
  }

  Widget addressItem(AddressModel address){
    return Container(
      margin: EdgeInsets.symmetric(vertical: D.default_2,horizontal: D.default_20),
      padding: EdgeInsets.symmetric(vertical: D.default_15,horizontal: D.default_10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.grey.withOpacity(0.09),),
      child:Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: D.default_10,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SizedBox(width: D.default_8,),
                    Expanded(child: Text(UtilsProviderModel().isArabic?address.title_ar??provider!.name??"":address.title_en??provider!.name??"",style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w800,overflow:TextOverflow.ellipsis ),)),
                  ],
                ),
                SizedBox(height: D.default_8,),
                InkWell(
                  onTap: (){
                    _launchMapsUrl(double.parse(address.latitude??""), double.parse(address.longitude??""));
                  },
                  child: Row(
                    children: [
                      Icon(Icons.location_on_outlined,color: C.BASE_BLUE,size: 18,),
                      SizedBox(width: D.default_8,),
                      Expanded(child: Text(UtilsProviderModel().isArabic?address.address??"":address.addressEn??'',style: TextStyle(color: Color(0xFF565656),fontSize: 12.sp,fontWeight: FontWeight.w800),)),
                    ],
                  ),
                ),
                SizedBox(height: D.default_8,),
                InkWell(
                  onTap: (){
                    _callPhone(address);
                  },
                  child: Row(
                    children: [
                      Icon(Icons.phone,color: C.BASE_BLUE,size: 18,),
                      SizedBox(width: D.default_8,),
                      Expanded(child: Text((address.contactPhone??"").isNotEmpty?address.contactPhone!:address.phone??"",style: TextStyle(color: Color(0xFF565656),fontSize: 12.sp,fontWeight: FontWeight.w800),),)
                    ],
                  ),
                ),

              ],),
          )


        ],),);
  }

  _callPhone(AddressModel address)async{
    String phone=(address.contactPhone??"").isNotEmpty?
    isPhoneValide((address.contactPhone??''))?
    ('0'+address.contactPhone!):
    (address.contactPhone??''):
    isPhoneValide((address.phone??''))?
    ('0'+address.phone!):
    (address.phone??'');
    final Uri phoneCallUri = Uri(scheme: 'tel', path:phone);
    if (await canLaunch(phoneCallUri.toString())) {
      await launch(phoneCallUri.toString());
    } else {
      Fluttertoast.showToast(msg: tr("cant_call_number"),backgroundColor: Colors.red,textColor: Colors.white,);

    }
  }
  _launchURLBrowser(String link) async {
    if (await canLaunch(link)) {
      await launch(link);
    } else {
      Fluttertoast.showToast(msg: tr("cant_opn_url"),backgroundColor: Colors.red,textColor: Colors.white,);
    }
  }

  void _launchMapsUrl(double lat, double lon) async {
    final url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lon';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Fluttertoast.showToast(msg: tr("cant_opn_url"),backgroundColor: Colors.red,textColor: Colors.white,);

    }
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
              Expanded(child:SizedBox()),
             ],),
          ),
          SizedBox(height: 3.h,),
          Container(height: 1,color: Colors.grey[200],width: double.infinity,)
        ],
      ),
    );
  }


}

