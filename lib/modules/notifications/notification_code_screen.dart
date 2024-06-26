import 'package:alefakaltawinea_animals_app/modules/baseScreen/baseScreen.dart';
import 'package:alefakaltawinea_animals_app/modules/serviceProviders/list_screen/data/offer_model.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/baseDimentions.dart';
import 'package:alefakaltawinea_animals_app/utils/my_widgets/action_bar_widget.dart';
import 'package:alefakaltawinea_animals_app/utils/my_widgets/laoding_view.dart';
import 'package:alefakaltawinea_animals_app/utils/my_widgets/transition_image.dart';
import 'package:alefakaltawinea_animals_app/views/cards/BuyCard/steps/StepOne.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

import '../../../utils/my_utils/baseTextStyle.dart';
import '../../../utils/my_utils/constants.dart';
import '../../../utils/my_utils/myColors.dart';
import '../../../utils/my_utils/myUtils.dart';
import '../cart/add_cart_screen.dart';
import '../cart/provider/cart_provider.dart';
import 'data/notification_model.dart';


class NotificationCodeScreen extends StatefulWidget {
  NotificationModel notificationModel;
  NotificationCodeScreen(this.notificationModel);
  @override
  _NotificationCodeScreenState createState() => _NotificationCodeScreenState();
}

class _NotificationCodeScreenState extends State<NotificationCodeScreen> {
  CartProvider? cartProvider;
  int _selectedIndex=0;
  @override
  void initState() {
    super.initState();
    cartProvider=Provider.of<CartProvider>(context,listen: false);
    cartProvider!.getMyCart(shop_id: widget.notificationModel.shop!.id!,offer_id: widget.notificationModel.id!);
  }
  @override
  Widget build(BuildContext context) {
    cartProvider=Provider.of<CartProvider>(context,listen: true);
    return BaseScreen(
      showSettings: false,
      showBottomBar: false,
      tag: "",
      body:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:[
            ActionBarWidget("", context,backgroundColor: Colors.white,textColor: C.BASE_BLUE,enableShadow: false,),
            Expanded(child: cartProvider!.isLoading?LoadingProgress():cartProvider!.myCarts.isNotEmpty?_codePart():_noCarts())
          ] ),);
  }
  Widget _codePart(){
    return Column(children: [
      _selectedCart(_selectedIndex),
      Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(D.default_5),
            color: Colors.white,
            border: Border.all(color: Colors.black,width: D.default_2)
        ),
        margin: EdgeInsets.only(top: D.default_20),
        padding: EdgeInsets.all(D.default_10),
        height: D.default_150,
        width: D.default_150,
        child: SfBarcodeGenerator(
          value: '${cartProvider!.offerCode}',
          symbology: QRCode(),
          showValue: false,
        ),
      ),
      Container(child: Text(tr("show_code_for"),style: S.h3(color: Colors.grey),),margin: EdgeInsets.only(left:D.default_50,right: D.default_50,top: D.default_40)),
      Container(color: Colors.grey,height: D.default_2,margin: EdgeInsets.only(left:D.default_50,right: D.default_50,top: D.default_10,bottom: D.default_10),),
      Expanded(child: _cartList())
    ],);
  }
  Widget _cartList(){
    return Container(
      child:SingleChildScrollView(child:  Stack(
        alignment:AlignmentDirectional.topCenter,
        fit:StackFit.loose,
        children: carts(),),),);
  }
  List<Widget> carts(){
    List<Widget>items=[];
    for(int i=0;i<cartProvider!.myCarts.length;i++){
      items.add(
          _cartItem(i)
      );
    }
    return items;
  }
  Widget _cartItem(int index){
    return Directionality(textDirection: TextDirection.ltr, child:  Container(
      padding: EdgeInsets.all(D.default_10),
      margin: EdgeInsets.only(top:D.default_10+(D.default_100*index),bottom: D.default_10,left: D.default_20,right: D.default_20),
      width: MediaQuery.of(context).size.width*0.9
      ,height: D.default_230,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(D.default_10),
          color: C.CART_COLOR,
          boxShadow:[BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              offset:Offset(0,0),
              blurRadius:8,
              spreadRadius: 3
          )]
      ),
      child: InkWell(
          onTap: (){
            setState(() {
              _selectedIndex=index;
              cartProvider!.useCode(widget.notificationModel.shop!.id!, widget.notificationModel.id!, cartProvider!.myCarts[index].id!);
            });
          },
          child:Row(children: [
            Container(
              width: D.default_70,
              child: Column(children: [
                SizedBox(height: D.default_50,),
                TransitionImage(cartProvider!.myCarts[index].photo??"",
                    strokeColor: Colors.black.withOpacity(0.7),
                    width: D.default_80,
                    height: D.default_80,
                    radius: D.default_200,
                    fit:BoxFit.cover),
                SizedBox(height: D.default_20,),
                TransitionImage("assets/images/logo_name_blue.png",
                    width: D.default_50,
                    height: D.default_50,
                    fit:BoxFit.cover)
              ],),),
            SizedBox(width: D.default_20,),
            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("PET IDENTIFICATION ",style: S.h1(),),
                SizedBox(height: D.default_10,),
                Text("NAME OF PET ",style: S.h3(color: Colors.grey),),
                Text(cartProvider!.myCarts[index].name??"",style: S.h4(color: Colors.black),),
                SizedBox(height: D.default_10,),
                Text("ADDRESS",style: S.h3(color: Colors.grey),),
                Text(cartProvider!.myCarts[index].country??"",style: S.h4(color: Colors.black),),
                Expanded(child: Container()),
                Text("PET OWNER NAME",style: S.h3(color: Colors.grey),),
                Text(Constants.currentUser!.name??"",style: S.h4(color: Colors.black),),
                SizedBox(height: D.default_10,),

              ],
            ),),
            Column(
              children: [
                TransitionImage("assets/images/flag.png",
                    width: D.default_50,
                    height: D.default_50,
                    fit:BoxFit.cover),
                Expanded(child: Center(child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("GENDER",style: S.h3(color: Colors.grey),),
                    Text(cartProvider!.myCarts[index].gender??"",style: S.h4(color: Colors.black),),
                  ],),),),
                TransitionImage("assets/images/barcode.png",
                    width: D.default_50,
                    height: D.default_50,
                    fit:BoxFit.cover),
              ],
            ),



          ],)),
    ),);
  }

  Widget _selectedCart(int index){
    return Directionality(textDirection: TextDirection.ltr, child: Container(
      padding: EdgeInsets.all(D.default_10),
      margin: EdgeInsets.only(top:D.default_10,bottom: D.default_10,left: D.default_20,right: D.default_20),
      width: MediaQuery.of(context).size.width*0.9
      ,height: D.default_230,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(D.default_10),
          color: C.CART_COLOR,
          boxShadow:[BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              offset:Offset(0,0),
              blurRadius:8,
              spreadRadius: 3
          )]
      ),
      child: Row(children: [
        Container(
          width: D.default_70,
          child: Column(children: [
            SizedBox(height: D.default_50,),
            TransitionImage(cartProvider!.myCarts[index].photo??"",
                strokeColor: Colors.black.withOpacity(0.7),
                width: D.default_80,
                height: D.default_80,
                radius: D.default_200,
                fit:BoxFit.cover),
            SizedBox(height: D.default_20,),
            TransitionImage("assets/images/logo_name_blue.png",
                width: D.default_50,
                height: D.default_50,
                fit:BoxFit.cover)
          ],),),
        SizedBox(width: D.default_20,),
        Expanded(child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("PET IDENTIFICATION ",style: S.h1(),),
            SizedBox(height: D.default_10,),
            Text("NAME OF PET ",style: S.h3(color: Colors.grey),),
            Text(cartProvider!.myCarts[index].name??"",style: S.h4(color: Colors.black),),
            SizedBox(height: D.default_10,),
            Text("ADDRESS",style: S.h3(color: Colors.grey),),
            Text(cartProvider!.myCarts[index].country??"",style: S.h4(color: Colors.black),),
            Expanded(child: Container()),
            Text("PET OWNER NAME",style: S.h3(color: Colors.grey),),
            Text(Constants.currentUser!.name??"",style: S.h4(color: Colors.black),),
            SizedBox(height: D.default_10,),

          ],
        ),),
        Column(
          children: [
            TransitionImage("assets/images/flag.png",
                width: D.default_50,
                height: D.default_50,
                fit:BoxFit.cover),
            Expanded(child: Center(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("GENDER",style: S.h3(color: Colors.grey),),
                Text(cartProvider!.myCarts[index].gender??"",style: S.h4(color: Colors.black),),
              ],),),),
            TransitionImage("assets/images/barcode.png",
                width: D.default_50,
                height: D.default_50,
                fit:BoxFit.cover),
          ],
        ),



      ],),
    ));
  }
  Widget _noCarts(){
    return Container(
      height: MediaQuery.of(context).size.height*0.7,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(tr("dont_have_cart_title"),style: S.h1(color: C.BASE_BLUE),),
          Text(tr("dont_have_cart_subtitle"),style: S.h2(color: Colors.grey),),
          SizedBox(height: D.default_40,),
          _addCartBtn(),

        ],),
    );
  }
  Widget _addCartBtn() {
    return Center(
      child: InkWell(
        onTap: () {
          MyUtils.navigate(context, BuyCard());
        },
        child: Container(
          width: D.default_250,
          margin: EdgeInsets.all(D.default_30),
          padding: EdgeInsets.only(
              left: D.default_10,
              right: D.default_10,
              top: D.default_5,
              bottom: D.default_5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(D.default_15),
              color: C.BASE_BLUE,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    offset: Offset(1, 1),
                    blurRadius: 1,
                    spreadRadius: 1)
              ]),
          child: Text(
            tr("add_cart"),
            style: S.h1(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }


}
