import 'package:alefakaltawinea_animals_app/modules/ads/ads_slider_item.dart';
import 'package:alefakaltawinea_animals_app/modules/ads/provider/ads_slider_provider.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/baseDimentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../utils/my_utils/myColors.dart';
import 'ads_slider_dots.dart';

class AdsSlider extends StatefulWidget {
  const AdsSlider({Key? key}) : super(key: key);

  @override
  _AdsSliderState createState() => _AdsSliderState();
}

class _AdsSliderState extends State<AdsSlider> {
  AdsSliderProviderModel?adsSliderProviderModel;
  final _controller = PageController();
  int _currentSliderPager=0;
  @override
  void initState() {
    super.initState();
    adsSliderProviderModel=Provider.of<AdsSliderProviderModel>(context,listen: false);
    _outoslid();
  }
  @override
  Widget build(BuildContext context) {
    adsSliderProviderModel=Provider.of<AdsSliderProviderModel>(context,listen: true);
    return Container(
      height: 130.h,
      child: Stack(
        alignment:AlignmentDirectional.bottomCenter ,
        children: [
      PageView(
        children: sliderItems(),
        controller: _controller,
        onPageChanged: (currentpage) {
          setState(() {
            _currentSliderPager=currentpage;
          });
        },

      ),
      AdsSliderDots(adsSliderProviderModel!.adsSliderModelList.length,_currentSliderPager)
    ],),);
  }
  List<Widget> sliderItems(){
    List<Widget> slids=[];
    for(int i=0;i<adsSliderProviderModel!.adsSliderModelList.length;i++){
      slids.add(AdsSliderItem(adsSliderProviderModel!.adsSliderModelList[i]));
    }
    return slids;
  }
  void _outoslid(){
    Future.delayed(Duration(milliseconds: 3000)).then((value) {
    if(_controller.page!.toInt()<adsSliderProviderModel!.adsSliderModelList.length-1) {
        _controller.animateToPage(_controller.page!.toInt()+1, duration: Duration(milliseconds: 500), curve: Curves.ease);
        _outoslid();
    }else{
          _controller.animateToPage(0, duration: Duration(milliseconds: 500), curve: Curves.ease);
          _outoslid();
          }});
  }
}
