import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsHelper{
  AnalyticsHelper._privateConstructor();
  static final AnalyticsHelper _instance = AnalyticsHelper._privateConstructor();
  factory AnalyticsHelper() {
    return _instance;
  }

  late final FirebaseAnalytics analytics ;
  init(){
    analytics = FirebaseAnalytics.instance;
    analytics.setAnalyticsCollectionEnabled(true);
  }
  setScreen({required  String screenName})async{
    await analytics.setCurrentScreen(screenName: screenName);
  }
  setEvent({required  String eventName,Map<String,dynamic>?parameters})async{
    await analytics.logEvent(name: eventName,parameters: parameters);
  }


}