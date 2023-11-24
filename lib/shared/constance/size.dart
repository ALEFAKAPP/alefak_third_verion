import 'package:flutter/material.dart';
import 'package:get/get.dart';


const heightInputFiled = 50.0;

const border_radius_sm = 5.0;
const border_radius_default = 8.0;

//Box Shadow
const defaultBlurRadius = 8.0;
const defaultSpreadRadius = 3.0;

const defaultPaddingBody = 17.0;

widthScreenSize(double size ){
  return Get.width * size;
}
heightScreenSize(double size ){
  return Get.height * size;
}

defaultPadding () {
  return const EdgeInsets.only(right: 10,left: 10,top: 10,bottom: 10);
}

class TextEditController extends StatefulWidget {
  @override
  _TextEditControllerState createState() => _TextEditControllerState();
}

class _TextEditControllerState extends State<TextEditController> {
   TextEditingController _emailController = TextEditingController();
   TextEditingController _phoneController = TextEditingController();

  @override
  void initState() {
    TextEditingController(text: 'hisham@gmail.com'); // Wrong
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
