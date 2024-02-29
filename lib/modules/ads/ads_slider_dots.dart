import 'package:alefakaltawinea_animals_app/modules/ads/provider/ads_slider_provider.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/baseDimentions.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/myColors.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AdsSliderDots extends StatelessWidget {
  int _itemCount;
  int _position;
   AdsSliderDots(this._itemCount,this._position) ;
  AdsSliderProviderModel?adsSliderProviderModel;


  @override
  Widget build(BuildContext context) {
    adsSliderProviderModel=Provider.of<AdsSliderProviderModel>(context,listen: true);

    return adsSliderProviderModel!.adsSliderModelList.isNotEmpty?Container(
      color: Colors.grey.withOpacity(0.7),
      width: double.infinity,
      height: 7.h,
      child: Center(
        child: Container(
            width: adsSliderProviderModel!.adsSliderModelList.length*30.w,
            decoration:  BoxDecoration(
              color: Colors.white.withOpacity(0.5),
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            child: Row(children:List.generate(adsSliderProviderModel!.adsSliderModelList.length, (index){
              return Container(
                  height: 7.h,
                  width: 30.w,
                  decoration:  BoxDecoration(
                    color: index==_position?C.BASE_BLUE:Colors.transparent,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  )
              );
            }),)),
      ),):Container();
  }
  

}
