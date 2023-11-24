import 'package:flutter/Material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

showDialogProgress(context) {
  EasyLoading.show(status: "Please Wait....".tr);
}

hideDialogProgress(context) {
  EasyLoading.dismiss();
}

ShowSnackBar(BuildContext? context, {message, String type = 'error'}) {
  if (type == 'success') {
    showTopSnackBar(
      Overlay.of(context!)!,
      CustomSnackBar.success(
        message: message,
      ),
    );
  } else if (type == 'error') {
    showTopSnackBar(
      Overlay.of(context!)!,
      CustomSnackBar.error(
        message: message,
      ),
    );
  } else if (type == 'info') {
    showTopSnackBar(
      Overlay.of(context!)!,
      CustomSnackBar.info(
        message: message,
      ),
    );
  }
}
