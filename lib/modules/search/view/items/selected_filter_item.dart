import 'package:flutter/Material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectedFilterItem extends StatelessWidget {
  final String title;
  final Function onClose;
  const SelectedFilterItem({required this.title,required this.onClose,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 2.h,horizontal: 10.w),

      decoration:  BoxDecoration(
        color: Color(0xffFF8B37).withOpacity(0.1),
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(title,),
      SizedBox(width: 2.w,),
      GestureDetector(
        onTap:(){
          onClose();
        },
        child:Icon(Icons.close,size: 20.w,))
    ],),);
  }
}
