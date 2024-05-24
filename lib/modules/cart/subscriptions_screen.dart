import 'package:alefakaltawinea_animals_app/modules/cart/model/subscriptionn_plan_model.dart';
import 'package:alefakaltawinea_animals_app/modules/cart/provider/subscription_provider.dart';
import 'package:alefakaltawinea_animals_app/utils/my_widgets/laoding_view.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/Material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({Key? key}) : super(key: key);

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  @override
  void initState() {
    super.initState();
    context.read<SubscriptionProvider>().getSubscriptionPlan();
    context.read<SubscriptionProvider>().setSelectedPlanIndex(0);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: Container(
          decoration: BoxDecoration(image: DecorationImage(fit: BoxFit.cover, image: AssetImage("assets/images/subscription_screen_bg.png"))),
          child: Consumer<SubscriptionProvider>(
            builder: (context,data,_) {
              return data.isLoading?
              LoadingProgress() :
              data.plans.isNotEmpty?
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 30.h,
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: [
                        Center(
                          child: Text(
                            tr("subscriptions_screen_title"),
                            style: TextStyle(color: Colors.white, fontSize: 22.sp, fontWeight: FontWeight.w800),
                          ),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 25.w),
                          child: Column(
                            children: [
                              _notesItem(tr("sub_desc_1")),
                              SizedBox(
                                height: 20.h,
                              ),
                              _notesItem(tr("sub_desc_2")),
                              SizedBox(
                                height: 20.h,
                              ),
                              _notesItem(tr("sub_desc_3")),
                              SizedBox(
                                height: 20.h,
                              ),
                              _notesItem(tr("sub_desc_4")),
                              SizedBox(
                                height: 20.h,
                              ),
                              _notesItem(tr("sub_desc_5")),
                              SizedBox(
                                height: 20.h,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Center(
                          child: Text(
                            tr("set_sub_duration"),
                            style: TextStyle(color: Colors.white, fontSize: 20.sp, fontWeight: FontWeight.w500),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        _typePicker(),
                        SizedBox(
                          height: 50.h,
                        ),
                        _submetBtn(),
                        SizedBox(
                          height: 30.h,
                        ),
                      ],
                    ),
                  ),
                ],
              ):
              SizedBox();
            }
          ),
        ));
  }

  Widget _typePicker() {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Consumer<SubscriptionProvider>(
          builder: (context,data,_) {
            return Container(
            height: 110.h,
            margin: EdgeInsets.symmetric(horizontal: 25.w),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.all(Radius.circular(15)),
              border: Border.all(
                width: 2,
                color: Colors.white,
              ),
            ),
            child: Row(
              children: List.generate(data.plans.length, (index) {
                bool isSelected=data.selectedPlanIndex==index;
                Color textColor = isSelected ? Colors.black : Colors.white;
                return Expanded(
                  child: GestureDetector(
                    onTap: (){
                      data.setSelectedPlanIndex(index);
                    },
                    child: Row(
                      children: [
                        Visibility(
                            visible: index == (data.plans.length - 1),
                            child: Container(
                              height: double.infinity,
                              width: 2,
                              color: Colors.white,
                            )),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              image: isSelected ? DecorationImage(image: AssetImage("assets/images/subsription_type_bg.png"), fit: BoxFit.cover) : null,
                              borderRadius: BorderRadius.only(
                                  topLeft: index == (data.plans.length - 1) ? Radius.circular(15) : Radius.circular(0),
                                  bottomLeft: index == (data.plans.length - 1) ? Radius.circular(15) : Radius.circular(0),
                                  topRight: index == 0 ? Radius.circular(15) : Radius.circular(0),
                                  bottomRight: index == 0 ? Radius.circular(15) : Radius.circular(0)),
                              color: Colors.grey.withOpacity(0.2),
                            ),
                            child: Stack(
                              alignment: AlignmentDirectional.center,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Text(
                                      days(data.plans[index]),
                                      style: TextStyle(color: textColor, fontWeight: FontWeight.w800, fontSize: 30.sp, height:.4),
                                    ),
                                    SizedBox(
                                      height: 15.h,
                                    ),
                                    Text(discription(data.plans[index]), style: TextStyle(color: textColor, fontWeight: FontWeight.w800, fontSize: 16.sp, height: 0.5)),
                                    SizedBox(
                                      height: 25.h,
                                    ),
                                    Text(
                                      data.plans[index].newPrice.toString(),
                                      style: TextStyle(color: textColor, fontWeight: FontWeight.w800, fontSize: 30.sp, height:.4),
                                    ),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    Text(
                                      tr("SAR"),
                                      style: TextStyle(color: textColor, fontWeight: FontWeight.w800, fontSize: 11.sp, height: 0.5),
                                    ),
                                  ],
                                ),
                                Visibility(
                                  visible: data.plans[index].discountValue>0,
                                  child: Positioned(
                                    child: Image.asset(
                                      "assets/images/subscription_discout_bg.png",
                                      width: 50.w,
                                      height: 50.w,
                                    ),
                                    top: 0,
                                    left: 0,
                                  ),
                                ),
                                Visibility(
                                  visible: data.plans[index].discountValue>0,
                                  child: Positioned(
                                    child: Transform.rotate(
                                        angle: -(45 * 3.141592653589793 / 180),
                                        child: Text(
                                          discount(data.plans[index]),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.w800,color: Colors.white),
                                        )),
                                    top: 4.5.w,
                                    left: 4.5.w,
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: !isSelected ? Colors.white.withOpacity(0.25) : Colors.transparent,
                                    borderRadius: BorderRadius.only(
                                        topLeft: index == (data.plans.length - 1) ? Radius.circular(15) : Radius.circular(0),
                                        bottomLeft: index == (data.plans.length - 1) ? Radius.circular(15) : Radius.circular(0),
                                        topRight: index == 0 ? Radius.circular(15) : Radius.circular(0),
                                        bottomRight: index == 0 ? Radius.circular(15) : Radius.circular(0)),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Visibility(
                            visible: index == 0,
                            child: Container(
                              height: double.infinity,
                              width: 2,
                              color: Colors.white,
                            )),
                      ],
                    ),
                  ),
                );
              }),
            ),
          );
        }
      ),
    );
  }

  Widget _submetBtn() {
    return Consumer<SubscriptionProvider>(
        builder: (context,data,_) {
          return GestureDetector(
            onTap: ()async{
              await data.onSubscribe();
            },
            child: Container(
            margin: EdgeInsets.symmetric(horizontal: 25.w),
              padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 5.h),
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage("assets/images/subsription_type_bg.png"), fit: BoxFit.fill),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(5), bottomLeft: Radius.circular(5), topRight: Radius.circular(5), bottomRight: Radius.circular(5)),
                color: Colors.grey.withOpacity(0.2),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: Container()),
                  Text(tr("subscribe_btn_title"),style:TextStyle(fontSize: 18.sp,fontWeight: FontWeight.w800),),
                  Expanded(child: Row(
                    mainAxisAlignment:MainAxisAlignment.end,
                    children: [
                      Text((data.plans[data.selectedPlanIndex].newPrice).toString(),style:TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w800)),
                      SizedBox(width: 3.w,),
                      Text(tr("SAR"),style:TextStyle(fontSize: 12.sp,fontWeight: FontWeight.w800))],
                  ))
                ],
              )),
          );
      }
    );
  }

  Widget _notesItem(String title) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset("assets/images/subscription_not_item_ic.svg"),
        SizedBox(
          width: 8.w,
        ),
        Expanded(
          child: Text(
            title,
            style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w500),
          ),
        )
      ],
    );
  }


  String discount(SubscriptionPlanModel model){
    String value='';
    if(model.type=='value'){
      double percent=((model.price-model.discountValue)/(model.price))*100;
      value=percent.toInt().toString();
    }else{
      double percent=(model.discountValue/100)*model.price;
      value=percent.toInt().toString();
    }
    return value+"%";
  }
  String discription(SubscriptionPlanModel model){
    String value="";
    if(model.days=="7"){
      value=tr("week");
    }else
    if(model.days=="30"){
      value=tr("month");
    }else
    if(model.days=="365"){
      value=tr("year");
    }else{
      value=model.description;
    }

    return value;
  }
  String days(SubscriptionPlanModel model){
    String value="";
    if(model.days=="7"){
      value="1";
    }else
    if(model.days=="30"){
      value="1";
    }else
    if(model.days=="365"){
      value="1";
    }else{
      value=model.days;
    }
    return value;
  }

}
