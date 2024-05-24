import 'package:alefakaltawinea_animals_app/core/servies/firebase/analytics_helper.dart';
import 'package:alefakaltawinea_animals_app/modules/baseScreen/baseScreen.dart';
import 'package:alefakaltawinea_animals_app/modules/offers/offers_list/service_provider_offers_list_screen.dart';
import 'package:alefakaltawinea_animals_app/modules/serviceProviders/details_screen/elements/offer_widget.dart';
import 'package:alefakaltawinea_animals_app/modules/serviceProviders/details_screen/new_offer_details_screen.dart';
import 'package:alefakaltawinea_animals_app/modules/serviceProviders/details_screen/service_provider_details_provider.dart';
import 'package:alefakaltawinea_animals_app/modules/serviceProviders/list_screen/data/serviceProvidersModel.dart';
import 'package:alefakaltawinea_animals_app/shared/constance/fonts.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/baseDimentions.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/baseTextStyle.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/constants.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/myColors.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/my_fonts.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/providers.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/resources.dart';
import 'package:alefakaltawinea_animals_app/utils/my_widgets/transition_image.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import '../../../utils/my_utils/input _validation_mixing.dart';
import '../../../utils/my_widgets/laoding_view.dart';
import '../../cart/provider/cart_provider.dart';


class NewServiceProviderDetailsScreen extends StatefulWidget {
  Data serviceProviderData;
  final int? offerIndex;
  NewServiceProviderDetailsScreen(this.serviceProviderData,{this.offerIndex}) ;

  @override
  _NewServiceProviderDetailsScreenState createState() => _NewServiceProviderDetailsScreenState();
}

class _NewServiceProviderDetailsScreenState extends State<NewServiceProviderDetailsScreen> with InputValidationMixin{
  final _controller = PageController();
  final _tabsController = PageController();
  bool isOnline=false;
  double searchWidth=0;
  TextEditingController _searchController=TextEditingController();
  bool _isExpanded = false;
  void _toggleWidth() {
    setState(() {
      _isExpanded = !_isExpanded;
      searchWidth = _isExpanded ? 225.w : 0; // Change width based on the toggle
    });
  }


  int _currentSliderPager=0;
  int _currentTab=0;
  @override
  void initState() {
    super.initState();
    AnalyticsHelper().setScreen(screenName: "شاشة-مزود الخدمة");
    AnalyticsHelper().setEvent(eventName: "شاشة-مزود الخدمة",parameters: {
      "name":"${widget.serviceProviderData.name}",
      "phone":"${widget.serviceProviderData.phone}"
    });
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      context.read<ServiceProviderDetailsProvider>().getShop(widget.serviceProviderData.id??0);

      if(Constants.currentUser!=null){
        if(context.read<CartProvider>().myCarts.isEmpty){
          await context.read<CartProvider>().getMyCart();
        }
      }

    });



    isOnline=(widget.serviceProviderData.isOnline??"0")=="1";
    //context.read<ServiceProviderDetailsProvider>().serviceProviderData=widget.serviceProviderData;
    /*if((widget.serviceProviderData.offers??[]).isNotEmpty){
      context.read<ServiceProviderDetailsProvider>().selectedOfferIndex=widget.offerIndex??0;
      context.read<ServiceProviderDetailsProvider>().selectedOffer=widget.serviceProviderData.offers![context.read<ServiceProviderDetailsProvider>().selectedOfferIndex];
      context.read<ServiceProviderDetailsProvider>().scrollToIndex();
    }*/

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:false,
      body: Consumer<ServiceProviderDetailsProvider>(
        builder: (_,data,___) {
          return data.isLoading?LoadingProgress():data.serviceProviderData==null?SizedBox():GestureDetector(
            onTap: (){
              FocusManager.instance.primaryFocus!.unfocus();
            },
            child: Stack(
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
                      builder: (context, provider,_) {
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
                                      (data.serviceProviderData.photo??"").contains("https")?(data.serviceProviderData.photo??""):"https://alefak.com/uploads/${(data.serviceProviderData.photo??"")}",
                                      radius: D.default_10,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                    ) ,
                                  ),
                                  Expanded(child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data.serviceProviderData.name!
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
                                data.serviceProviderData.classifications!.isNotEmpty?
                                ListView.separated(
                                    padding: EdgeInsets.zero,
                                    controller:provider.offersController ,
                                    itemBuilder: (ctx,index){
                                      return classificationItem(index);
                                    },
                                    separatorBuilder: (ctx,index){
                                      return SizedBox(height: 5.h,);
                                    }, itemCount:(data.serviceProviderData.classifications??[]).length):Center(child: Text(tr("no_offers")),),
                                isOnline?SizedBox():
                                (data.serviceProviderData.addresses??[]).isNotEmpty?
                                ListView.separated(
                                    padding: EdgeInsets.zero,
                                    itemBuilder: (ctx,index){
                                      return addressItem(data.serviceProviderData.addresses![index]);
                                    },
                                    separatorBuilder: (ctx,index){
                                      return SizedBox(height: 5.h,);
                                    },
                                    itemCount:(data.serviceProviderData.addresses??[]).length):
                                Column(children: [
                                  addressItem(AddressModel(
                                    phone:data.serviceProviderData.phone,
                                    contactPhone: data.serviceProviderData.contact_phone,
                                    latitude: data.serviceProviderData.latitude,
                                    longitude: data.serviceProviderData.longitude,
                                    address: data.serviceProviderData.address,
                                    addressEn: data.serviceProviderData.address,

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
                            (provider.serviceProviderData.offers??[]).isNotEmpty
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
                                    child: Text((List.generate(provider.selectedOffer.features!.length, (index) =>UtilsProviderModel().isArabic?provider.selectedOffer.features![index].ar:provider.selectedOffer.features![index].en)).join("\n"),

                                      style: TextStyle(color: Color(0xFF686868),fontSize: 14.sp,height: 1.4),),
                                  ),)
                                ],),
                            ):SizedBox(),


                            (provider.serviceProviderData.offers??[]).isNotEmpty?
                            Container(
                              color:Colors.white,
                              padding: EdgeInsets.symmetric(vertical:D.default_10),
                              child: Column(children: [
                                InkWell(
                                  onTap: (){
                                    provider.showBottomSheet(context);
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(top:1.h,left: 20.w,right: 20.w),
                                    padding: EdgeInsets.all(10.h),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: C.BASE_BLUE,
                                        boxShadow:[BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            offset:Offset(1,1),
                                            blurRadius:1,
                                            spreadRadius: 0.5
                                        )]
                                    ),
                                    child: Center(child: Text(tr("use_offer"),style: TextStyle(color: Colors.white,fontSize: 16.sp,fontWeight: FontWeight.w800),),),
                                  ),
                                ),SizedBox(height:20.h,)
                              ],),):SizedBox()

                          ],);
                      }
                  ),
                ),
                Row(
                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: SizedBox()),
                   /* Container(
                      margin: EdgeInsets.symmetric(vertical:40.h,horizontal: 10.w),
                      padding: EdgeInsets.all(2.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.white.withOpacity(0.8),

                      ),
                      child: Row(children: [
                        IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: (){
                            if(_isExpanded){
                              FocusManager.instance.primaryFocus!.unfocus();
                            }
                            if(_searchController.text.isEmpty){
                              _toggleWidth();
                            }
                          },
                          icon: Icon(Icons.search,size: 25,),),
                        AnimatedContainer(
                          duration: Duration(milliseconds: 200),
                          width: searchWidth,
                          child: TextField(
                            controller: _searchController,
                            style: TextStyle(color:Colors.black ,fontSize: 12.sp,fontFamily:fontPrimaryBold),
                            decoration: InputDecoration(
                              hintText: tr("search_for_offer"),
                              hintStyle: TextStyle(color: Colors.grey,fontSize: 12.sp,fontFamily:fontPrimaryBold),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.transparent),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color:Colors.transparent),
                              ),
                              border: UnderlineInputBorder(
                                  borderSide: BorderSide(color:Colors.transparent)),
                              errorStyle: S.h4(color: Colors.red),
                              contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                            ),
                            onChanged: (value){
                              setState(() {

                              });
                            },

                          ),
                        )
                      ],),),*/
                    Container(
                      margin: EdgeInsets.symmetric(vertical:40.h,horizontal: 10.w),
                      padding: EdgeInsets.all(2.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.white.withOpacity(0.8),

                      ),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_forward_ios,size: 20,),),)
                  ],),
              ],
            ),
          );
        }
      ),
    );
  }
  List<Widget >_sliderItem(){
    List<Widget>items=[];
    items.add(
        Container(
          child:
          Column(children: [
            Expanded(child: TransitionImage(
              (context.read<ServiceProviderDetailsProvider>()
                  .serviceProviderData.bannerPhoto??"").contains("https")?(context.read<ServiceProviderDetailsProvider>().serviceProviderData.bannerPhoto??""):"https://alefak.com/uploads/${(context.read<ServiceProviderDetailsProvider>().serviceProviderData.bannerPhoto??"")}",
              fit: BoxFit.cover,
              width: double.infinity,
              radius: D.default_10,
            )),

          ],),)
    );
    for(int i=0;i<context.read<ServiceProviderDetailsProvider>().serviceProviderData.photos!.length;i++){
      items.add(
          Container(child:
          Column(children: [
            Expanded(child: TransitionImage(
              context.read<ServiceProviderDetailsProvider>().serviceProviderData.photos![i].photo!,
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
      children: List.generate((context.read<ServiceProviderDetailsProvider>().serviceProviderData.links??[]).length, (index){
          return linkItem(
              link: context.read<ServiceProviderDetailsProvider>().serviceProviderData.links![index].icon,
              onClick: (){
                _launchURLBrowser(context.read<ServiceProviderDetailsProvider>().serviceProviderData.links![index].link??'');
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
                    Expanded(child: Text(UtilsProviderModel().isArabic?address.title_ar??context.read<ServiceProviderDetailsProvider>().serviceProviderData.name??"":address.title_en??context.read<ServiceProviderDetailsProvider>().serviceProviderData.name??"",style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w800,overflow:TextOverflow.ellipsis ),)),
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
  Widget classificationItem(int index){
    return Column(children: [
      SizedBox(height: 2.h,),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: (){
                setState(() {
                  context.read<ServiceProviderDetailsProvider>().serviceProviderData.classifications![index].isExpanded=!(context.read<ServiceProviderDetailsProvider>().serviceProviderData.classifications![index].isExpanded??false);
                });
              },
              child:Row(
                mainAxisAlignment:MainAxisAlignment.spaceBetween,
                children: [
                  Container(

                    width: 50.h,
                    height: 40.h,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                          image: NetworkImage(context.read<ServiceProviderDetailsProvider>().serviceProviderData.bannerPhoto??'')),
                        borderRadius: BorderRadius.only(topRight:Radius.circular(10),bottomRight:Radius.circular(15)),
                        color: Colors.white,
                    ),
                  ),
                  SizedBox(width:4.w,),
                  Expanded(
                    child: Container(
                      height: 40.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(topLeft:Radius.circular(15),bottomLeft:Radius.circular(15)),
                        color: C.BASE_BLUE,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child:Text(context.read<ServiceProviderDetailsProvider>().serviceProviderData.classifications![index].name??'',textAlign:
                              TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 18.sp,fontWeight: FontWeight.w800),),

                          ),
                          Container(
                            padding: EdgeInsets.all(8.w),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(50)),
                              color: Colors.white,
                            ),
                            child: Image.asset((context.read<ServiceProviderDetailsProvider>().serviceProviderData.classifications![index].isExpanded??false)?"assets/images/dropdown_up.png":'assets/images/dropdown_arrow_down.png',
                              width: 15.w,
                              height:15.w ,
                            ),
                          ),
                          SizedBox(width:8.w,)
                        ],
                      ),
                    ),
                  ),

                ],),
            ),
            SizedBox(height: 8.h,),
            Visibility(
              visible: context.read<ServiceProviderDetailsProvider>().serviceProviderData.classifications![index].isExpanded??false,
              child: Column(children: List.generate((context.read<ServiceProviderDetailsProvider>().serviceProviderData.classifications![index].offers??[]).length, (offerIndex){
                return Container(
                  padding: EdgeInsets.symmetric(vertical: 8.h,horizontal: 10.w),
                  margin: EdgeInsets.symmetric(vertical: 5.h,),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color(0xffF6F6F6),
                  ),
                  child: GestureDetector(
                    onTap: (){
                      Get.to(NewOfferDetailsScreen(serviceProvider: context.read<ServiceProviderDetailsProvider>().serviceProviderData, offer: (context.read<ServiceProviderDetailsProvider>().serviceProviderData.classifications![index].offers??[])[offerIndex],));
                    },
                    child: Row(
                      crossAxisAlignment:  CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset("assets/images/offer_search_radio.png",width: 20.w,height: 20.w,),

                          ],),
                        SizedBox(width: 13.w,),
                        Expanded(child: Column(
                          crossAxisAlignment:CrossAxisAlignment.start,
                          children: [
                            Text(context.read<ServiceProviderDetailsProvider>().serviceProviderData.classifications![index].offers![offerIndex].title??'',style: TextStyle(fontWeight:FontWeight.w800,fontSize: 14.sp),),
                            SizedBox(height: 3.h,),
                            Row(
                              children: [
                                Expanded(child: Text(context.read<ServiceProviderDetailsProvider>().serviceProviderData.classifications![index].offers![offerIndex].description_ar??'',style: TextStyle(fontWeight:FontWeight.w500,fontSize: 12.sp),)),
                                SizedBox(width:3.w),
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 1.h,horizontal: 8.w),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Color(0xff1BB1CC),
                                  ),
                                  child: Row(children: [
                                    Text(tr("details"),style: TextStyle(color: Colors.white,fontSize: 12.sp,),),
                                    SizedBox(width: 10.w,),
                                    Icon(Icons.arrow_forward_ios,size: 12.w,color: Colors.white,)
                                  ],),)
                              ],
                            ),

                          ],
                        )),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [

                          ],),
                      ],),
                  ),);
              }),),
            )
          ],
        ),
      ),
      SizedBox(height: 2.h,),
    ],);
  }

}
