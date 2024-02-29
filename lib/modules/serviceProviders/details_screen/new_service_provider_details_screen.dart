import 'package:alefakaltawinea_animals_app/core/servies/firebase/analytics_helper.dart';
import 'package:alefakaltawinea_animals_app/modules/baseScreen/baseScreen.dart';
import 'package:alefakaltawinea_animals_app/modules/offers/offers_list/service_provider_offers_list_screen.dart';
import 'package:alefakaltawinea_animals_app/modules/serviceProviders/details_screen/elements/offer_widget.dart';
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
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import '../../../utils/my_utils/input _validation_mixing.dart';
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
    if(Constants.currentUser!=null){

      if(context.read<CartProvider>().myCarts.isEmpty){
        context.read<CartProvider>().getMyCart();
      }
    }
    AnalyticsHelper().setScreen(screenName: "شاشة-مزود الخدمة");
    AnalyticsHelper().setEvent(eventName: "شاشة-مزود الخدمة",parameters: {
      "name":"${widget.serviceProviderData.name}",
      "phone":"${widget.serviceProviderData.phone}"
    });
    isOnline=(widget.serviceProviderData.isOnline??"0")=="1";
    context.read<ServiceProviderDetailsProvider>().serviceProviderData=widget.serviceProviderData;
    if((widget.serviceProviderData.offers??[]).isNotEmpty){
      context.read<ServiceProviderDetailsProvider>().selectedOfferIndex=widget.offerIndex??0;
      context.read<ServiceProviderDetailsProvider>().selectedOffer=widget.serviceProviderData.offers![context.read<ServiceProviderDetailsProvider>().selectedOfferIndex];
      context.read<ServiceProviderDetailsProvider>().scrollToIndex();
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:false,
      body: GestureDetector(
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
                                  (widget.serviceProviderData.photo??"").contains("https")?(widget.serviceProviderData.photo??""):"https://alefak.com/uploads/${(widget.serviceProviderData.photo??"")}",
                                  radius: D.default_10,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ) ,
                              ),
                              Expanded(child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.serviceProviderData.name!
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
                            (widget.serviceProviderData.offers??[]).where((element) => (element.title??"").contains(_searchController.text)).toList().isNotEmpty?
                            ListView.separated(
                                padding: EdgeInsets.zero,
                                controller:provider.offersController ,
                                itemBuilder: (ctx,index){
                                  return NewOfferWidget(
                                      onSelect: (selectedOffer){
                                        provider.onSelectOffer(selectedOffer,index);
                                        provider.scrollToIndex();
                                      },
                                      offer: (widget.serviceProviderData.offers??[]).where((element) => (element.title??"").contains(_searchController.text)).toList()[index],
                                      isSelected: provider.selectedOfferIndex==index);
                                },
                                separatorBuilder: (ctx,index){
                                  return SizedBox(height: 5.h,);
                                }, itemCount:(widget.serviceProviderData.offers??[]).where((element) => (element.title??"").contains(_searchController.text)).toList().length):Center(child: Text(tr("no_offers")),),
                            isOnline?SizedBox():
                            (widget.serviceProviderData.addresses??[]).isNotEmpty?
                            ListView.separated(
                                padding: EdgeInsets.zero,
                                itemBuilder: (ctx,index){
                                  return addressItem(widget.serviceProviderData.addresses![index]);
                                },
                                separatorBuilder: (ctx,index){
                                  return SizedBox(height: 5.h,);
                                },
                                itemCount:(widget.serviceProviderData.addresses??[]).length):
                            Column(children: [
                              addressItem(AddressModel(
                                phone:widget.serviceProviderData.phone,
                                contactPhone: widget.serviceProviderData.contact_phone,
                                latitude: widget.serviceProviderData.latitude,
                                longitude: widget.serviceProviderData.longitude,
                                address: widget.serviceProviderData.address,
                                addressEn: widget.serviceProviderData.address,

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
                Container(
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
                  ],),),
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
              (widget.serviceProviderData.bannerPhoto??"").contains("https")?(widget.serviceProviderData.bannerPhoto??""):"https://alefak.com/uploads/${(widget.serviceProviderData.bannerPhoto??"")}",
              fit: BoxFit.cover,
              width: double.infinity,
              radius: D.default_10,
            )),

          ],),)
    );
    for(int i=0;i<widget.serviceProviderData.photos!.length;i++){
      items.add(
          Container(child:
          Column(children: [
            Expanded(child: TransitionImage(
              widget.serviceProviderData.photos![i].photo!,
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
      children: List.generate((widget.serviceProviderData.links??[]).length, (index){
          return linkItem(
              link: widget.serviceProviderData.links![index].icon,
              onClick: (){
                _launchURLBrowser(widget.serviceProviderData.links![index].link??'');
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
                    Expanded(child: Text(UtilsProviderModel().isArabic?address.title_ar??widget.serviceProviderData.name??"":address.title_en??widget.serviceProviderData.name??"",style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w800,overflow:TextOverflow.ellipsis ),)),
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

}
