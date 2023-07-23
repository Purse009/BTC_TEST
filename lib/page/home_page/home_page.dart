import 'dart:async';
import 'package:btc_test/page/history_page/history_page.dart';
import 'package:btc_test/page/home_page/home_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _btcController = TextEditingController();
  final _homePageController = Get.put(HomePageController());
  final _formKey = GlobalKey<FormState>();
  Timer? _timer;

  @override
  void initState() {
    _fetchData();
    super.initState();
  }

  _fetchData() async {
    await _homePageController.fetchCurrentPrice();
    _countTime();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Obx(() {
                return Column(
                  children: [
                    _insertBtcWidget(),
                    const SizedBox(
                      height: 20,
                    ),
                    _displayCard(
                        title: _homePageController
                                .getCurrentPrice.value.bpi?.usd?.description ??
                            "",
                        rate: _homePageController
                                .getCurrentPrice.value.bpi?.usd?.rate ??
                            "",
                        convert:
                            '${_homePageController.convert(rate: _homePageController.getCurrentPrice.value.bpi?.usd?.rateFloat, number: _btcController.text)}'),
                    const SizedBox(
                      height: 10,
                    ),
                    _displayCard(
                        title: _homePageController
                                .getCurrentPrice.value.bpi?.gbp?.description ??
                            "",
                        rate: _homePageController
                                .getCurrentPrice.value.bpi?.gbp?.rate ??
                            "",
                        convert:
                            '${_homePageController.convert(rate: _homePageController.getCurrentPrice.value.bpi?.gbp?.rateFloat, number: _btcController.text)}'),
                    const SizedBox(
                      height: 10,
                    ),
                    _displayCard(
                        title: _homePageController
                                .getCurrentPrice.value.bpi?.eur?.description ??
                            "",
                        rate: _homePageController
                                .getCurrentPrice.value.bpi?.eur?.rate ??
                            "",
                        convert:
                            '${_homePageController.convert(rate: _homePageController.getCurrentPrice.value.bpi?.eur?.rateFloat, number: _btcController.text)}'),
                    const SizedBox(
                      height: 60,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Form(key: _formKey, child: _validateWidget())
                  ],
                );
              })),
        ),
        bottomNavigationBar: ElevatedButton(
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Text(
              "History",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const HistoryPage(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _insertBtcWidget() {
    return TextField(
      controller: _btcController,
      keyboardType: TextInputType.number,
      onChanged: (value) {
        setState(() {});
      },
      decoration: const InputDecoration(
        hintText: "insert btc",
      ),
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
    );
  }

  Widget _validateWidget() {
    return TextFormField(
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value != null) {
          if (value.length > 6) {
            return 'input จะต้องมีความยาวมากกว่าหรือเท่ากับ 6 ตัวอักษร';
          }
          if (_homePageController.checkForDuplicateConsecutiveNumbers(value)) {
            return 'input จะต้องกันไม่ให้มีเลขซ้ำติดกันเกิน 2 ตัว';
          }

          if (_homePageController.checkForConsecutiveNumbers(value)) {
            return 'input จะต้องกันไม่ให้มีเลขเรียงกันเกิน 2 ตัว';
          }

          if (_homePageController.checkForDuplicateInputSet(value)) {
            return 'input จะต้องกันไม่ให้มีเลขชุดซ้ำ เกิน 2 ชุด';
          }
        }
        return null;
      },
      onChanged: (value) {
        _formKey.currentState?.validate();
        setState(() {});
      },
      decoration: const InputDecoration(
        hintText: "validate test",
      ),
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
    );
  }

  Widget _displayCard(
      {required String title, required String rate, required String convert}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          "rate : $rate",
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          "convert : $convert",
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  void _countTime() {
    if (mounted) {
      _timer = Timer.periodic(
        const Duration(minutes: 1),
        (Timer timer) async {
          _timer?.cancel();
          _fetchData();
        },
      );
    }
  }
}
