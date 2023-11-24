import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:image_picker/image_picker.dart';

showSelectionDialog(BuildContext context, controller, index) {
  return
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.only(right: 10.0,left:10.0,top: 50.0,bottom: 50.0 ),
          child: Wrap(
            children: [
              // text("أضف صورة بواسطة؟".tr,isBold: true,fontSize: 18.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  GestureDetector(
                    child: Column(
                      children: [
                        Image.asset('assets/images/camera.png',height: 70,),
                        Text("كاميرا".tr),
                      ],
                    ),
                    onTap: () {
                      controller.openPick(2, index);
                    },
                  ),
                  Padding(padding: EdgeInsets.all(8.0)),
                  GestureDetector(
                    child: Column(
                      children: [
                        Image.asset('assets/images/gallery.png',height: 70,),
                        Text("معرض الصور".tr),
                      ],
                    ),
                    onTap: () {
                      controller.openPick(1, index);
                    },
                  )
                ],
              ),
            ],
          ),
        );
      },
    );

}

showSelectionDialog2(BuildContext context, {controller, multi = false}) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("أضف صورة بواسطة؟".tr),
          content: SingleChildScrollView(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(
                  child: Column(
                    children: [
                      Icon(
                        Icons.camera_alt,
                        size: 30,
                      ),
                      Text("كاميرا".tr),
                    ],
                  ),
                  onTap: () {
                    print('2');
                    multi == false
                        ? controller.openPick(2)
                        : controller.pickImagesProblemCamera(
                            ImageSource.camera,
                            context: context,
                            isMultiImage: true,
                          );
                  },
                ),
                Padding(padding: EdgeInsets.all(8.0)),
                GestureDetector(
                  child: Column(
                    children: [
                      Icon(
                        Icons.photo_size_select_actual_outlined,
                        size: 30,
                      ),
                      Text("معرض الصور".tr),
                    ],
                  ),
                  onTap: () {
                    print('1');
                    multi == false
                        ? controller.openPick(1)
                        : controller.pickImagesProblem(
                            ImageSource.gallery,
                            context: context,
                            isMultiImage: true,
                          );
                  },
                )
              ],
            ),
          ),
        );
      });
}
