import 'package:alefakaltawinea_animals_app/core/servies/firebase/analytics_helper.dart';
import 'package:alefakaltawinea_animals_app/modules/baseScreen/baseScreen.dart';
import 'package:alefakaltawinea_animals_app/modules/fav/favourite_screen.dart';
import 'package:alefakaltawinea_animals_app/modules/homeTabsScreen/provider/bottom_bar_provider_model.dart';
import 'package:alefakaltawinea_animals_app/modules/intro/intro_screen.dart';
import 'package:alefakaltawinea_animals_app/modules/login/data/user_data.dart';
import 'package:alefakaltawinea_animals_app/modules/login/provider/user_provider_model.dart';
import 'package:alefakaltawinea_animals_app/modules/spalshScreen/data/regions_model.dart';
import 'package:alefakaltawinea_animals_app/modules/spalshScreen/spalshScreen.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/apis.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/baseDimentions.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/baseTextStyle.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/constants.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/input%20_validation_mixing.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/myColors.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/myUtils.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/providers.dart';
import 'package:alefakaltawinea_animals_app/utils/my_widgets/action_bar_widget.dart';
import 'package:alefakaltawinea_animals_app/utils/my_widgets/animal_cart_widget.dart';
import 'package:alefakaltawinea_animals_app/utils/my_widgets/delete_card_popup.dart';
import 'package:alefakaltawinea_animals_app/utils/my_widgets/laoding_view.dart';
import 'package:alefakaltawinea_animals_app/utils/my_widgets/transition_image.dart';
import 'package:alefakaltawinea_animals_app/views/cards/BuyCard/steps/StepOne.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

import '../../utils/my_widgets/edite_card_popup.dart';
import '../cart/add_cart_screen.dart';
import '../cart/my_carts_model.dart';
import '../cart/provider/cart_provider.dart';
import '../settings/regions_dialog_widget.dart';
import 'deletAcountPopupScreen.dart';

class ProfileScreen extends StatefulWidget {
  int selectedTap;
   ProfileScreen({this.selectedTap=0,Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with InputValidationMixin {
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _oldPasswordController = TextEditingController();

  TextEditingController _confirmPasswordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  String _currentRegionName="";
  bool passwordobsecure = true;
  bool confirmpasswordobsecure = true;
  bool _accept = false;
  bool _showTermsError = false;
  UserProviderModel? userProviderModel;
  bool _isLogin=false;
  RegionsModel? currentRegion;
  final _profileFormGlobalKey = GlobalKey<FormState>();
  BottomBarProviderModel?bottomBarProviderModel;
  UtilsProviderModel?utilsProviderModel;
  int selectedTap=0;
  List<MyCart>myCarts=[];
  CartProvider? cartProvider;
  List<Map<String, dynamic>> filteredCities = [];

  void _onSearchChanged() {
    final query = _searchController.text;
    setState(() {
      filteredCities = MyUtils.getCities().where((city) {
        final cityNameArabic = city["name"].toString();
        final cityNameEnglish = city["name_en"].toString();
        return cityNameArabic.contains(query) || cityNameEnglish.contains(query);
      }).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    AnalyticsHelper().setScreen(screenName: "شاشة-حسابي");
    cartProvider=Provider.of<CartProvider>(context,listen: false);
    bottomBarProviderModel=Provider.of<BottomBarProviderModel>(context,listen: false);
    utilsProviderModel=Provider.of<UtilsProviderModel>(context,listen: false);
    if(Constants.currentUser!=null){
      userProviderModel = Provider.of<UserProviderModel>(context, listen: false);
      userProviderModel!.currentUser=Constants.currentUser!;
      cartProvider!.getMyCart();
      _initUserData();
    }
    setState(() {
      selectedTap=widget.selectedTap;
    });

    filteredCities.addAll(MyUtils.getCities());
    _searchController.addListener(_onSearchChanged);

  }
  @override
  void dispose() async{
    //await bottomBarProviderModel!.setSelectedScreen(0);
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    bottomBarProviderModel=Provider.of<BottomBarProviderModel>(context,listen: true);
    userProviderModel = Provider.of<UserProviderModel>(context, listen: true);
    utilsProviderModel=Provider.of<UtilsProviderModel>(context,listen: true);
    cartProvider=Provider.of<CartProvider>(context,listen: true);


    return BaseScreen(
      showSettings: false,
      showBottomBar: true,
      tag: "ProfileScreen",
      body: userProviderModel!.isLoading?LoadingProgress():
      Constants.currentUser!=null?_ProfileScreen():_guestScreen(),
    );
  }

  Widget _ProfileScreen(){
    return Container(
      color: Colors.white,
      child: Column(
        children:[
          ActionBarWidget("",context,backgroundColor: Colors.white,textColor: C.BASE_BLUE,enableShadow: false,),
          Expanded(child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _Logout(),
              _tapsPart(),
              selectedTap==0?Expanded(child: _profileDataScreen()):
              selectedTap==1?
              Expanded(child: cartProvider!.myCarts.isNotEmpty?_myCartsScreen():_noCarts()):
              Expanded(child:FavScreen())
            ],
          ))]
        ,),
    );
  }
  Widget _tapsPart(){
    return Container(
      height: D.default_50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Expanded(
          child: _myInfoBtn((){
          setState(() {
            selectedTap=0;
          });
      },tr("my_info")),
        ),
        Expanded(child: _myCartsBtn((){
          setState(() {
            selectedTap=1;
          });
        },tr("my_carts")),),
         Expanded(child:  _myFavBtn((){
           setState(() {
             selectedTap=2;
           });
         },tr("fav")))
    ],),);
  }
  Widget _profileDataScreen(){
    return SingleChildScrollView(child: Container(
      padding: EdgeInsets.all(D.default_20),
      child: Form(
        key: _profileFormGlobalKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _name(),
            _phone(),
            Container(height: D.default_1,color: Colors.grey,),
            _email(),
            _selectCity(),
            _updateBtn(),
            // Container(height: D.default_1,color: Colors.grey,),
            // _oldPassword(),
            // _password(),
            // _confirmPassword(),
            // _updatePasswordBtn(),
            _removeAccountBtn()

          ],
        ),
      ),
    ),);
  }
  Widget _guestScreen(){
    return Container();
  }
  void _initUserData(){
    _nameController.text=Constants.currentUser!.name??"";
    _phoneController.text=Constants.currentUser!.phone??"";
    _emailController.text=Constants.currentUser!.email??"";
    _cityController.text=Constants.currentUser!.stateName??tr("select_reagion");
  }
  Widget _region(){
    return Container(
      padding: EdgeInsets.all(D.default_30),
      child:Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(tr("city"),style: S.h4(color: Colors.black87),),
        InkWell(
            onTap: (){
              MyUtils.basePopup(context, body: RegionsDialogWidget(onItemSelect: (state ) {
                setState(() {
                  userProviderModel!.currentUser!.stateId=state.id.toString();
                  userProviderModel!.currentUser!.regionId=state.regionId.toString();
                  UserData user=userProviderModel!.currentUser!;
                  user.regionId=state.regionId.toString();
                  user.stateId=state.id.toString();
                  user.stateName=state.name.toString();
                  userProviderModel!.setCurrentUserData(user);
                });
              },) );
            },
            child: Container(
            padding: EdgeInsets.only(left:D.default_10,right: D.default_10,top: D.default_5,bottom: D.default_5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(D.default_100),
                color: C.BASE_BLUE,
                boxShadow:[BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    offset:Offset(1,1),
                    blurRadius:1,
                    spreadRadius: 0.5
                )]
            ),
            child: Center(child: Text(userProviderModel!.currentUser!.stateName??tr("select_reagion")
    ,style: S.h3(color: Colors.white),),),)

        )
      ],), );
  }
  Widget _name() {
    return Container(
        width: double.infinity,
        child: TextFormField(
          controller: _nameController,

          validator: (name) {
            if (isFieldNotEmpty(name!)) {
              return null;
            } else {
              return tr("enter_name");
            }
          },
          style: TextStyle(color: Colors.black87,fontSize: 14.sp,fontWeight: FontWeight.w500),
          decoration: InputDecoration(
            labelText: tr("full_name"),
            labelStyle: TextStyle(color: Colors.black45,fontSize: 18.sp,fontWeight:FontWeight.w700),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: C.BASE_BLUE),
            ),
            border: UnderlineInputBorder(
                borderSide: BorderSide(color: C.BASE_BLUE)),
            errorStyle: S.h4(color: Colors.red),
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          ),
          keyboardType: TextInputType.text,
          obscureText: false,
          cursorColor: C.BASE_BLUE,
          autofocus: false,
        ));
  }

  Widget _email() {
    return Container(
        width: double.infinity,
        child: TextFormField(
          controller: _emailController,
          validator: (email) {
            if (isFieldNotEmpty(email!)) {
              return null;
            } else {
              return tr("enter_email");
            }
          },
          style: TextStyle(color: Colors.black87,fontSize: 14.sp,fontWeight: FontWeight.w500),
          decoration: InputDecoration(
            labelText: tr("email"),
            labelStyle: TextStyle(color: Colors.black45,fontSize: 18.sp,fontWeight:FontWeight.w700),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: C.BASE_BLUE),
            ),
            border: UnderlineInputBorder(
                borderSide: BorderSide(color: C.BASE_BLUE)),
            errorStyle: S.h4(color: Colors.red),
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          ),
          keyboardType: TextInputType.text,
          obscureText: false,
          cursorColor: C.BASE_BLUE,
          autofocus: false,
        ));
  }

  Widget _password() {
    return Container(
        width: double.infinity,
        child: TextFormField(
          controller: _passwordController,
          validator: (password) {
            if (isFieldNotEmpty(password!)) {
              if (isPasswordValide(password)) {
                return null;
              } else {
                return tr("password_length");
              }
            } else {
              return tr("");
            }
          },
          style: S.h4(color: Colors.black),
          decoration: InputDecoration(
              labelText: tr("enter__new_password"),
              labelStyle: S.h1(color: Colors.grey),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: C.BASE_BLUE),
              ),
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: C.BASE_BLUE)),
              errorStyle: S.h4(color: Colors.red),
              contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    passwordobsecure
                        ? passwordobsecure = false
                        : passwordobsecure = true;
                  });
                },
                icon: Icon(
                  (passwordobsecure)
                      ? Icons.visibility_off
                      : Icons.visibility,
                  color: Colors.grey,
                ),
              )),
          keyboardType: TextInputType.text,
          obscureText: passwordobsecure,
          cursorColor: C.BASE_BLUE,
          autofocus: false,
        ));
  }
  Widget _oldPassword() {
    return Container(
        width: double.infinity,
        child: TextFormField(
          controller: _oldPasswordController,
          validator: (password) {
            if (isFieldNotEmpty(password!)) {
              if (isPasswordValide(password)) {
                return null;
              } else {
                return tr("password_length");
              }
            } else {
              return tr("");
            }
          },
          style: S.h4(color: Colors.black),
          decoration: InputDecoration(
              labelText: tr("enter_old_password"),
              labelStyle: S.h1(color: Colors.grey),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: C.BASE_BLUE),
              ),
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: C.BASE_BLUE)),
              errorStyle: S.h4(color: Colors.red),
              contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    passwordobsecure
                        ? passwordobsecure = false
                        : passwordobsecure = true;
                  });
                },
                icon: Icon(
                  (passwordobsecure)
                      ? Icons.visibility_off
                      : Icons.visibility,
                  color: Colors.grey,
                ),
              )),
          keyboardType: TextInputType.text,
          obscureText: passwordobsecure,
          cursorColor: C.BASE_BLUE,
          autofocus: false,
        ));
  }

  Widget _confirmPassword() {
    return Container(
        width: double.infinity,
        child: TextFormField(
          controller: _confirmPasswordController,
          validator: (confirm) {
            if (isFieldNotEmpty(confirm!)) {
              if (isTowFieldsMached(_passwordController.text, confirm)) {
                return null;
              } else {
                return tr("not_confirm");
              }
            } else {
              return tr("confirm_password");
            }
          },
          style: S.h2(color: Colors.black),
          decoration: InputDecoration(
              labelText: tr("confirm_password"),
              labelStyle: S.h1(color: Colors.grey),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: C.BASE_BLUE),
              ),
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: C.BASE_BLUE)),
              errorStyle: S.h2(color: Colors.red),
              contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    confirmpasswordobsecure
                        ? confirmpasswordobsecure = false
                        : confirmpasswordobsecure = true;
                  });
                },
                icon: Icon(
                  (confirmpasswordobsecure)
                      ? Icons.visibility_off
                      : Icons.visibility,
                  color: Colors.grey,
                ),
              )),
          keyboardType: TextInputType.text,
          obscureText: confirmpasswordobsecure,
          cursorColor: C.BASE_BLUE,
          autofocus: false,
        ));
  }

  Widget _phone() {
    return Container(
        width: double.infinity,
        child: TextFormField(
          readOnly: true,
          controller: _phoneController,
          validator: (phone) {
            if (isFieldNotEmpty(phone!)) {
              if (isPhoneValide(phone)) {
              } else {
                return tr("enter_10_numbers");
              }
            } else {
              return tr("enter_phone");
            }
          },
          style: TextStyle(color: Colors.black87,fontSize: 14.sp,fontWeight: FontWeight.w500),
          decoration: InputDecoration(
            labelText: tr("phone"),
            labelStyle: TextStyle(color: Colors.black45,fontSize: 18.sp,fontWeight:FontWeight.w700),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: C.BASE_BLUE),
            ),
            border: UnderlineInputBorder(
                borderSide: BorderSide(color: C.BASE_BLUE)),
            errorStyle: S.h2(color: Colors.red),
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          ),
          keyboardType: TextInputType.phone,
          obscureText: false,
          cursorColor: C.BASE_BLUE,
          autofocus: false,
        ));
  }
  Widget _selectCity() {
    return InkWell(
      onTap: (){
        showBarModalBottomSheet(
          context: context,
          builder: (context) => SingleChildScrollView(
            controller: ModalScrollController.of(context),
            child: Container(
              height: Get.height * 0.9,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: TextField(
                    //     controller: _searchController,
                    //     onChanged: (q){
                    //       print(q);
                    //     },
                    //     decoration: InputDecoration(
                    //       hintText: 'Search for a city',
                    //     ),
                    //   ),
                    // ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: filteredCities.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(
                              Constants.prefs!.get(Constants.LANGUAGE_KEY!) == 'ar'
                                  ? filteredCities[index]['name']
                                  : filteredCities[index]['name_en'],
                              style: TextStyle(color: Colors.grey),
                            ),
                            onTap: () {
                              _cityController.text =
                              Constants.prefs!.get(Constants.LANGUAGE_KEY!) == 'ar'
                                  ? filteredCities[index]['name']
                                  : filteredCities[index]['name_en'];
                              Navigator.pop(context, filteredCities[index]['name']);
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      child: Container(
          width: double.infinity,
          child: TextFormField(
            controller: _cityController,
            onChanged: (q){
              FocusManager.instance.primaryFocus?.unfocus();
            },
            validator: (name) {
              if (isFieldNotEmpty(name!)) {
                return null;
              } else {
                return tr("select_city");
              }
            },
            readOnly: true,
            enabled: false,
            style: TextStyle(color: Colors.black87,fontSize: 14.sp,fontWeight: FontWeight.w500),
            decoration: InputDecoration(
              labelText: tr("select_city"),
              labelStyle: TextStyle(color: Colors.black45,fontSize: 18.sp,fontWeight:FontWeight.w700),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: C.BASE_BLUE),
              ),
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: C.BASE_BLUE)),
              errorStyle: S.h2(color: Colors.red),
              contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            ),
            keyboardType: TextInputType.text,
            obscureText: false,
            cursorColor: C.BASE_BLUE,
            autofocus: false,
          )),
    );
  }

  Widget _Logout(){
    return Container(
      height: D.default_80,

      margin: EdgeInsets.all(D.default_15),
      child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
      Icon(Icons.person_pin,color: C.BASE_BLUE,size: D.default_80,),
        Expanded(child: Text(Constants.currentUser!.name!,style: S.h1(color: Colors.black87),),),

        InkWell(onTap: ()async{
          await userProviderModel!.logout(context);
       },child: Container(
            padding: EdgeInsets.only(left:10.w,right:10.w,top:5.h,bottom:5.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Color(0xfff9bf1d).withOpacity(0.3),

          ),
          child: Row(children: [
            Text(tr("logout"),style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w500,color:Colors.black),),
            Icon(Icons.logout,color: Colors.black,size: D.default_20,)
          ],),))
    ],),);
  }
  Widget _updateBtn() {
    return Center(
      child: InkWell(
        onTap: () {
          userProviderModel!.updateProfile(
              context,
              _nameController.text,
              _emailController.text,
              _phoneController.text,
              _cityController.text,

              );
        },
        child: Container(
          width: D.default_120,
          margin: EdgeInsets.all(D.default_30),
          padding: EdgeInsets.only(
              left: D.default_10,
              right: D.default_10,
              top: D.default_5,
              bottom: D.default_5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(D.default_10),
              color: C.BASE_BLUE,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    offset: Offset(1, 1),
                    blurRadius: 1,
                    spreadRadius: 1)
              ]),
          child: Text(
            tr("edit"),
            style: TextStyle(fontSize: 16.sp,color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
  Widget _updatePasswordBtn() {
    return Center(
      child: InkWell(
        onTap: () {
          userProviderModel!.changePassword(
              context,
              _oldPasswordController.text,
              _passwordController.text,
              _confirmPasswordController.text,
          );
        },
        child: Container(
          width: D.default_120,
          margin: EdgeInsets.all(D.default_30),
          padding: EdgeInsets.only(
              left: D.default_10,
              right: D.default_10,
              top: D.default_5,
              bottom: D.default_5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(D.default_10),
              color: C.BASE_BLUE,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    offset: Offset(1, 1),
                    blurRadius: 1,
                    spreadRadius: 1)
              ]),
          child: Text(
            tr("edit"),
            style: S.h2(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
  Widget _myCartsBtn(Function onTap,String title) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        width: D.default_130,
        margin: EdgeInsets.only(left:D.default_30,right: D.default_30),
        padding: EdgeInsets.only(
            left: D.default_10,
            right: D.default_10,
            top: D.default_10,
            bottom: D.default_10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(D.default_10),
            color: selectedTap==1?C.BASE_BLUE:Colors.grey[600],
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  offset: Offset(1, 1),
                  blurRadius: 1,
                  spreadRadius: 1)
            ]),
        child: Text(
          title,
          style: TextStyle(fontSize: 14.sp,color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
  Widget _myFavBtn(Function onTap,String title) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        width: D.default_130,
        margin: EdgeInsets.only(left:D.default_30,right: D.default_30),
        padding: EdgeInsets.only(
            left: D.default_10,
            right: D.default_10,
            top: D.default_10,
            bottom: D.default_10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(D.default_10),
            color: selectedTap==2?C.BASE_BLUE:Colors.grey[600],
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  offset: Offset(1, 1),
                  blurRadius: 1,
                  spreadRadius: 1)
            ]),
        child: Text(
          title,
          style: TextStyle(fontSize: 14.sp,color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
  Widget _myInfoBtn(Function onTap,String title) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        width: D.default_130,
        margin: EdgeInsets.only(left:D.default_30,right: D.default_30),
        padding: EdgeInsets.only(
            left: D.default_10,
            right: D.default_10,
            top: D.default_10,
            bottom: D.default_10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(D.default_10),
            color: selectedTap==0?C.BASE_BLUE:Colors.grey[600],
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  offset: Offset(1, 1),
                  blurRadius: 1,
                  spreadRadius: 1)
            ]),
        child: Text(
          title,
          style: TextStyle(fontSize: 14.sp,color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
  Widget _myCartsScreen(){
    return Column(children: [
      Expanded(child: cartProvider!.isLoading?LoadingProgress():Container(
        child: ListView.builder(itemBuilder: (context,index){
          return _cartItem(index) ;
        },
          itemCount: cartProvider!.myCarts.length,
        ),
      ),),
      _addCartBtn()
    ],);
  }
  Widget _cartItem(int index){
    return Directionality(textDirection: TextDirection.ltr, child:
    AnimalCartWidget(cart: cartProvider!.myCarts[index],enableEdite: true,
    onDelete: (){
      MyUtils.basePopup(context, body: DeleteCradPopupScreen(content:tr("delete_card_text"),onOkPressed: (){
        cartProvider!.deleteCard(cartProvider!.myCarts[index].id??0);
        Navigator.pop(context);
      },));
    },
    onEdite: (){
      MyUtils.basePopup(context, body: EditeCartScreen(myCart:cartProvider!.myCarts[index],));
    },));
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
        onTap: () async{
          if(Constants.APPLE_PAY_STATE){
            MyUtils.navigate(context, BuyCard());
          }else{
            await Fluttertoast.showToast(msg:tr("Your request has been successfully received") );
          }

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
            style: TextStyle(fontSize: 14.sp,color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
  Widget _removeAccountBtn() {
    return Center(
      child: InkWell(
        onTap: () {
          MyUtils.basePopup(context,body: DeletAcountPopupScreen());
        },
        child: Container(
          width: D.default_200,
          margin: EdgeInsets.all(D.default_30),
          padding: EdgeInsets.only(
              left: D.default_10,
              right: D.default_10,
              top: D.default_10,
              bottom: D.default_10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(D.default_10),
              color: Colors.red,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    offset: Offset(1, 1),
                    blurRadius: 1,
                    spreadRadius: 1)
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
            Text(
              tr("delete_account"),
              style: TextStyle(fontSize: 16.sp,color: Colors.white),
              textAlign: TextAlign.center,
            ),
            SizedBox(width: D.default_5,),
            Icon(Icons.delete_forever,color: Colors.white,size: D.default_20,),

          ],),
        ),
      ),
    );
  }


}
