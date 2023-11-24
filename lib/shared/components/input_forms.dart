import 'package:alefakaltawinea_animals_app/shared/components/text.dart';
import 'package:alefakaltawinea_animals_app/shared/constance/colors.dart';
import 'package:alefakaltawinea_animals_app/shared/constance/fonts.dart';
import 'package:flutter/material.dart';

import '../constance/constance.dart';


Widget formField(context, hint,
    {isEnabled = true,
    isDummy = false,
    suffixImage = null,
    initialValue,
    controller,
    isPasswordVisible = false,
    isPassword = false,
    isPhone = false,
    keyboardType = TextInputType.text,
    FormFieldValidator<String>? validator,
    var onSaved,
    var onFieldSubmitted,
    var onChange,
    textInputAction = TextInputAction.next,
    FocusNode? focusNode,
    FocusNode? nextFocus,
    IconData? suffixIcon,
    Widget? prefixIcon ,
    Color filColor = ColorInputFiled,
    maxLine = 1,
    defaultRadius = 10.0,
    suffixIconSelector}) {
  return Container(

    child: TextFormField(
      controller: controller,
      obscureText: isPassword ? isPasswordVisible : false,
      cursorColor: textSecondaryColor,
      maxLines: maxLine,
      initialValue: initialValue,
      enabled: isEnabled,
      keyboardType: keyboardType,
      validator: validator,
      // onSaved: onSaved,
      onChanged: onChange,
      textInputAction: textInputAction,
      focusNode: focusNode,
      onFieldSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(defaultRadius),
            borderSide: BorderSide(color: fifthColor,width: 5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(defaultRadius),
          borderSide: BorderSide(
            color: primaryColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(defaultRadius),
          borderSide: BorderSide(
            color: fifthColor,
            width: 1.0,
          ),
        ),
        filled: true,
        fillColor: filColor,
        hintText: hint,
        hintStyle: TextStyle(fontSize: textSizeSMedium, color: fifthColor),
        prefixIcon:
        isPhone
            ?  GestureDetector(
          child:  Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Image(
              image: AssetImage(
                'assets/images/saudi-arabia.png',
              ),
              height: 10,
              width: 10,
            ),
          ),
        )

        :Icon(
                suffixIcon,
                color: textSecondaryColor,
                size: 20,
              ),

      ),
      style: TextStyle(
          fontSize: 16,
          color: isDummy ? Colors.transparent : textSecondaryColor),
    ),
  );
}

class InputFile extends StatelessWidget {
  Color? colorForm;
  double? height = heightInputFiled;
  Function()? onTap;

  InputFile({this.colorForm = ColorInputFiled, this.height, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        color: colorForm,
        height: height,
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Center(
            child: DefaultText(
              text: '+',
              color: thirdColor,
              fontSize: textSizeNormal,
              boldText: true,
            ),
          ),
        ),
      ),
    );
  }
}
