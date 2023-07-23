import 'dart:convert';
import 'dart:developer';

import 'package:btc_test/model/current_price_model.dart';
import 'package:btc_test/service/current_price_service.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePageController extends GetxController {
  var getCurrentPrice = CurrentPriceModel().obs;
  var getHistoryCurrentPrice = CurrentPriceModel().obs;

  RxList<CurrentPriceModel?> getDataHistoryList = RxList();
  final List<String> _inputHistory = [];

  Future<CurrentPriceModel?> fetchCurrentPrice() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    CurrentPriceModel? response =
        await CurrentPriceService().fetchCurrentPrice();
    getCurrentPrice(response);

    prefs.setString("save", jsonEncode(getCurrentPrice.value.toJson()));

    return response;
  }

  double convert({required double? rate, required String? number}) {
    double? numDouble = 0;
    numDouble = ((number?.isEmpty ?? false) || number == ".")
        ? 0
        : double.parse(number ?? "0");
    return (numDouble) / (rate ?? 0.0);
  }

  Future<String> fetchDataHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var dataHistory = jsonDecode(prefs.getString('save') ?? '');

    getHistoryCurrentPrice(CurrentPriceModel.fromJson(dataHistory));

    return prefs.getString('save') ?? '';
  }

  bool checkForDuplicateConsecutiveNumbers(String value) {
    for (int i = 0; i < value.length - 2; i++) {
      if (value[i] == value[i + 1] && value[i] == value[i + 2]) {
        return true;
      }
    }
    return false;
  }

  bool checkForConsecutiveNumbers(String value) {
    for (int i = 0; i < value.length - 2; i++) {
      if (int.parse(value[i]) + 1 == int.parse(value[i + 1]) &&
          int.parse(value[i + 1]) + 1 == int.parse(value[i + 2])) {
        return true;
      }
    }
    return false;
  }

  bool checkForDuplicateInputSet(String value) {
    _inputHistory.add(value);
    int count = 0;
    for (String input in _inputHistory) {
      if (input == value) {
        count++;
        if (count > 2) {
          return true;
        }
      }
    }
    return false;
  }
}
