import 'package:alefakaltawinea_animals_app/modules/login/login_screen.dart';
import 'package:alefakaltawinea_animals_app/modules/serviceProviders/details_screen/new_service_provider_details_screen.dart';
import 'package:alefakaltawinea_animals_app/modules/serviceProviders/details_screen/service_provider_details_screen.dart';
import 'package:alefakaltawinea_animals_app/modules/serviceProviders/list_screen/data/serviceProvidersModel.dart';
import 'package:alefakaltawinea_animals_app/shared/components/dialog.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/baseDimentions.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/baseTextStyle.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/myColors.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/myUtils.dart';
import 'package:alefakaltawinea_animals_app/utils/my_widgets/transition_image.dart';
import 'package:alefakaltawinea_animals_app/views/cards/BuyCard/steps/StepOne.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../utils/my_utils/constants.dart';
import '../registeration/registration_screen.dart';

class AdsSliderItem extends StatefulWidget {
  Data AdsItem;
   AdsSliderItem(this.AdsItem) : super();

  @override
  _AdsSliderItemState createState() => _AdsSliderItemState();
}

class _AdsSliderItemState extends State<AdsSliderItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
      },
      child: Stack(
        alignment:AlignmentDirectional.bottomCenter ,
        children: [
        Container(
        width: double.infinity,
        child:Column(children: [
          Expanded(child:
          InkWell(
            onTap: ()async{
              switch(widget.AdsItem.type_id){
                case "0":{
                  MyUtils.navigate(context, NewServiceProviderDetailsScreen(widget.AdsItem));
                }
                  break;
                case "1":{
                  if((widget.AdsItem.url??"").isNotEmpty){
                    _launchURLBrowser(widget.AdsItem.url??"");
                  }else{
                    if(Constants.currentUser!=null){
                      if(Constants.APPLE_PAY_STATE){
                        MyUtils.navigate(context, BuyCard());
                      }else{
                        await Fluttertoast.showToast(msg:tr("Your request has been successfully received") );
                      }
                    }else{
                       msgreguser(context);
                      // MyUtils.navigate(context, LoginScreen());
                    }
                  }
                }
                  break;
                case "2":{
                  if((widget.AdsItem.url??"").isNotEmpty){
                    _launchURLBrowser(widget.AdsItem.url??"");
                  }else{
                    if(Constants.currentUser!=null){
                      if(Constants.APPLE_PAY_STATE){
                        MyUtils.navigate(context, BuyCard());
                      }else{
                        await Fluttertoast.showToast(msg:tr("Your request has been successfully received") );
                      }
                    }else{
                       msgreguser(context);
                      // MyUtils.navigate(context, LoginScreen());
                    }
                  }

                }
                  break;
              }
            },
            child: TransitionImage(
            widget.AdsItem.type_id=="0"?(widget.AdsItem.bannerPhoto??"").contains("https")?widget.AdsItem.bannerPhoto!:"https://alefak.com/uploads/${widget.AdsItem.bannerPhoto}":widget.AdsItem.bannerPhoto??"",
            fit: BoxFit.cover,
            width: double.infinity,
              backgroundColor: Colors.white,
          ),)),
        ],),

        ),
      ],),);
  }
  _launchURLBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Fluttertoast.showToast(msg: tr("cant_opn_url"),backgroundColor: Colors.red,textColor: Colors.white,);
    }
  }
}
