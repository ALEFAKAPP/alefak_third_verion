import 'package:alefakaltawinea_animals_app/core/servies/firebase/analytics_helper.dart';
import 'package:alefakaltawinea_animals_app/modules/baseScreen/baseScreen.dart';
import 'package:alefakaltawinea_animals_app/modules/login/login_screen.dart';
import 'package:alefakaltawinea_animals_app/modules/login/provider/user_provider_model.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/baseDimentions.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/baseTextStyle.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/constants.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/input%20_validation_mixing.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/myColors.dart';
import 'package:alefakaltawinea_animals_app/utils/my_widgets/laoding_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

import '../../utils/my_utils/myUtils.dart';
import '../../utils/my_widgets/action_bar_widget.dart';

class RegistrationScreen extends StatefulWidget {
  bool fromaddcard;
  String? phone;
  RegistrationScreen({Key? key,this.fromaddcard=false,this.phone}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> with InputValidationMixin {
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _alifakController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  List<String> _genders = [tr("male"), tr("female"),tr("Did_not_matter")];
  List<String> _selectedGenders = [];

  TextEditingController _emailController = TextEditingController();
  bool passwordobsecure = true;
  bool confirmpasswordobsecure = true;
  bool _accept = false;
  bool _showTermsError = false;
  UserProviderModel? userProviderModel;
  final _registerFormGlobalKey = GlobalKey<FormState>();

  List<Map<String, dynamic>> filteredCities = [];

  @override
  void initState() {
    super.initState();
    AnalyticsHelper().setScreen(screenName: "شاشة-التسجيل");
    _selectedGenders.add(_genders[0]);
    userProviderModel = Provider.of<UserProviderModel>(context, listen: false);
    _phoneController.text = widget.phone!;
    filteredCities.addAll(MyUtils.getCities());
    _searchController.addListener(_onSearchChanged);


  }

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
  Widget build(BuildContext context) {
    userProviderModel = Provider.of<UserProviderModel>(context, listen: true);

    return BaseScreen(
        showSettings: false,
        showBottomBar: false,
        tag: "RegistrationScreen",
        body: userProviderModel!.isLoading
            ? LoadingProgress()
            : Container(
          color: Colors.white,
              child: Column(children: [
          ActionBarWidget(
                "", context,
                enableShadow:false,
                showSetting:false,
                textColor:C.BASE_BLUE,
                backgroundColor:Colors.white

          ),
          Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        margin: EdgeInsets.only(top: D.default_30,bottom: D.default_30,left: D.default_50,right: D.default_50),
                        child: Center(
                          child: Text(
                            tr("register_header"),
                            style: TextStyle(color: C.BASE_BLUE,fontSize: 20.sp,fontWeight: FontWeight.w800),
                            textAlign: TextAlign.center,
                          ),
                        )),
                    Container(
                      padding: EdgeInsets.only(top: D.default_20,bottom: D.default_20,left: D.default_50,right: D.default_50),
                      child: Form(
                        key: _registerFormGlobalKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            //_alifakName(),
                            //_gender(),
                            _name(),
                            _email(),
                            _phone(),
                            _selectCity(),
                            SizedBox(height: D.default_20,),
                            _registerBtn(),
                            // have_account()
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
          )
        ],),
            ));
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
          decoration: InputDecoration(
            labelText: tr("enter_name"),
            labelStyle: TextStyle(color: Colors.grey,fontSize: 14.sp),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: C.BASE_BLUE),
            ),
            border: UnderlineInputBorder(
                borderSide: BorderSide(color: C.BASE_BLUE)),
            errorStyle: TextStyle(color: Colors.red,fontSize: 12.sp),
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          ),
          keyboardType: TextInputType.text,
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
            decoration: InputDecoration(
              labelText: tr("select_city"),
              labelStyle: TextStyle(color: Colors.grey,fontSize: 14.sp),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: C.BASE_BLUE),
              ),
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: C.BASE_BLUE)),
              errorStyle: TextStyle(color: Colors.red,fontSize: 12.sp),
              contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            ),
            keyboardType: TextInputType.text,
            obscureText: false,
            cursorColor: C.BASE_BLUE,
            autofocus: false,
          )),
    );
  }

  Widget _email() {
    return Container(
        width: double.infinity,
        child: TextFormField(
          controller: _emailController,
          keyboardType:TextInputType.emailAddress,
          validator: (email) {
            if (isFieldNotEmpty(email!)&&isEmailValide(email)) {
              return null;
            } else {
              return tr("error_email");
            }
          },
          decoration: InputDecoration(
            labelText: tr("email"),
            labelStyle: TextStyle(color: Colors.grey,fontSize: 14.sp),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: C.BASE_BLUE),
            ),
            border: UnderlineInputBorder(
                borderSide: BorderSide(color: C.BASE_BLUE)),
            errorStyle: TextStyle(color: Colors.red,fontSize: 12.sp),
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          ),
          obscureText: false,
          cursorColor: C.BASE_BLUE,
          autofocus: false,
        ));
  }


  Widget _phone() {
    return Container(
        width: double.infinity,
        child: TextFormField(
          controller: _phoneController,
          readOnly: true,
          validator: (phone) {
            if (isFieldNotEmpty(phone!)) {
              if (isFieldNotEmpty(phone)) {
              } else {
                return tr("enter_10_numbers");
              }
            } else {
              return tr("enter_phone");
            }
          },
          decoration: InputDecoration(
            labelText: tr("phone"),
            labelStyle: TextStyle(color: Colors.grey,fontSize: 14.sp),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: C.BASE_BLUE),
            ),
            border: UnderlineInputBorder(
                borderSide: BorderSide(color: C.BASE_BLUE)),
              errorStyle: TextStyle(color: Colors.red,fontSize: 12.sp),
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          ),
          keyboardType: TextInputType.phone,
          obscureText: false,
          cursorColor: C.BASE_BLUE,
          autofocus: false,
        ));
  }

  Widget _registerBtn() {
    return Center(
      child: InkWell(
        onTap: () {
           _onRegisterClicked();
        },
        child: Container(
          width: D.default_250,
          margin: EdgeInsets.all(D.default_30),
          padding: EdgeInsets.only(
              left: D.default_20,
              right: D.default_20,
              top: D.default_10,
              bottom: D.default_10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(D.default_10),
              color: C.BASE_BLUE,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    offset: Offset(2, 2),
                    blurRadius: 4,
                    spreadRadius: 2)
              ]),
          child: Text(
            tr("create_new_account"),
            style: TextStyle(color: Colors.white,fontSize: 18.sp,fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget _header() {
    return Container(
      padding: EdgeInsets.all(D.default_10),
      color: C.BASE_BLUE,
      child: Center(
        child: Text(
          tr("profile_info"),
          style: S.h1(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  _onRegisterClicked() {
    if (_registerFormGlobalKey.currentState!.validate()) {
      _registerFormGlobalKey.currentState!.save();
      if (_accept) {
        setState(() {
          _showTermsError = false;
        });
      } else {
        setState(() {
          _showTermsError = true;
        });
      }
      //call register api
      userProviderModel!.register(
          context,
          _nameController.text,
          _emailController.text,
          _phoneController.text,
          _cityController.text,
      fromaddcard: widget.fromaddcard);
    } else {
      if (_accept) {
        setState(() {
          _showTermsError = false;
        });
      } else {
        setState(() {
          _showTermsError = true;
        });
      }
    }
  }
  Widget have_account(){
    return Container(child:Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(tr("have_acout"),style: S.h5(color: Colors.grey,fontSize: D.textSize(5)),),
        SizedBox(width: D.default_10,),
        InkWell(
          onTap: (){
            MyUtils.navigateReplaceCurrent(context, LoginScreen());
          },
          child: Text(tr("login"),style: S.h1(color: C.BASE_BLUE,fontSize: D.textSize(5)),),)
      ],));
  }
}
