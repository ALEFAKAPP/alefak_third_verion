import 'dart:io';
import 'package:alefakaltawinea_animals_app/core/servies/api/BuyCardRemote.dart';
import 'package:alefakaltawinea_animals_app/data/dio/my_rasponce.dart';
import 'package:alefakaltawinea_animals_app/modules/cart/add_cart_model.dart';
import 'package:alefakaltawinea_animals_app/modules/cart/add_cart_respose_model.dart';
import 'package:alefakaltawinea_animals_app/modules/cart/cart_api.dart';
import 'package:alefakaltawinea_animals_app/modules/cart/cobon_model.dart';
import 'package:alefakaltawinea_animals_app/modules/my_cards/my_cards_screen.dart';
import 'package:alefakaltawinea_animals_app/shared/components/CircularProgressDialog.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/apis.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/constants.dart';
import 'package:alefakaltawinea_animals_app/views/cards/BuyCard/steps/StepThree.dart';
import 'package:alefakaltawinea_animals_app/views/cards/BuyCard/steps/StepTow.dart';
import 'package:alefakaltawinea_animals_app/views/cards/BuyCard/steps/WebViewPayment.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/Material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class BuyCardViewModel extends GetxController {
  var step = 1.obs;
  var typeCard = 2.obs;
  var numCard = 1.obs;
  var subtotal = (0.0).obs;
  var discount = (0.0).obs;
  var total = (0.0).obs;
  var priceCard = 0.obs;
  var priceAdditionalCard = 0.obs;
  var coupon = ''.obs;
  var linkPayment = ''.obs;
  CartApi cartApi = CartApi();
  var couponModel = CobonModel().obs;
  var addCardList = <AddCartModel>[].obs;
  // var images = <XFile>[].obs;
  final ImagePicker _picker = ImagePicker();
  List<dynamic> images = [];
  List<TextEditingController> name_alefk = [];
  List<TextEditingController> type_alefk = [];
  var sex = <String>[].obs;
  var listImage = <String>[].obs;
  TextEditingController couponController = TextEditingController();
  List<String> types = [tr("Dog"), tr("cat"),tr("bird"),tr("reptile"),tr("rabbit"),tr("Hamster"),tr("fish"),tr("livestock"),tr("camel"),tr("Horse"),tr("turtle"),tr("turtle"),tr("other")];

  @override
  void onInit() {
    priceCard.value = Constants.APP_INFO!.priceCard!;
    priceAdditionalCard.value = Constants.APP_INFO!.priceAdditionalCard!;
    subtotal.value = (priceCard.value ).toDouble();
    total.value = subtotal.value  - discount.value ;
    super.onInit();

  }
  CounterCard({String type = 'added'}){
    if(type == 'added'){
      ++ numCard.value;
      if(numCard.value >= 2){
        typeCard.value = 1;
      }
    }else if(type == 'minus'){
      if(numCard.value == 1){
        numCard.value = 1;
      }else{
        --numCard.value;
        if(numCard.value == 1){
          typeCard.value = 2;
        }
      }
    }
    updateTotal();
    CulcCoupon();
  }

  updateTotal(){
    if(numCard.value > 1){
      subtotal.value = (priceCard.value  + (priceAdditionalCard.value * (numCard.value - 1) )).toDouble();
    }else{
      subtotal.value = (priceCard.value  ).toDouble();
    }
    total.value = roundedNumber(subtotal.value -  discount.value );
  }

  void changeTypeCard({int type = 1}){
    if(type == 1){
      typeCard.value = 1;
      if(numCard.value == 1){
        numCard.value = 2;
      }
    }else if(type == 2){
      typeCard.value = 2;
      if(numCard.value > 1){
        numCard.value = 1;
      }

    }
    updateTotal();
    CulcCoupon();

  }

  Future BuyCard() async {
    showDialogProgress(Get.context);
    Carts cartsDatas= Carts();
    List<AddCartModel>cartsList=[];
    for(int i=0;i< numCard.value ;i++){
      AddCartModel addCartModel=AddCartModel();
      addCartModel.name='';
      addCartModel.kind= '';
      addCartModel.family= '';
      addCartModel.gender= '';
      addCartModel.photo= "";
      addCartModel.country= '';
      cartsList.add(addCartModel);
    }
    cartsDatas.cards=cartsList;
    cartsDatas.version="v2";

    MyResponse<AddCartResponseModel> response =  await cartApi.addCart(cartsDatas,coupon.value);
    if (response.status == Apis.CODE_SUCCESS){
      hideDialogProgress(Get.context);
      linkPayment.value = response.data.url;
      await Get.to(WebViewPayment());
      //changeStateAfterPayment();
    }else if(response.status == Apis.CODE_SUCCESS &&response.data==null){
      hideDialogProgress(Get.context);
    }else{
      hideDialogProgress(Get.context);
    }
    hideDialogProgress(Get.context);
    return true;
  }

  changeStateAfterPayment()
  {
    step.value = 2;
    for(int index = 0 ; index < numCard.value ; index ++){
      name_alefk.add(TextEditingController());
      type_alefk.add(TextEditingController());
      images.add(null);
      sex.add('');
      listImage.add('');
    }
    Get.off(StepTow());
  }



  checkCoupon(BuildContext context) async {
    if(couponController.text.isEmpty){
      ShowSnackBar(context,message:  tr("لايوجد كوبون مضاف"),type: 'error');
      return ;
    }
    coupon.value = couponController.text;
    showDialogProgress(Get.context);
    MyResponse<CobonModel> response = await cartApi.checkCobon(coupon.value);
    if (response.status == Apis.CODE_SUCCESS){
      hideDialogProgress(Get.context);
      couponModel.value = response.data;
      coupon.value = couponModel.value.code??"";
      CulcCoupon();
      updateTotal();
      ShowSnackBar(context,message:  tr("coupon_been_added_successfully"),type: 'success');
    }else if(response.status == Apis.CODE_SHOW_MESSAGE){
      hideDialogProgress(Get.context);
      ShowSnackBar(context,message:  response.msg,type: 'error');
    }else{
      hideDialogProgress(Get.context);
    }
  }

  CulcCoupon(){
    double DiscountVale = 0.0 ;
    if(coupon.value.isNotEmpty){
      DiscountVale = roundedNumber((subtotal * int.parse(couponModel.value.percent!)) / 100);

      if(couponModel.value.minMoney! > 0 ){
        if(subtotal.value < couponModel.value.minMoney!){
          ShowSnackBar(Get.context,message:  "${tr("Theـamountـmustـnotـbeـlessـthan")} ${couponModel.value.minMoney!} ${tr("To_activate_the_coupon")}",type: 'error');
        }else{
          if(couponModel.value.maxMoney! > 0 ){
            if(DiscountVale > couponModel.value.maxMoney!  ){
              discount.value = couponModel.value.maxMoney!;
            }else{
              discount.value = DiscountVale;
            }
          }else{
            discount.value = DiscountVale;
          }
        }
      }else{
        if(couponModel.value.maxMoney! > 0 ){
          if(DiscountVale > couponModel.value.maxMoney!  ){
            discount.value = couponModel.value.maxMoney!;
          }else{
            discount.value = DiscountVale;
          }
        }else{
          discount.value = DiscountVale;
        }
      }



      //discount.value
    }
  }


  deleteCoupon(){
    couponController.text = '';
    coupon.value = '';
    discount.value = 0.0;
    updateTotal();
  }

  void resetImage(index) {
   images[index] = null;
   update();
  }

  void goToMyCards(){
    Get.off(MyCardsScreen());
  }

  void openPick(int type, index) async {
    print('index : $index');
      images[index] = await _picker.pickImage(
          source: type == 1 ? ImageSource.gallery : ImageSource.camera,
          imageQuality: 70);

    // _imagesFiles[index] = File(images[index]!.path);
    _uploadCartImage(index);
    update();
    Get.back();
  }



  Future saveDataCard() async {
    try {
      showDialogProgress(Get.context);
      Carts cartsDatas=Carts();
      for (int index = 0; index < numCard.value; index++)
      {
        print('test1 ${listImage[index]}');

        AddCartModel addCartModel=AddCartModel();
        addCartModel.name=name_alefk[index].text;
        addCartModel.kind=type_alefk[index].text;
        addCartModel.family= '';
        addCartModel.gender=sex[index];
        addCartModel.photo= listImage[index];
        addCartModel.country='';
        addCardList.add(addCartModel);
      }
      cartsDatas.cards= addCardList;
      cartsDatas.version="v2";
      cartsDatas.code=coupon.value;

      var data = await BuyCardRemote().saveDataCards(cards :cartsDatas);


      if (data == true) {
        hideDialogProgress(Get.context);
        step.value = 3;
        await Get.off(StepThree());
        refreshData();
        // otpWidgetSingIn(Get.context);
      } else {
        hideDialogProgress(Get.context);
        ShowSnackBar(Get.context,message:  tr("خطا في عملية حفظ بيانات البطاقة"),type: 'error');

      }
    } catch (e) {
      hideDialogProgress(Get.context);
      print("catch in stepSeven: $e");
      ShowSnackBar(Get.context,message:  tr("خطا في عملية حفظ بيانات البطاقة"),type: 'error');
    }
  }

  refreshData(){
    Get.delete<BuyCardViewModel>();
  }

  void _uploadCartImage(int index) async{
    // File image= _image[index] as File;
    showDialogProgress(Get.context);
    MyResponse res = await BuyCardRemote().uploadImage(file: images[index]);
    if(res.status == '200'){
      listImage[index] = res.data;
      print('object kjsdfkj ${listImage}');
    }else{
      ShowSnackBar(Get.context,message:  tr("خطا في عملية حفظ الصورة"),type: 'error');
    }
    hideDialogProgress(Get.context);

  }

  roundedNumber(number){
    return (number * 100).round() / 100 ;
  }




}