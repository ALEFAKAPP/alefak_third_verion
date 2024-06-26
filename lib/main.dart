import 'package:alefakaltawinea_animals_app/core/servies/firebase/analytics_helper.dart';
import 'package:alefakaltawinea_animals_app/firebase_options.dart';
import 'package:alefakaltawinea_animals_app/modules/baseScreen/baseScreen.dart';
import 'package:alefakaltawinea_animals_app/modules/serviceProviders/details_screen/service_provider_details_provider.dart';
import 'package:alefakaltawinea_animals_app/modules/serviceProviders/list_screen/provider/home_offers_provider.dart';
import 'package:alefakaltawinea_animals_app/modules/settings/terms_screen.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/constants.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/myColors.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/providers.dart';
import 'package:alefakaltawinea_animals_app/utils/notification/fcm.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'modules/adoption/provider/adoption_provider_model.dart';
import 'modules/ads/provider/ads_slider_provider.dart';
import 'modules/app_states/provider/app_state_provider.dart';
import 'modules/cart/provider/cart_provider.dart';
import 'modules/categories_screen/provider/categories_provider_model.dart';
import 'modules/homeTabsScreen/provider/bottom_bar_provider_model.dart';
import 'modules/homeTabsScreen/provider/intro_provider_model.dart';
import 'modules/login/provider/user_provider_model.dart';
import 'modules/notifications/provider/notification_provider.dart';
import 'modules/otp/provider/otp_provider_model.dart';
import 'modules/serviceProviderAccount/provider/scan_code_provider.dart';
import 'modules/serviceProviders/list_screen/provider/sevice_providers_provicer_model.dart';
import 'modules/settings/provider/settings_provider.dart';
import 'modules/spalshScreen/spalshScreen.dart';


typedef dynamic OnItemClickListener();
FCM? fcm;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
  ).whenComplete(() async {
    fcm = FCM();
    await fcm!.init();
    AnalyticsHelper().init();
    runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider<IntroProviderModel>(
          create: (ctx) => IntroProviderModel(),
        ),
        ChangeNotifierProvider<BottomBarProviderModel>(
          create: (ctx) => BottomBarProviderModel(),
        ),
        ChangeNotifierProvider<CategoriesProviderModel>(
          create: (ctx) => CategoriesProviderModel(),
        ),
        ChangeNotifierProvider<ServiceProvidersProviderModel>(
          create: (ctx) => ServiceProvidersProviderModel(),
        ),
        ChangeNotifierProvider<AdsSliderProviderModel>(
          create: (ctx) => AdsSliderProviderModel(),
        ),
        ChangeNotifierProvider<UtilsProviderModel>(
          create: (ctx) => UtilsProviderModel(),
        ),
        ChangeNotifierProvider<UserProviderModel>(
          create: (ctx) => UserProviderModel(),
        ),
        ChangeNotifierProvider<OtpProviderModel>(
          create: (ctx) => OtpProviderModel(),
        ),
        ChangeNotifierProvider<AdoptionProviderModel>(
          create: (ctx) => AdoptionProviderModel(),
        ),
        ChangeNotifierProvider<NotificationProvider>(
          create: (ctx) => NotificationProvider(),
        ),
        ChangeNotifierProvider<CartProvider>(
          create: (ctx) => CartProvider(),
        ),
        ChangeNotifierProvider<ScanCodeProvider>(
          create: (ctx) => ScanCodeProvider(),
        ),
        ChangeNotifierProvider<AppStataProviderModel>(
          create: (ctx) => AppStataProviderModel(),
        ),
        ChangeNotifierProvider<SettingsProvider>(
          create: (ctx) => SettingsProvider(),
        ),
        ChangeNotifierProvider<HomeOffersProvider>(
          create: (ctx) => HomeOffersProvider(),
        ),
        ChangeNotifierProvider<ServiceProviderDetailsProvider>(
          create: (ctx) => ServiceProviderDetailsProvider(),
        ),


      ],
      child: EasyLocalization(
          supportedLocales: [Locale('en', 'US'), Locale('ar', 'EG')],
          path: 'assets/strings',
          // <-- change the path of the translation files
          fallbackLocale: Locale('ar', 'EG'),
          child: MyApp()),
    ));
  });
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  SharedPreferences? prefs;
  UtilsProviderModel? utilsProviderModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPref();
    utilsProviderModel=Provider.of<UtilsProviderModel>(context,listen: false);
    Constants.utilsProviderModel=utilsProviderModel;
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      await fcm!.requestPermission();
      await fcm!.getFCMToken();
      await fcm!.initInfo();
      await FCM().notificationSubscrib((Constants.prefs!.get(Constants.LANGUAGE_KEY)??"ar")=="ar");
      await FCM().openClosedAppFromNotification();
    });

  }
  @override
  Widget build(BuildContext context) {
    Constants.mainContext=context;
    utilsProviderModel=Provider.of<UtilsProviderModel>(context,listen: true);
    return  ResponsiveSizer(
        builder: (context, orientation, deviceType) {
          return ScreenUtilInit(
              designSize: const Size(360, 690),
              minTextAdapt: true,
              splitScreenMode: true,
              builder: (context , child) {
              return GetMaterialApp(
                theme: ThemeData(
                      primaryColor:C.BASE_BLUE,
                      focusColor:C.BASE_BLUE,
                    fontFamily: GoogleFonts.getFont('IBM Plex Sans Arabic').fontFamily,
                ),
                  builder: EasyLoading.init(),
                  localizationsDelegates: EasyLocalization.of(context)?.delegates,
                  supportedLocales: [Locale('en', 'US'), Locale('ar', 'EG')],
                  locale: EasyLocalization.of(context)?.currentLocale!,
                  debugShowCheckedModeBanner: false,
                  home: BaseScreen(
                      tag: "SplashScreen",
                      padding:EdgeInsets.zero,
                      showBottomBar: false,
                      showSettings: false,
                      body: SplashScreen()));
            }
          );});
  }

void initPref()async{
  prefs =  await SharedPreferences.getInstance();
  Constants.prefs=prefs;
}

}

/*class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}*/

