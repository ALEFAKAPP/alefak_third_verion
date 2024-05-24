import 'dart:convert';

import 'package:alefakaltawinea_animals_app/data/dio/dio_utils.dart';
import 'package:alefakaltawinea_animals_app/data/dio/my_rasponce.dart';
import 'package:alefakaltawinea_animals_app/modules/search/model/clinic_model.dart';
import 'package:alefakaltawinea_animals_app/modules/spalshScreen/data/regions_model.dart';
import '../../../utils/my_utils/apis.dart';
import '../../serviceProviders/list_screen/data/serviceProvidersModel.dart';
import '../model/animal_type_model.dart';
import 'package:dio/dio.dart';


class SearchApi{
  Future<MyResponse<List<RegionsModel>>> getCities() async {
    final url = "${Apis.GET_ALL_CITIES}";
    final response = await BaseDioUtils.request(BaseDioUtils.REQUEST_GET, url);
    if (response != null && response.statusCode == 200) {
      return MyResponse<List<RegionsModel>>.fromJson(
          json.decode(jsonEncode(response.data)));
    } else {
      return MyResponse<List<RegionsModel>>.init(response!.statusCode.toString(),response.statusMessage!, null);
    }
  }
  Future<MyResponse<List<AimalTypeModel>>> getAnimalsTypes() async {
    final url = "${Apis.GET_ANIMALS_TYPES}";
    final response = await BaseDioUtils.request(BaseDioUtils.REQUEST_GET, url);
    if (response != null && response.statusCode == 200) {
      return MyResponse<List<AimalTypeModel>>.fromJson(
          json.decode(jsonEncode(response.data)));
    } else {
      return MyResponse<List<AimalTypeModel>>.init(response!.statusCode.toString(),response.statusMessage!, null);
    }
  }

  Future<MyResponse<List<AimalTypeModel>>> getServiceClassifications() async {
    final url = "${Apis.GET_SERVICE_CLASSIFICATION}";
    final response = await BaseDioUtils.request(BaseDioUtils.REQUEST_GET, url);
    if (response != null && response.statusCode == 200) {
      return MyResponse<List<AimalTypeModel>>.fromJson(
          json.decode(jsonEncode(response.data)));
    } else {
      return MyResponse<List<AimalTypeModel>>.init(response!.statusCode.toString(),response.statusMessage!, null);
    }
  }

  Future<MyResponse<List<ClinicModel>>> getAllClinics() async {
    final url = "${Apis.GET_ALL_CLINICS}";
    final response = await BaseDioUtils.request(BaseDioUtils.REQUEST_GET, url);
    if (response != null && response.statusCode == 200) {
      return MyResponse<List<ClinicModel>>.fromJson(
          json.decode(jsonEncode(response.data)));
    } else {
      return MyResponse<List<ClinicModel>>.init(Apis.CODE_ERROR, "", null);
    }
  }
  Future<MyResponse<ServiceProviderModel>> getSearchData(Map<String,dynamic> data,int page)async {
    final url = "${Apis.GET_SERVICE_PROVIDERS_LIST}?page=$page";
    FormData formData =  FormData.fromMap(data);
    final response = await BaseDioUtils.request(BaseDioUtils.REQUEST_POST, url,body: formData,contentType:"application/json" );
    if (response != null && response.statusCode == 200) {
      return MyResponse<ServiceProviderModel>.fromJson(
          json.decode(jsonEncode(response.data)));
    } else {
      return MyResponse<ServiceProviderModel>.init(Apis.CODE_ERROR, "", null);
    }
  }
}