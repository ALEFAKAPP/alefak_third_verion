import 'dart:convert';
import 'dart:io';

import 'package:alefakaltawinea_animals_app/core/servies/firebase/analytics_helper.dart';
import 'package:alefakaltawinea_animals_app/core/view_model/BuyCards/BuyCardsViewModel.dart';
import 'package:alefakaltawinea_animals_app/modules/baseScreen/baseScreen.dart';
import 'package:alefakaltawinea_animals_app/shared/components/CircularProgressDialog.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/myUtils.dart';
import 'package:alefakaltawinea_animals_app/views/cards/BuyCard/steps/StepOne.dart';
import 'package:alefakaltawinea_animals_app/views/cards/BuyCard/steps/StepTow.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/Material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../utils/my_utils/constants.dart';

class SubScriptionWebView extends StatefulWidget {
  final String url;
  const SubScriptionWebView({required this.url,Key? key}) : super(key: key);

  @override
  State<SubScriptionWebView> createState() => _SubScriptionWebViewState();
}

class _SubScriptionWebViewState extends State<SubScriptionWebView> {
  @override
  void initState() {
    super.initState();
    AnalyticsHelper().setScreen(screenName: "شاشة-الدفع");
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      tag: '',
      body: SafeArea(child:

      WebView(
        initialUrl: widget.url,
        javascriptMode: JavascriptMode.unrestricted,
        javascriptChannels: Set.from([
          JavascriptChannel(
              name: 'messageHandler',
              onMessageReceived: (JavascriptMessage message) {
                print(message.message);
                var jsonData = jsonDecode(message.message);
                if(jsonData['status'] == 'CANCELLED'){
                  // Your code
                }else if(jsonData['status'] == 'SUCCESS'){
                  // Your code
                }
              })
        ]),
        onPageFinished: (value){
          print("$value" );
          if (value.toString().contains("pay-subscription-success")){
            ShowSnackBar(context,message:  tr("تمت عملية الدفع بنجاح"),type: 'success');
            AnalyticsHelper().setEvent(eventName: "الدفع",parameters: {
              "status":"تم الدفع بنجاح"
            });
          }
          if(value.toString().contains("pay-subscription-error")){
            AnalyticsHelper().setEvent(eventName: "الدفع",parameters: {
              "status":"فشل عملية الدفع"
            });
            ShowSnackBar(context,message:  tr("فشل عملية الدفع حاول مرة اخري"),type: 'error');
            Navigator.pop(context);
          }

        },
        onWebViewCreated: (WebViewController webViewController) {
          webViewController.currentUrl().then((value) {
            print("$value");
            if (value.toString().contains("pay-subscription-success")){
              AnalyticsHelper().setEvent(eventName: "الدفع",parameters: {
                "status":"تم الدفع بنجاح"
              });
              ShowSnackBar(context,message:  tr("تمت عملية الدفع بنجاح"),type: 'info');
            }
            if(value.toString().contains("pay-subscription-error")){
              AnalyticsHelper().setEvent(eventName: "الدفع",parameters: {
                "status":"فشل عملية الدفع"
              });

              Navigator.pop(context);
              ShowSnackBar(context,message:  tr("فشل عملية الدفع حاول مرة اخري"),type: 'error');
            }
          });
        },
        navigationDelegate: (NavigationRequest request) {
          if (request.url.contains("pay-subscription-success")){
            AnalyticsHelper().setEvent(eventName: "الدفع",parameters: {
              "status":"تم الدفع بنجاح"
            });
            ShowSnackBar(context,message:  tr("تمت عملية الدفع بنجاح"),type: 'info');
            Constants.currentUser!.valid_subscriptions=1;
            MyUtils.navigateReplaceCurrent(context, BuyCard());
            return NavigationDecision.prevent;
          }

          return NavigationDecision.navigate;
        },
      )

        ,), showBottomBar: false, showSettings: false,);
  }
}
