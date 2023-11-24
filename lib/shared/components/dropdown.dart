import 'package:flutter/material.dart';

Widget defultDropdown({
  @required String? hint,
  @required var items,
  ValueChanged? onChanged,
  @required var value,
  var isWidth = true,
  Color? color,
}) =>
    Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
          color: Color(0xFFE4E4E4),
          border: Border.all(color: Colors.transparent)),
      width: isWidth == false ? 130 : null,
      child: DropdownButtonHideUnderline(
        child: ButtonTheme(
          alignedDropdown: true,
          child: DropdownButton(
            isExpanded: isWidth == false ? true : false,
            items: items,
            onChanged: onChanged,
            hint: Text(hint!,style: TextStyle(fontSize: 13),),
            value: value,
          ),
        ),
      ),
    );
