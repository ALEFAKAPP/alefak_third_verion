
import 'dart:async';
import 'dart:convert';

import 'package:alefakaltawinea_animals_app/core/servies/firebase/analytics_helper.dart';
import 'package:alefakaltawinea_animals_app/modules/adoption/data/adoption_categories_model.dart';
import 'package:alefakaltawinea_animals_app/modules/adoption/data/animal_pager_list_model.dart';
import 'package:alefakaltawinea_animals_app/modules/adoption/provider/adoption_provider_model.dart';
import 'package:alefakaltawinea_animals_app/modules/baseScreen/baseScreen.dart';
import 'package:alefakaltawinea_animals_app/shared/constance/fonts.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/apis.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/baseDimentions.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/baseTextStyle.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/constants.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/input%20_validation_mixing.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/myColors.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/resources.dart';
import 'package:alefakaltawinea_animals_app/utils/my_widgets/action_bar_widget.dart';
import 'package:alefakaltawinea_animals_app/utils/my_widgets/laoding_view.dart';
import 'package:alefakaltawinea_animals_app/utils/my_widgets/transition_image.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart' hide MultipartFile,FormData;
import 'package:google_fonts/google_fonts.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'dart:io';

import 'package:provider/provider.dart';

import '../../utils/my_utils/myUtils.dart';
import '../settings/regions_dialog_widget.dart';
import 'delet_animal_popup.dart';


class AddAdoptionScreen extends StatefulWidget {
  AnimalData?data;
   AddAdoptionScreen({this.data});

  @override
  _AddAdoptionScreenState createState() => _AddAdoptionScreenState();
}

class _AddAdoptionScreenState extends State<AddAdoptionScreen> with InputValidationMixin{
  AdoptionProviderModel? adoptionProviderModel;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _genderController = TextEditingController();
  TextEditingController _typeController = TextEditingController();
  TextEditingController _vaccitionController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _reasonController = TextEditingController();
  TextEditingController _statusController = TextEditingController();
  TextEditingController _conditionsController = TextEditingController();
  List<String> _genders = [tr("male"), tr("female"),tr("Did_not_matter")];
  String _selectedGenders ="";
  List<String> _vacationStats = [tr("yes"), tr("no")];
  String _selectedVacationStats ="";
  String _selectedCity="";
  final _registerFormGlobalKey = GlobalKey<FormState>();
  File? _cLassImage = null;
  bool imageValid=true;
  var imageFile;
  String selectedCity="";
  AdoptionCategoriesModel?_selectedCategory;
  List<Map<String, dynamic>> filteredCities = [];
  final TextEditingController _searchController = TextEditingController();

  bool isKeboardopened=false;
  late StreamSubscription<bool> keyboardSubscription;



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
  void dispose() {
    keyboardSubscription.cancel();
    super.dispose();
  }
  void initState() {
    super.initState();
    AnalyticsHelper().setScreen(screenName: "شاشة-إضافة تبني");
    _getCitiesNameList();
    selectedCity=Constants.currentUser!.stateName??"";
    _selectedGenders=_genders[0];
    _selectedVacationStats=_vacationStats[0];
    _selectedCity=Constants.currentUser!.regionName??widget.data!.city??_citiesList[0];
    adoptionProviderModel=Provider.of<AdoptionProviderModel>(context,listen: false);
    if(widget.data!=null){
       _nameController.text = widget.data!.name??"";
       _phoneController.text = Constants.currentUser!.phone??"";
       _ageController.text = widget.data!.age??"";
       _genderController.text =widget.data!.gender??"" ;
       _typeController.text =widget.data!.type??"" ;
       _vaccitionController.text =widget.data!.vaccination??"";
       _cityController.text =widget.data!.city??"" ;
       _reasonController.text = widget.data!.reasonToGiveUp??"";
       _statusController.text = widget.data!.healthStatus??"";
       _conditionsController.text = widget.data!.conditions??"";
    }
    filteredCities.addAll(MyUtils.getCities());
    _searchController.addListener(_onSearchChanged);

    var keyboardVisibilityController = KeyboardVisibilityController();
    keyboardSubscription = keyboardVisibilityController.onChange.listen((bool visible) {
      setState(() {
        isKeboardopened=visible;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    adoptionProviderModel=Provider.of<AdoptionProviderModel>(context,listen: true);
    return BaseScreen(
      showSettings: false,
      showBottomBar: false,
      showWhatsIcon: false,
      padding: EdgeInsets.zero,

      tag: "AdoptionScreen",
      body: Scaffold(
        body: Container(
          color: C.BASE_BLUE,
          child: Column(
            children: [
              SizedBox(height: 30.h,),
              ActionBarWidget(widget.data!=null?tr("edit_adoption_title"):tr("add_adoption_title"), context,backgroundColor: C.ADAPTION_COLOR,),
              Expanded(
                  child: adoptionProviderModel!.isLoading?LoadingProgress():Container(
                      color: C.ADAPTION_COLOR,
                      child: Stack(
                        clipBehavior: Clip.none,
                        alignment: AlignmentDirectional.topCenter,
                        children: [
                          _whiteContainer(),
                          Positioned(child:
                          Container(
                            width: 75.w,
                            height: 48.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.3),
                                      offset: Offset(1, 1),
                                      blurRadius: 1,
                                      spreadRadius: 1)
                                ]),
                            child: InkWell(
                                onTap: () {
                                  _imgFromGallery();
                                },
                                child: _cLassImage!=null?TransitionImage(
                                    widget.data!=null?widget.data!.photo!:Res.DEFAULT_ADD_IMAGE,
                                    fit: BoxFit.cover,
                                    file:_cLassImage,
                                    radius: 10,
                                    padding: EdgeInsets.all(5.w),
                                    placeHolderImage: Res.DEFAULT_IMAGE,
                                    strokeColor: imageValid?Colors.white:Colors.red,
                                    strokeWidth: D.default_2):widget.data!=null?TransitionImage(
                                    widget.data!.photo!,
                                    fit: BoxFit.cover,
                                    radius: D.default_200,
                                    width: D.default_130,
                                    height: D.default_130,
                                    padding: EdgeInsets.all(D.default_10),
                                    placeHolderImage: Res.DEFAULT_IMAGE,
                                    strokeColor: imageValid?Colors.white:Colors.red,
                                    strokeWidth: D.default_2):Center(child: Icon(Icons.camera_alt_outlined,size: 40.h),)),),top:-8.h),
                        ],
                      )))
            ],
          ),
        ),
      ),
    );
  }

  Widget _whiteContainer() {
    return Container(
      margin: EdgeInsets.only(top: 17.h),
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30)),
          color: Color(0xffF0F0F0),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                offset: Offset(1, 1),
                blurRadius: 1,
                spreadRadius: 0.5)
          ]),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           SizedBox(
               height: 465.h,
               child: _dataForm()),
          Visibility(
            visible: !isKeboardopened,
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 10.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                SizedBox(height: 3.h,),
                Text(tr("alert"),style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w800),),
                SizedBox(height: 2.h,),
                Text(tr("add_animal_alert_body"),style: TextStyle(height: 1.3,color: Color(0xff4d4d4d),fontSize: 13.sp,fontWeight: FontWeight.w400),),
              ],),
            ),
          ),
          widget.data!=null?
              Container(child:Row(children: [
                Expanded(child: _editBtn()),
                SizedBox(width:D.default_20),
                Expanded(child: _deleteBtn()),
              ],))
              :_addBtn()
        ],),
      ),
    );
  }
  Widget _dataForm(){
    return Form(
      key: _registerFormGlobalKey,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(30),),
            color: Colors.white,
            ),
        padding: EdgeInsets.only(left: D.default_20,right: D.default_20,top: 27.h,bottom: D.default_10),
        child: ListView(
          padding: EdgeInsets.only(top: 10.h),
        children: [
          widget.data==null? _animalType():SizedBox(),
          SizedBox(height: 5.h,),
          _name(),
          SizedBox(height: 5.h,),
          _phone(),
          SizedBox(height: 5.h,),
          _age(),
          SizedBox(height: 5.h,),
          _gender(),
          SizedBox(height: 5.h,),
          _type(),
          SizedBox(height: 5.h,),
          _vacation(),
          SizedBox(height: 5.h,),
          _city(),
          SizedBox(height: 5.h,),
          _reason(),
          SizedBox(height: 5.h,),
          _status(),
          SizedBox(height: 5.h,),
          _conditions(),

        ],
      ),),
    );
  }
  Widget _name() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: Color(0xffF0F0F0),),
        width: double.infinity,
        child: Row(children: [
          Text(tr("animal_name")+": ",style: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.w800),),
          Expanded(
            child: TextFormField(

              controller: _nameController,
              validator: (name) {
                if (isFieldNotEmpty(name!)) {
                  return null;
                } else {
                  return tr("");
                }
              },
              decoration: InputDecoration(
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                border: InputBorder.none,
                errorStyle: S.h4(color: Colors.red),
                contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              ),
              style: TextStyle(fontSize:11.sp ),
              keyboardType: TextInputType.text,
              obscureText: false,
              scrollPadding:EdgeInsets.zero ,
              cursorColor: C.BASE_BLUE,
              autofocus: false,
            ),
          )
        ],));

  }
  Widget _phone() {
    return Row(children: [
      Expanded(child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Color(0xffF0F0F0),),
          width: double.infinity,
          child: Row(children: [
            Text(tr("contact_phone")+": ",style: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.w800),),
            Expanded(
              child: TextFormField(
                controller: _phoneController..text=Constants.currentUser!.phone??"",
                validator: (name) {
                  if (isFieldNotEmpty(name!)) {
                    return null;
                  } else {
                    return tr("");
                  }
                },
                enabled:false,
                decoration: InputDecoration(
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  border: InputBorder.none,
                  errorStyle: S.h4(color: Colors.red),
                  contentPadding: EdgeInsets.zero,
                ),
                style: TextStyle(fontSize:11.sp ),
                keyboardType: TextInputType.text,
                obscureText: false,
                cursorColor: C.BASE_BLUE,
                autofocus: false,
              ),
            )
          ],))),
      SizedBox(width: 5.w,),
      InkWell(
        onTap: (){
          Get.dialog(add_phone_popup(),);
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 5.w,vertical: 10.h),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: C.BASE_BLUE,
              ),
          child: Text(tr("change_num"),textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 11.sp,fontWeight: FontWeight.w800),),),
      )
    ],);
  }
  Widget _age() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: Color(0xffF0F0F0),),
        width: double.infinity,
        child: Row(children: [
          Text(tr("age")+": ",style: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.w800),),
          Expanded(
            child: TextFormField(

              controller: _ageController,
              validator: (name) {
                if (isFieldNotEmpty(name!)) {
                  return null;
                } else {
                  return tr("");
                }
              },
              decoration: InputDecoration(
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                border: InputBorder.none,
                errorStyle: S.h4(color: Colors.red),
                contentPadding: EdgeInsets.zero,
              ),
              style: TextStyle(fontSize:11.sp ),
              keyboardType: TextInputType.number,
              obscureText: false,
              cursorColor: C.BASE_BLUE,
              autofocus: false,
            ),
          )
        ],));
  }
  Widget _gender() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: Color(0xffF0F0F0),),
        width: double.infinity,
        child: Row(children: [
          Text(tr("gendar")+": ",style: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.w800),),
          _genderSpinner(0)
        ],));

  }
  Widget _type() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: Color(0xffF0F0F0),),
        width: double.infinity,
        child: Row(children: [
          Text(tr("type")+": ",style: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.w800),),
          Expanded(
            child: TextFormField(

              controller: _typeController,
              validator: (name) {
                if (isFieldNotEmpty(name!)) {
                  return null;
                } else {
                  return tr("");
                }
              },
              decoration: InputDecoration(
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                border: InputBorder.none,
                errorStyle: S.h4(color: Colors.red),
                contentPadding: EdgeInsets.zero,
              ),
              style: TextStyle(fontSize:11.sp ),
              keyboardType: TextInputType.text,
              obscureText: false,
              cursorColor: C.BASE_BLUE,
              autofocus: false,
            ),
          )
        ],));
  }
  Widget _vacation() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: Color(0xffF0F0F0),),
        width: double.infinity,
        child: Row(children: [
          Text(tr("vaccation")+": ",style: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.w800),),
          _vacationsSpinner(0)
        ],));
      Container(
        width: double.infinity,
        child: Column(children: [
          Container(child: Row(children: [
            Text(tr("vaccation"),style: TextStyle(fontWeight: FontWeight.w800,fontSize: 12.sp),),
            _vacationsSpinner(0)],),margin: EdgeInsets.only(left: D.default_20,right: D.default_20),),
          Container(width: MediaQuery.of(context).size.width,height: D.default_1,color: Colors.grey,)
        ],));
  }
  Widget _city() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 12.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: Color(0xffF0F0F0),),
        width: double.infinity,
        child: Row(children: [
          Text(tr("city")+": ",style: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.w800),),
          InkWell(
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
                                    selectedCity=_cityController.text;
                                    setState(() {

                                    });
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
            child: Text(selectedCity,style: TextStyle(fontSize: 11.sp),),)
        ],));

  }
  Widget _reason() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: Color(0xffF0F0F0),),
        width: double.infinity,
        child: Row(children: [
          Text(tr("reason")+": ",style: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.w800),),
          Expanded(
            child: TextFormField(

              controller: _reasonController,
              validator: (name) {
                if (isFieldNotEmpty(name!)) {
                  return null;
                } else {
                  return tr("");
                }
              },
              decoration: InputDecoration(
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                border: InputBorder.none,
                errorStyle: S.h4(color: Colors.red),
                contentPadding: EdgeInsets.zero,
              ),
              style: TextStyle(fontSize:11.sp ),
              keyboardType: TextInputType.text,
              obscureText: false,
              cursorColor: C.BASE_BLUE,
              autofocus: false,
            ),
          )
        ],));
  }
  Widget _status() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: Color(0xffF0F0F0),),
        width: double.infinity,
        child: Row(children: [
          Text(tr("status")+": ",style: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.w800),),
          Expanded(
            child: TextFormField(

              controller: _statusController,
              validator: (name) {
                if (isFieldNotEmpty(name!)) {
                  return null;
                } else {
                  return tr("");
                }
              },
              decoration: InputDecoration(
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                border: InputBorder.none,
                errorStyle: S.h4(color: Colors.red),
                contentPadding: EdgeInsets.zero,
              ),
              style: TextStyle(fontSize:11.sp ),
              keyboardType: TextInputType.text,
              obscureText: false,
              cursorColor: C.BASE_BLUE,
              autofocus: false,
            ),
          )
        ],));
  }
  Widget _conditions() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Color(0xffF0F0F0),),
        width: double.infinity,
        child: Row(children: [
          Text(tr("condition")+": ",style: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.w800),),
          Expanded(
            child: TextFormField(
              controller: _conditionsController,
              validator: (name) {
                if (isFieldNotEmpty(name!)) {
                  return null;
                } else {
                  return tr("");
                }
              },
              decoration: InputDecoration(
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                border: InputBorder.none,
                errorStyle: S.h4(color: Colors.red),
                contentPadding: EdgeInsets.zero,
              ),
              style: TextStyle(fontSize:11.sp ),
              keyboardType: TextInputType.text,
              obscureText: false,
              cursorColor: C.BASE_BLUE,
              autofocus: false,
            ),
          )
        ],));
  }

  _imgFromGallery() async {
    ImagePicker? imagePicker = ImagePicker();
    PickedFile? compressedImage = await imagePicker.getImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );
    setState(() {
      _cLassImage = File(compressedImage!.path);

    });
    String fileName = _cLassImage!.path.split('/').last;
    FormData formData = FormData.fromMap({
      "file":
      await MultipartFile.fromFile(_cLassImage!.path, filename:fileName),
    });
    imageFile=formData;
    _cLassImage!.length().then((value) => print("image size ${value}"));
  }

Widget _addBtn(){
    return InkWell(onTap: () async {
      if(_cLassImage==null){
        await Fluttertoast.showToast(msg: "قم باختيار صورة",backgroundColor: Colors.red,textColor: Colors.white,);
      }
      if(_selectedCategory==null){
        await Fluttertoast.showToast(msg: "قم باختيار نوع الأليف",backgroundColor: Colors.red,textColor: Colors.white,);
      }
      if(_cLassImage!=null&&!adoptionProviderModel!.isLoading&&_selectedCategory!=null){
        if (_registerFormGlobalKey.currentState!.validate()) {
          _registerFormGlobalKey.currentState!.save();
          MultipartFile mFile = await MultipartFile.fromFile(
            _cLassImage!.path, filename:  _cLassImage!.path.split('/').last,
            contentType: MediaType("image",  _cLassImage!.path.split('/').last.split(".").last),);
          FormData formData =  FormData.fromMap({
            "name":_nameController.text,
            "phone":_phoneController.text,
            "category_id":_selectedCategory!.id,
            "age":_ageController.text,
            "type":_typeController.text,
            "gender":_selectedGenders,
            "vaccination":_selectedVacationStats,
            "city":selectedCity,
            "reason_to_give_up":_reasonController.text,
            "health_status":_statusController.text,
            "conditions":_conditionsController.text,
            "photo": mFile,
          });
          adoptionProviderModel!.setAnimal(context,formData,_selectedCategory!.id!);

        }else{
          await Fluttertoast.showToast(msg: "تأكد من إدخال جميع البيانات",backgroundColor: Colors.red,textColor: Colors.white,);
        }
      }

    },child: Container(
        margin: EdgeInsets.only(bottom: 10.h,left: 80.w,right: 80.w,top: 10.h),
        padding: EdgeInsets.symmetric(vertical:4.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: C.ADAPTION_COLOR,
            ),
        child: Center(
          child: Text(
            tr("add_adoption_title"),
            style: TextStyle(color: Colors.white,fontSize: 14.sp,fontWeight: FontWeight.w700),
            textAlign: TextAlign.center,
          ),
        )),);
}
  Widget _editBtn(){
    return Visibility(
      visible: !isKeboardopened,
      child: InkWell(onTap: () async {

          if (_registerFormGlobalKey.currentState!.validate()) {
            _registerFormGlobalKey.currentState!.save();
            MultipartFile? mFile;
            if(_cLassImage!=null){
               mFile = await MultipartFile.fromFile(
                _cLassImage!.path, filename:  _cLassImage!.path.split('/').last,
                contentType: MediaType("image",  _cLassImage!.path.split('/').last.split(".").last),);
            }
            FormData formData =  FormData.fromMap({
              "name":_nameController.text,
              "phone":_phoneController.text,
              "category_id":widget.data!.categoryId,
              "age":_ageController.text,
              "type":_typeController.text,
              "gender":_selectedGenders,
              "vaccination":_selectedVacationStats,
              "city":selectedCity,
              "reason_to_give_up":_reasonController.text,
              "health_status":_statusController.text,
              "conditions":_conditionsController.text,
              "photo": mFile,
            });
            adoptionProviderModel!.editAnimal(context,formData,widget.data!.id!);
          }


      },child: Container(
          width: double.infinity,
          margin: EdgeInsets.only(bottom: 20.h,left: 15.w,right: 15.w,top: 10.h),
          padding: EdgeInsets.all(10.h),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(D.default_15),
              color: C.ADAPTION_COLOR,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    offset: Offset(1, 1),
                    blurRadius: 1,
                    spreadRadius: 1)
              ]),
          child: Center(
            child: Text(
              tr("edit_adoption"),
              style: TextStyle(color: Colors.white,fontSize: 14.sp,fontWeight: FontWeight.w800),
              textAlign: TextAlign.center,
            ),
          )),),
    );
  }
  Widget _deleteBtn(){
    return InkWell(onTap: () async {
      MyUtils.basePopup(context,body: DeletAnimalPopupScreen(title:tr("delete_animal_msg"), onAccept:(){
        adoptionProviderModel!.deleteAnimal(context,widget.data!.id!);
        Navigator.pop(context);
      },));
    },child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(bottom: 20.h,left: 15.w,right: 15.w,top: 10.h),
        padding: EdgeInsets.all(10.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(D.default_15),
            color: C.ADAPTION_COLOR,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  offset: Offset(1, 1),
                  blurRadius: 1,
                  spreadRadius: 1)
            ]),
        child: Center(
          child: Text(
            tr("delete_adoption"),
            style: TextStyle(color: Colors.white,fontSize: 14.sp,fontWeight: FontWeight.w800),
            textAlign: TextAlign.center,
          ),
        )),);
  }
  Widget _genderSpinner(int index) {
    return Container(
      height: D.default_50,
      width: D.default_180,
      margin: EdgeInsets.only(
          left: D.default_5, right: D.default_5, top: D.default_10),
      padding: EdgeInsets.only(left: D.default_20, right: D.default_20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(D.default_5),
          ),
      child: Center(
        child: DropdownButton<String>(
          underline: Container(),
          menuMaxHeight: D.default_200,
          borderRadius: BorderRadius.all(Radius.circular(D.default_10)),
          style: TextStyle(color: Colors.black),
          hint: Container(
            child: Text(
              _selectedGenders,
              style: S.h2(color: Colors.grey),
            ),
          ),
          isExpanded: false,
          items: _genders.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Container(
                child: Text(
                  value,
                  style: TextStyle(fontWeight: FontWeight.w800,fontSize: 12.sp),
                ),
              ),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _selectedGenders= value!;
            });
          },
        ),
      ),
    );
  }
  Widget _vacationsSpinner(int index) {
    return Container(
      height: D.default_50,
      margin: EdgeInsets.only(
          left: D.default_5, right: D.default_5, top: D.default_10),
      padding: EdgeInsets.only(left: D.default_20, right: D.default_20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(D.default_5),
      ),
      child: Center(
        child: DropdownButton<String>(
          underline: Container(),
          menuMaxHeight: D.default_200,
          borderRadius: BorderRadius.all(Radius.circular(D.default_10)),
          style: TextStyle(color: Colors.black),
          hint: Container(
            margin: EdgeInsets.all(D.default_10),
            child: Text(
              _selectedVacationStats,
              style: S.h2(color: Colors.grey),
            ),
          ),
          isExpanded: false,
          items: _vacationStats.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Container(
                child: Text(
                  value,
                  style: TextStyle(fontWeight: FontWeight.w800,fontSize: 12.sp),
                ),
              ),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _selectedVacationStats = value!;
            });
          },
        ),
      ),
    );
  }
  Widget _animalType() {
    return Container(
      height: 38.h,
      margin: EdgeInsets.only(
          left: D.default_5, right: D.default_5,),
      padding: EdgeInsets.only(left: D.default_20, right: D.default_20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(D.default_10),
          boxShadow:[BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              offset:Offset(0,0),
              blurRadius:3,
              spreadRadius: 0.5
          )]
      ),
      child: Center(
        child: DropdownButton<String>(
          iconSize: 40,
          underline: Container(),
          menuMaxHeight: D.default_200,
          borderRadius: BorderRadius.all(Radius.circular(D.default_10)),
          style: TextStyle(fontWeight: FontWeight.w800,fontSize: 12.sp,color: Colors.black),
          hint: Container(
            margin: EdgeInsets.all(5.h),
            child: Text(
              _selectedCategory!=null?_selectedCategory!.name??'':tr("select_animal_type"),
              style: TextStyle(fontWeight: FontWeight.w800,fontSize: 15.sp,color:Color(0xff3d3d3d),fontFamily: fontRegular ),
            ),
          ),
          isExpanded: false,
          items: List.generate(adoptionProviderModel!.categoriesList.length, (index){
            return DropdownMenuItem<String>(
              value: adoptionProviderModel!.categoriesList[index].name??'',
              child: Container(
                child: Text(
                  adoptionProviderModel!.categoriesList[index].name??'',
                  style: TextStyle(fontWeight: FontWeight.w800,fontSize: 12.sp),
                ),
              ),
            );
          }),
          onChanged: (value) {
            setState(() {
              _selectedCategory = adoptionProviderModel!.categoriesList.where((element) => element.name==value).single;
            });
          },
        ),
      ),
    );
  }
  List<String>_citiesList=[];

  _getCitiesNameList(){
    for(int i=0;i<Constants.STATES.length;i++){
      _citiesList.add(Constants.STATES[i].name??"");
    }
    setState(() {
      if(_citiesList.isNotEmpty) {
        _selectedCity=_citiesList[0];
      }
    });
  }
  Widget add_phone_popup(){
    return  Center(child:
      Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        InkWell(
          onTap: (){
            Get.back();
          },
          child: Container(
            margin: EdgeInsets.symmetric(vertical:3.h),
          height: 20.h,
          width: 20.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            color: Colors.white,
          ),
            child: Center(child:
              Icon(Icons.close_rounded,color: Colors.grey,),),
          ),
        ),
          Container(
            height: 120.h,
            width: 320.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: C.BASE_BLUE,
                ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("لتغيير  الرقم يجب التسجيل في التطبيق\nمن نفس الرقم الذي تريد إضافته في استمارة التبني",textAlign: TextAlign.center,style:TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w800,color: Colors.white,height: 1.8),),
                SizedBox(height: 10.h,),
                Text("وذلك لأن رقم التواصل يضاف تلقائياً بنفس الرقم\nالذي سجلت الدخول به في التطبيق",textAlign: TextAlign.center,style:TextStyle(fontSize: 13.sp,fontWeight: FontWeight.w500,color: Colors.white,height: 1.8),)
              ],),
          )
        ],),);
  }
}
