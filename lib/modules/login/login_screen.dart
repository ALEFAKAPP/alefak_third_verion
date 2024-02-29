import 'package:alefakaltawinea_animals_app/modules/baseScreen/baseScreen.dart';
import 'package:alefakaltawinea_animals_app/modules/categories_screen/mainCategoriesScreen.dart';
import 'package:alefakaltawinea_animals_app/modules/categories_screen/new_main_categories_screen.dart';
import 'package:alefakaltawinea_animals_app/modules/login/provider/user_provider_model.dart';
import 'package:alefakaltawinea_animals_app/shared/components/input_forms.dart';
import 'package:alefakaltawinea_animals_app/shared/components/text.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/baseDimentions.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/baseTextStyle.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/input%20_validation_mixing.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/myColors.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/myUtils.dart';
import 'package:alefakaltawinea_animals_app/utils/my_widgets/laoding_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../core/servies/firebase/analytics_helper.dart';
import '../../shared/constance/fonts.dart';
import '../../utils/my_widgets/action_bar_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with  InputValidationMixin{
  TextEditingController _phoneController=TextEditingController();
  TextEditingController _passwordController=TextEditingController();
  final _loginFormGlobalKey = GlobalKey < FormState > ();
  bool passwordobsecure=true;
  UserProviderModel?userProviderModel;
@override
  void initState() {
    super.initState();
    AnalyticsHelper().setScreen(screenName: "شاشة-تسجيل الدخول");
    userProviderModel=Provider.of<UserProviderModel>(context,listen: false);
  }


  @override
  Widget build(BuildContext context) {
    userProviderModel=Provider.of<UserProviderModel>(context,listen: true);

    return BaseScreen( showSettings: false, showBottomBar: false, tag: "LoginScreen",
      body: userProviderModel!.isLoading?LoadingProgress():
      Column(children: [
        /*ActionBarWidget(
            "", context,
            enableShadow:false,
            showSetting:false,
            textColor:C.BASE_BLUE,
            backgroundColor:Colors.white

        ),*/
        SizedBox(height: 80.h,),
        Expanded(child: SingleChildScrollView(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                margin: EdgeInsets.only(top:D.default_50,bottom: D.default_30),
                child: Center(child: Text(tr("welcome_back"),style: TextStyle(color: C.BASE_BLUE,fontSize: 20.sp,fontFamily: fontPrimary,fontWeight: FontWeight.w900),textAlign: TextAlign.center,),)),
            _header(),
            Container(
              padding: EdgeInsets.all(D.default_50),
              child: Form(
                key: _loginFormGlobalKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _phone(),
                    SizedBox(height: D.default_10,),
                    _loginBtn(),
                    dont_have_account()
                  ],),),)
          ],),))
      ],),);
  }
  Widget dont_have_account(){
    return Container(child:Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(tr("login_guest"),style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w600,fontSize: 18.sp),),
        SizedBox(width: D.default_10,),
        InkWell(
          onTap: (){
            MyUtils.navigate(context, NewMainCategoriesScreen());
          },
          child: Text(tr("guest"),style: TextStyle(color: C.BASE_BLUE,fontWeight: FontWeight.w600,fontSize: 18.sp),),)
      ],));
  }
  Widget _loginBtn(){
    return Center(child: InkWell(
      onTap: (){
        _onLoginClicked();
      },
      child: Container(
        width: D.default_150,
        margin: EdgeInsets.all(D.default_30),
        padding: EdgeInsets.only(left:D.default_20,right: D.default_20,top: D.default_10,bottom: D.default_10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(D.default_10),
            color: C.BASE_BLUE,
            boxShadow:[BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                offset:Offset(2,2),
                blurRadius:4,
                spreadRadius: 2
            )]
        ),
        child: Text(tr("login"),style: TextStyle(color: Colors.white,fontWeight: FontWeight.w800,fontSize: 18.sp),textAlign:TextAlign.center ,),),),);
  }
  Widget _header(){
    return Container(
      child: Center(child: Text(tr("login_header"),style: TextStyle(color: C.BASE_BLUE,fontSize: 20.sp,fontFamily: fontPrimary,fontWeight: FontWeight.w900)),),);
  }
  Widget _phone(){
    return Container(
      child: Container(
        child: formField(
          context,
          ' 05xxxxxxxx',
          controller: _phoneController,
          keyboardType: TextInputType.number,
          isPhone: true,
          suffixIcon:  Icons.phone_android,
          prefixIcon: Row(
            children: [
              SizedBox(width:10),
              Image.asset('assets/images/saudi-arabia.png',height: 20,),
              SizedBox(width:10),
              text('+966',fontSize: 13.0),
              SizedBox(width:5),
              text(' | ',fontSize: 25.0,textColor: Color(0xffd9d8d8)),
            ],
          ),
          validator: (val) {
            if (!_phoneController.text.isEmpty)
              return null;
            else
              return tr('Please enter a phone number');
          },
          // onSaved: _authViewModel.sendOtp
        ),
      ),

    );
 }
  void _onLoginClicked(){
    if (_loginFormGlobalKey.currentState!.validate()) {
      _loginFormGlobalKey.currentState!.save();
      //call login api
      userProviderModel!.sendOtp(_phoneController.text,context,false);
    }
  }

}



