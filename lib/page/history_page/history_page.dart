import 'package:btc_test/page/home_page/home_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final _homePageController = Get.put(HomePageController());

  @override
  void initState() {
    _fetchData();
    super.initState();
  }

  _fetchData() async {
    await _homePageController.fetchDataHistory();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Obx(() {
              return Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  _displayCard(
                    date: _homePageController
                            .getHistoryCurrentPrice.value.time?.updated ??
                        "",
                    title: _homePageController.getHistoryCurrentPrice.value.bpi
                            ?.usd?.description ??
                        "",
                    rate: _homePageController
                            .getHistoryCurrentPrice.value.bpi?.usd?.rate ??
                        "",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  _displayCard(
                    date: _homePageController
                            .getHistoryCurrentPrice.value.time?.updated ??
                        "",
                    title: _homePageController.getHistoryCurrentPrice.value.bpi
                            ?.gbp?.description ??
                        "",
                    rate: _homePageController
                            .getHistoryCurrentPrice.value.bpi?.gbp?.rate ??
                        "",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  _displayCard(
                    date: _homePageController
                            .getHistoryCurrentPrice.value.time?.updated ??
                        "",
                    title: _homePageController.getHistoryCurrentPrice.value.bpi
                            ?.eur?.description ??
                        "",
                    rate: _homePageController
                            .getHistoryCurrentPrice.value.bpi?.eur?.rate ??
                        "",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              );
            })),
      ),
    );
  }

  Widget _displayCard({
    required String date,
    required String title,
    required String rate,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(
          height: 10,
        ),
        Text(
          date,
          textAlign: TextAlign.center,
        ),
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
      ],
    );
  }
}
