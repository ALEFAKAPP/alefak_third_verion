import 'package:alefakaltawinea_animals_app/modules/cart/cart_api.dart';
import 'package:alefakaltawinea_animals_app/modules/cart/model/subscribe_in_plan_model.dart';
import 'package:alefakaltawinea_animals_app/modules/cart/model/subscriptionn_plan_model.dart';
import 'package:alefakaltawinea_animals_app/modules/cart/subscription_webview.dart';
import 'package:flutter/Material.dart';
import 'package:get/get.dart';

class SubscriptionProvider with ChangeNotifier{
  int selectedPlanIndex=0;

  bool isLoading=false;
  setIsLoading(bool state){
    isLoading=state;
    notifyListeners();
  }
  setSelectedPlanIndex(int value){
    selectedPlanIndex=value;
    notifyListeners();
  }
  List<SubscriptionPlanModel> plans=[];
  getSubscriptionPlan()async{
    setIsLoading(true);
    final response=await CartApi().getSubscriptionPlan();
    plans.clear();
    plans.addAll(response.data??[]);
    setIsLoading(false);
  }
  onSubscribe()async{
    setIsLoading(true);
    final  response=await CartApi().subscribeInPlan(plans[selectedPlanIndex].id);
    SubscribeInPlanModel subscribeInPlanModel=response.data;
    setIsLoading(false);
    if(subscribeInPlanModel.data.isSuccess??false){
      Get.off(SubScriptionWebView(url: subscribeInPlanModel.url,));
    }
  }
}