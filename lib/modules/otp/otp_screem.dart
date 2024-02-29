import 'dart:async';
import 'package:alefakaltawinea_animals_app/modules/baseScreen/baseScreen.dart';
import 'package:alefakaltawinea_animals_app/modules/login/data/returnSuccessModel.dart';
import 'package:alefakaltawinea_animals_app/modules/login/forget_password/forget_password_screen.dart';
import 'package:alefakaltawinea_animals_app/modules/login/provider/user_provider_model.dart';
import 'package:alefakaltawinea_animals_app/modules/otp/provider/otp_provider_model.dart';
import 'package:alefakaltawinea_animals_app/modules/otp/sample_stratigy.dart';
import 'package:alefakaltawinea_animals_app/shared/components/text.dart';
import 'package:alefakaltawinea_animals_app/shared/constance/colors.dart';
import 'package:alefakaltawinea_animals_app/shared/constance/fonts.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/baseDimentions.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/baseTextStyle.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/constants.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/myColors.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/myUtils.dart';
import 'package:alefakaltawinea_animals_app/utils/my_widgets/laoding_view.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:otp_autofill/otp_autofill.dart';
import 'package:provider/provider.dart';



class OtpScreen extends StatefulWidget {
  String otpFalge;
  String title;
  String code;
  String? phone;
  bool?fromaddcard;
   OtpScreen(this.otpFalge,this.title,this.phone,{this.code="",this.fromaddcard});

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  late OTPTextEditController controller;
  final scaffoldKey = GlobalKey();
  late OTPInteractor _otpInteractor ;

  OtpProviderModel? otpProviderModel;
  UserProviderModel? userProviderModel;
  late Timer  timer ;
  int secondsRemaining = 50;
  bool enableResend = false;
  int  numtry = 1;
  String appSignature="";
  String _userPin="";
  TextEditingController otpController=TextEditingController();
  bool isLoading=false;

  @override
  void initState() {
    super.initState();
    _otpInteractor = OTPInteractor();
    _otpInteractor.getAppSignature()
        .then((value) => print('signature - $value'));
    controller = OTPTextEditController(
      codeLength: 4,
      onCodeReceive: (code)async{
        //await Fluttertoast.showToast(msg:tr("Your code is:$code") );
        otpController.text=code;
        setState(() {
          _userPin=code;
        });
      },
    )..startListenUserConsent(
          (code) {
        final exp = RegExp(r'(\d{4})');
        return exp.stringMatch(code ?? '') ?? '';
      },
      strategies: [
        //SampleStrategy(),
      ],
    );
    otpProviderModel=Provider.of<OtpProviderModel>(context,listen: false);
    userProviderModel=Provider.of<UserProviderModel>(context,listen: false);
    // _getCode();

    timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (secondsRemaining != 0) {
        setState(() {
          secondsRemaining -- ;
        });
      } else {
        setState(() {
          enableResend  = true;
        });
      }
    });
    /*SmsAutoFill().getAppSignature.then((signature) {
      setState(() {
        appSignature = signature;
        print("app signature:$appSignature");
      });
    });*/
    //SmsAutoFill().listenForCode();
    /*SmsAutoFill().code.listen((event) async{
      if(event.isNotEmpty){
        setState(() {
          _userPin=event;
          otpController.text=event;
        });
      }
    });*/


  }
  @override
  void dispose() {
    // TODO: implement dispose
    //SmsAutoFill().unregisterListener();
    super.dispose();
    timer.cancel();
  }
  @override
  Widget build(BuildContext context) {
    otpProviderModel=Provider.of<OtpProviderModel>(context,listen: true);
    userProviderModel=Provider.of<UserProviderModel>(context,listen: true);

    return BaseScreen(
      showSettings: false,
      showBottomBar: false,
      tag: "OtpScreen",
      body:  isLoading?Center(child: LoadingProgress(),):SingleChildScrollView(child: Container(
          child:Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _header(),
              _operationMessage(),
              SizedBox(height: D.default_30,),
              _otpField(),
              _useCodeBtn(context),
              SizedBox(height: D.default_20,),
              _resendCodeBtn(),

            ],)
      ),),);
  }
  Widget _header(){
    return Container(
        child: Center(child: Text(tr("active_acount"),style: S.h1(color: C.BASE_BLUE),textAlign: TextAlign.center,),));
  }
  Widget _operationMessage(){
    return Container(
      padding: EdgeInsets.all(D.default_10),
        child: Center(child: Text(tr("otp_phon"),style: S.h2(color: Colors.grey),textAlign: TextAlign.center,),));
  }
  Widget _useCodeBtn(BuildContext context){
    return InkWell(onTap: ()async{
      setState(() {
        isLoading=true;
      });
     var result = await userProviderModel!.checkOtp(widget.phone!,_userPin,context,false);
      setState(() {
        isLoading=false;
      });

      if (result.status == false) {
        ReturnSuccessModel errorModel = result;
        Fluttertoast.showToast(msg:tr(errorModel.msg));

      } else if (result.status == true) {


      if(otpProviderModel!.activation_code.toString()==_userPin||widget.code==_userPin){
        if(widget.otpFalge=="ForgetPasswordScreen"){
          MyUtils.navigate(context, ForgetPasswordScreen(widget.phone!, _userPin));
        }else{
          bool fromaddcard=widget.fromaddcard??false;
          otpProviderModel!.activeAccount(Constants.currentUser!=null?Constants.currentUser!.phone!:widget.phone!, _userPin, context,fromaddcard: widget.fromaddcard??false);
        }
        //MyUtils.navigateAsFirstScreen(context, MainCategoriesScreen());
        ///call api here
      }else{
        Fluttertoast.showToast(msg:tr("كود التفعيل غير صحيح"));
      }

    }
    }
    ,child: Container(
        width: D.default_200,
          padding: EdgeInsets.all(D.default_10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(D.default_15),
              color: C.BASE_BLUE,
              boxShadow:[BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  offset:Offset(2,2),
                  blurRadius:4,
                  spreadRadius: 2
              )]
          ),
        child: Center(child: Text(tr("submit"),style: S.h1(color: Colors.white),textAlign: TextAlign.center,),)),);
  }


  Widget _resendCodeBtn(){

    return enableResend ==true
        ?InkWell(
      onTap: (){
        _resendCode();
      },
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DefaultText(
              color: textSecondaryColor,
              text: tr('You did not receive the code:'),
              maxLines: 2,
              fontSize: textSizeSMedium),
          DefaultText(
              color: primaryColor,
              text: tr('Resend'),
              maxLines: 2,
              boldText: true,
              fontSize: textSizeSMedium),
        ],
      ),
    )
        : Row(
      // crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DefaultText(
            color: textSecondaryColor,
            text: tr('Resend after'),
            maxLines: 2,
            fontSize: textSizeSMedium),
        DefaultText(
            color: primaryColor,
            text: secondsRemaining,
            maxLines: 2,
            boldText: true,
            fontSize: textSizeSMedium),
      ],
    );
  }

  Widget _otpField(){
    return Directionality(textDirection: TextDirection.ltr, child: Container(
      padding: EdgeInsets.all(D.default_30),
      child:/*TextFormField(
        controller: otpController,
      )*/
      TextFormField(
        controller: otpController,
        maxLength: Constants.OTP_LENGTH,
        keyboardType: TextInputType.number,
        autofocus: true,
        decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: C.BASE_BLUE),
          ),
          border: UnderlineInputBorder(
              borderSide: BorderSide(color: C.BASE_BLUE)),
          errorStyle: S.h4(color: Colors.red),
        ),
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        textAlign:TextAlign.center ,
        style: TextStyle(
            fontSize: D.default_20
        ),
        onChanged: (pin) {
          _userPin=pin;
        },
      ),));
}
 void _getCode(){
    if(widget.phone!=null){
      otpProviderModel!.getCode(widget.phone!, context);
    }
 }
  void _resendCode()async{
    if(widget.phone!=null){
      userProviderModel!.sendOtp(widget.phone!,context,false);
      await Fluttertoast.showToast(msg: tr('success_resend_otp'));
      // await otpProviderModel!.getCode(widget.phone!, context);
      // widget.code=otpProviderModel!.activation_code.toString();
    }else{
      userProviderModel!.sendOtp(widget.phone!,context,false);
      // otpProviderModel!.getCode(Constants.currentUser!.phone!, context);
    }

    setState(() {
      numtry = numtry + 1 ;
      secondsRemaining = 60 * numtry;
      enableResend = true;
    });


  }
  void _resetPassword(){
    if(widget.otpFalge=="ForgetPasswordScreen"){
      _resendCode();
    }
  }

}
