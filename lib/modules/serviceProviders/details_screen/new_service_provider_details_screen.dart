import 'package:alefakaltawinea_animals_app/core/servies/firebase/analytics_helper.dart';
import 'package:alefakaltawinea_animals_app/modules/baseScreen/baseScreen.dart';
import 'package:alefakaltawinea_animals_app/modules/offers/offers_list/service_provider_offers_list_screen.dart';
import 'package:alefakaltawinea_animals_app/modules/serviceProviders/list_screen/data/serviceProvidersModel.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/baseDimentions.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/baseTextStyle.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/myColors.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/my_fonts.dart';
import 'package:alefakaltawinea_animals_app/utils/my_widgets/transition_image.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../utils/my_utils/input _validation_mixing.dart';
import '../../../utils/my_widgets/action_bar_widget.dart';


class NewServiceProviderDetailsScreen extends StatefulWidget {
  Data serviceProviderData;
  NewServiceProviderDetailsScreen(this.serviceProviderData) ;

  @override
  _NewServiceProviderDetailsScreenState createState() => _NewServiceProviderDetailsScreenState();
}

class _NewServiceProviderDetailsScreenState extends State<NewServiceProviderDetailsScreen> with InputValidationMixin{
  final _controller = PageController();
  final _tabsController = PageController();

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

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            Container(
              height: D.default_300,
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
            Positioned(
              child: Container(
                margin: EdgeInsets.only(top:D.default_250),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft:Radius.circular(D.default_20,),topRight:Radius.circular(D.default_20)),
                  color: Colors.white,
                ),
                child: Column(children: [
                  Padding(
                    padding:  EdgeInsets.symmetric(vertical:D.default_20,horizontal: D.default_10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      Container(
                        padding: EdgeInsets.all(D.default_5),
                        margin: EdgeInsets.only(left:D.default_10,right: D.default_10),
                        width: D.default_70,
                        height: D.default_70,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(D.default_10),
                            color: Colors.white,
                            boxShadow:[BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
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
                      Expanded(child: Text(
                        widget.serviceProviderData.name!
                        ,style: S.h1Bold(),))
                    ],),
                  ),
                  Padding(
                    padding:  EdgeInsets.symmetric(vertical:D.default_20,horizontal: D.default_10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(2, (index){
                        return Expanded(
                          child: Padding(
                            padding:  EdgeInsets.symmetric(horizontal: D.default_10),
                            child: Column(children: [
                              Text(index==0?tr("offers"):tr("address"),style: S.h1Bold(color: _currentTab==index?Colors.black:Colors.grey),),
                              SizedBox(height: D.default_8,),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal:D.default_20),
                                height: 2,color: _currentTab==index?C.BASE_BLUE:Colors.transparent,width: double.infinity,)
                            ],),
                          ),
                        );
                      }),),
                  ),
                  Expanded(child: PageView(
                    children:[
                      ServiceProviderOffersScreen(widget.serviceProviderData),
                      Container()
                    ],
                    controller: _tabsController,
                    onPageChanged: (currentpage) {
                      setState(() {
                        _currentTab=currentpage;
                      });
                    },
                  ),),
                  Text("${tr("offer_terms")}:",style: S.h2(color: Colors.grey),),


                  Container(
                    color:Colors.white,
                    padding: EdgeInsets.symmetric(vertical:D.default_10),
                    child: Column(children: [
                    InkWell(
                      onTap: (){
                        ///use offer
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal:D.default_50),
                        padding: EdgeInsets.all(D.default_10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(D.default_15),
                            color: C.BASE_BLUE,
                            boxShadow:[BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                offset:Offset(1,1),
                                blurRadius:1,
                                spreadRadius: 0.5
                            )]
                        ),
                        child: Center(child: Text(tr("use_offer"),style: S.h1Bold(color: Colors.white),),),
                      ),
                    ),SizedBox(height: D.default_50,)
                  ],),)

                ],),
              ),
            )
            /*Column(children: [
              //ActionBarWidget("", context,textColor:Colors.transparent,showSearch:false, backgroundColor: Colors.white),
              //_infoCard(),
              Expanded(child: )
            ],),*/
          ],
        )
    );
  }
  Widget _infoCard(){
    return Column(children: [
      Container(
        height: D.default_100*3,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(0),
            color: Colors.white,
            boxShadow:[BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                offset:Offset(3,3),
                blurRadius:3,
                spreadRadius: 0.5
            )]
        ),
        child: Stack(children: [
          Column(children: [
            Expanded(child: Container(child: Column(children: [
              Expanded(child: Container(
                  margin: EdgeInsets.only(left: D.default_10,right: D.default_10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(D.default_10),
                      color: Colors.white,
                      boxShadow:[BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          offset:Offset(3,3),
                          blurRadius:3,
                          spreadRadius: 0.5
                      )]
                  ),
                  child:PageView(
                    children: _sliderItem(),
                    controller: _controller,
                    onPageChanged: (currentpage) {
                      setState(() {
                        _currentSliderPager=currentpage;
                      });
                    },
                  )
              )),
              Container(
                  margin: EdgeInsets.only(top: D.default_10),
                  child: Center(child: Text(
                    widget.serviceProviderData.name!
                    ,style: S.h4(color:C.BASE_BLUE,font: MyFonts.VazirBlack),),)),
              Container(
                color: Colors.white,
                width: double.infinity,
                height: D.default_20,
                margin: EdgeInsets.only(bottom: D.default_5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DotsIndicator(
                      dotsCount: widget.serviceProviderData.photos!.isNotEmpty?widget.serviceProviderData.photos!.length+1:1,
                      position: widget.serviceProviderData.photos!.isNotEmpty?
                      _currentSliderPager.toDouble():0,
                      decorator: DotsDecorator(
                          color: C.BASE_BLUE.withOpacity(0.3),
                          activeColor: C.BASE_BLUE,
                          activeSize:Size(D.default_10,D.default_10),
                          size:Size(D.default_10,D.default_10),
                          spacing:EdgeInsets.all(D.default_5)
                      ),
                    )

                  ],
                ),)
            ],),)),
            Container(
              margin: EdgeInsets.only(bottom:D.default_10,left:D.default_20,right:D.default_20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(children: [
                    Container(
                      child: Icon(Icons.add_location_alt,color: Colors.grey,size: D.default_20,),),
                    Expanded(child: Container(
                      padding:EdgeInsets.only(left:D.default_10,right:D.default_10,bottom: D.default_5),
                      child: Text(widget.serviceProviderData.address!,style: S.h4(color: Colors.grey),),)),
                    InkWell(onTap: (){
                      _launchMapsUrl(
                          widget.serviceProviderData.latitude!.isNotEmpty?double.parse(widget.serviceProviderData.latitude!):0.0,
                          widget.serviceProviderData.longitude!.isNotEmpty?double.parse(widget.serviceProviderData.longitude!):0.0);
                    },child:  Container(
                      padding: EdgeInsets.only(left: D.default_10,right: D.default_10,top: D.default_5,bottom: D.default_5),
                      decoration: BoxDecoration(
                          color: C.BASE_BLUE,
                          borderRadius: BorderRadius.circular(D.default_10),
                          boxShadow:[BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              offset:Offset(2,2),
                              blurRadius:2,
                              spreadRadius: 0.5
                          )]
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.share_location,color: Colors.white,size: D.default_20,),
                          Text(tr("show_map"),style: S.h5(color: Colors.white),),

                        ],),
                    ),)

                  ],),
                  InkWell(onTap: ()async{
                    String phone=(widget.serviceProviderData.contact_phone??"").isNotEmpty?
                    isPhoneValide((widget.serviceProviderData.contact_phone??''))?
                    ('0'+widget.serviceProviderData.contact_phone!):
                    (widget.serviceProviderData.contact_phone??''):
                    isPhoneValide((widget.serviceProviderData.phone??''))?
                    ('0'+widget.serviceProviderData.phone!):
                    (widget.serviceProviderData.phone??'');
                    final Uri phoneCallUri = Uri(scheme: 'tel', path:phone);
                    if (await canLaunch(phoneCallUri.toString())) {
                      await launch(phoneCallUri.toString());
                    } else {
                      throw 'Could not launch phone call';
                    }

                  },child: Row(children: [
                    Container(
                      child: Icon(Icons.local_phone,color: C.BASE_BLUE,size: D.default_20,),),
                    Container(
                      padding:EdgeInsets.only(left:D.default_10,right:D.default_10),
                      child: Text("${widget.serviceProviderData.contact_phone!.isNotEmpty?widget.serviceProviderData.contact_phone:
                      widget.serviceProviderData.phone}",style: S.h4(color: C.BASE_BLUE),),),
                    (widget.serviceProviderData.website??"").isNotEmpty?InkWell(onTap: ()async{
                      await _launchURLBrowser();
                    },
                      child: Container(
                        padding:EdgeInsets.only(left:D.default_10,right:D.default_10),
                        child: Text(widget.serviceProviderData.website!,style: S.h4(color: Colors.grey),),),):Container()

                  ],),),

                ],),)

          ],),
          Positioned(child: Container(
            padding: EdgeInsets.all(D.default_5),
            margin: EdgeInsets.only(left:D.default_10,right: D.default_10),
            width: D.default_60,
            height: D.default_60,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(D.default_5),
                color: Colors.white,
                boxShadow:[BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    offset:Offset(4,4),
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
          ),),

        ],),
      ),

    ],);
  }
  _launchURLBrowser() async {
    final String ure=widget.serviceProviderData.website??"";
    String  url = ure;
    if (await canLaunch(url)) {
      await launch(url);
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

}
