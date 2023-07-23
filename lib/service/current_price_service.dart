import 'dart:convert';

import 'package:btc_test/helper/dio_helper.dart';
import 'package:btc_test/model/current_price_model.dart';
import 'package:btc_test/service/api_path.dart';
import 'package:dio/dio.dart';


class CurrentPriceService {
  final DioHelper _helper = DioHelper();
  Dio? dio;

  Future<CurrentPriceModel?> fetchCurrentPrice() async {
    try {
      dio = await _helper.dioWithHeader();
      Response response = await dio!.get(APIPath.currentPrice);
      var feature = CurrentPriceModel.fromJson(jsonDecode(response.data));
      if (response.statusCode == 200) {
        response.data = feature;
        return response.data;
      }
      return response.data;
    } on DioError catch (e) {
      return e.response?.data;
    }
  }
}
