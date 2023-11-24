import 'dart:convert';
import 'dart:io';

import 'package:alefakaltawinea_animals_app/core/view_model/BuyCards/BuyCardsViewModel.dart';
import 'package:alefakaltawinea_animals_app/modules/baseScreen/baseScreen.dart';
import 'package:alefakaltawinea_animals_app/shared/components/CircularProgressDialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/Material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPayment extends StatefulWidget {
  const WebViewPayment({Key? key}) : super(key: key);

  @override
  State<WebViewPayment> createState() => _WebViewPaymentState();
}

class _WebViewPaymentState extends State<WebViewPayment> {
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }
  BuyCardViewModel _buyCardViewModel = Get.find();

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      tag: '',
      body: SafeArea(child:

      WebView(
        initialUrl: _buyCardViewModel.linkPayment.value,
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
          if (value.toString().contains("success-callback")){
            ShowSnackBar(context,message:  tr("تمت عملية الدفع بنجاح"),type: 'success');
          }
          if(value.toString().contains("error-callback")){
            ShowSnackBar(context,message:  tr("فشل عملية الدفع حاول مرة اخري"),type: 'error');
            Navigator.pop(context);
          }

        },
        onWebViewCreated: (WebViewController webViewController) {
          webViewController.currentUrl().then((value) {
            print("$value");
            if (value.toString().contains("success-callback")){
              ShowSnackBar(context,message:  tr("تمت عملية الدفع بنجاح"),type: 'info');
              _buyCardViewModel.changeStateAfterPayment();
            }
            if(value.toString().contains("error-callback")){
              Navigator.pop(context);
              ShowSnackBar(context,message:  tr("فشل عملية الدفع حاول مرة اخري"),type: 'error');
            }
          });
        },
        navigationDelegate: (NavigationRequest request) {
          if (request.url.contains("success")){
            ShowSnackBar(context,message:  tr("تمت عملية الدفع بنجاح"),type: 'info');
            _buyCardViewModel.changeStateAfterPayment();
            return NavigationDecision.prevent;
          }

          return NavigationDecision.navigate;
        },
      )

        ,), showBottomBar: false, showSettings: false,);
  }
}
