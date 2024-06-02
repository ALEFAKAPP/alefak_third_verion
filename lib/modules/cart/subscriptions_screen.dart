import 'package:alefakaltawinea_animals_app/modules/cart/model/subscriptionn_plan_model.dart';
import 'package:alefakaltawinea_animals_app/modules/cart/provider/subscription_provider.dart';
import 'package:alefakaltawinea_animals_app/shared/components/dialog.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/constants.dart';
import 'package:alefakaltawinea_animals_app/utils/my_widgets/edite_card_popup.dart';
import 'package:alefakaltawinea_animals_app/utils/my_widgets/laoding_view.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/Material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
                          height: 30.h,
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
            height: 150.h,
            margin: EdgeInsets.symmetric(horizontal: 17.w),
            width: double.infinity,

            child: Row(
              children: List.generate(data.plans.length, (index) {
                bool isSelected=data.selectedPlanIndex==index;
                Color textColor = isSelected ? Colors.black : Colors.white;
                return Expanded(
                  child: GestureDetector(
                    onTap: (){
                      data.setSelectedPlanIndex(index);
                    },
                    child: Container(
                      margin:EdgeInsets.only(left: 4.w),
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 1,
                            color:Colors.white),
                        image: isSelected ? DecorationImage(image: AssetImage("assets/images/subsription_type_bg.png"), fit: BoxFit.cover) : null,
                        borderRadius: BorderRadius.all( Radius.circular(15)),
                        color: Colors.grey.withOpacity(0.2),
                      ),
                      child: Stack(
                        clipBehavior: Clip.none,
                        alignment: AlignmentDirectional.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 20.h,
                              ),
                              Text(
                                days(data.plans[index]),
                                style: TextStyle(color: textColor, fontWeight: FontWeight.w800, fontSize: 35.sp, height:.4),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Text(discription(data.plans[index]), style: TextStyle(color: textColor, fontWeight: FontWeight.w800, fontSize: 20.sp, height: 0.5)),
                              SizedBox(
                                height: 10.h,
                              ),
                              Container(
                                height: 20.h,
                                child: Visibility(
                                  visible: data.plans[index].discountValue>0,
                                  child: Stack(
                                    alignment: AlignmentDirectional.center,
                                  children: [
                                  Text(data.plans[index].price.toString(),textAlign: TextAlign.center, style: TextStyle(color:Colors.black.withOpacity(0.3), fontWeight: FontWeight.w800, fontSize: 22.sp,height:1)),
                                    Container(color: Colors.black,height:3,margin:EdgeInsets.symmetric(horizontal: 30.w),)
                              ],),
                                ),),
                              SizedBox(
                                height: 20.h,
                              ),
                              Text(
                                data.plans[index].newPrice.toString(),
                                style: TextStyle(color: textColor, fontWeight: FontWeight.w800, fontSize: 35.sp, height:.4),
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
                          Container(
                            decoration: BoxDecoration(
                              color: !isSelected ? Colors.white.withOpacity(0.25) : Colors.transparent,
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                            ),
                          ),
                          Visibility(
                            visible: data.plans[index].discountValue>0,
                            child: Positioned(
                              child: Container(
                                width: 80.w,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(image: AssetImage("assets/images/subscription_discout_bg.png"), fit: BoxFit.fill),
                                    borderRadius: BorderRadius.all(Radius.circular(50)),
                                  ),
                                  child: Text(
                                    discount(data.plans[index]),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.bold,color: Colors.white),
                                  )),
                              top: -10.h,
                            ),
                          ),

                        ],
                      ),
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
              if(Constants.currentUser==null){
                msgreguser(context);
              }else{
                await data.onSubscribe();
              }
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
      value=model.name;
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
      value=model.description;
    }
    return value;
  }

}
