import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:alefakaltawinea_animals_app/data/dio/dio_utils.dart';
import 'package:alefakaltawinea_animals_app/data/dio/my_rasponce.dart';
import 'package:alefakaltawinea_animals_app/modules/cart/add_cart_model.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/apis.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class BuyCardRemote {

  Future saveDataCards({required Carts cards}) async {
    final url = "${Apis.ADD_CART}?skip=0";
    final response = await BaseDioUtils.request(BaseDioUtils.REQUEST_POST, url,body: cards.toJson());
    if (response != null && response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

    Future<MyResponse<String>> uploadCartImage({file}) async {
      MultipartFile mFile = await MultipartFile.fromFile(
        file.path, filename:  file.path.split('/').last,
        contentType: MediaType("image",  file.path.split('/').last.split(".").last),);
      FormData formData =  FormData.fromMap({
        "file": mFile,
      });
      final url = "${Apis.UPLOAD_CART_IMAGE}";
      final response = await BaseDioUtils.request(BaseDioUtils.REQUEST_POST, url,body: formData);
      if (response != null && response.statusCode == 200) {
        return MyResponse<String>.fromJson(
            json.decode(jsonEncode(response.data)));
      } else {
        return MyResponse<String>.init(Apis.CODE_ERROR, "", null);
      }
    }

  Future uploadImage({file}) async {
    var headers = {
      "Accept": "application/json",
    };

    http.MultipartRequest request = new http.MultipartRequest("POST", Uri.parse(Apis.UPLOAD_CART_IMAGE_V2));
    // var bytes = images.map((el) => el.path);
    request.headers['authorization'] = 'Bearer ${Apis.TOKEN_VALUE}';
    if (file != null) {
      request.files.add(await http.MultipartFile.fromPath('file', file.path));
    }

    request.headers.addAll(headers);
    print(request.headers);
    print(request);
    var response = await request.send();
    final respStr = await response.stream.bytesToString();
    print('${respStr}');
    if (response != null && response.statusCode == 200) {
      return MyResponse<String>.fromJson(jsonDecode(respStr));
    } else {
      return MyResponse<String>.init(Apis.CODE_ERROR, "", null);
    }
  }

}