import '../../../constants/api_constants.dart';
import '../../../models/currency_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'dart:convert';

class HomeController {
  bool isLoading = true;
  String? amountCcy;
  String? convertedAmountCcy;
  String? resultAmount;
  String? oneResultAmount;
  String inputAmount = "1";
  List<String> currenciesString = ["UZS"];

  List<CurrencyModel> currencies = [
    const CurrencyModel(
      id: 0,
      code: "uz",
      ccy: "UZS",
      ccyNmRU: "",
      ccyNmUZ: "",
      ccyNmUZC: "",
      ccyNmEN: "",
      nominal: "1",
      rate: "1",
      diff: "",
      date: "",
    ),
  ];

  void Function(void Function()) update;

  HomeController(this.update);

  void getApiData() async {
    Response? response;

    try {
      final url = Uri.parse(ApiConstants.currencyPath);
      response = await get(url);
    } catch (e, stackTrace) {
      debugPrint("$e\n\n$stackTrace");
    }

    final List<Map<String, Object?>> data =
        List<Map<String, Object?>>.from(jsonDecode(response?.body ?? ""));
    for (final e in data) {
      debugPrint(CurrencyModel.fromJson(e).toString());
      currencies.add(CurrencyModel.fromJson(e));
      currenciesString.add(CurrencyModel.fromJson(e).ccy);
    }

    amountCcy = currencies.first.ccy;
    convertedAmountCcy = currencies.skip(1).first.ccy;
    oneResultAmount = convertAmount(
        "1", currencies.first.rate, currencies.skip(1).first.rate);
    isLoading = false;
    update(() {});
  }

  void inputAmountText(String value) {
    inputAmount = value == "" ? "1" : value;
    update(() {});

    resultAmount = convertAmount(
      inputAmount,
      currencies.firstWhere((e) => e.ccy == amountCcy).rate,
      currencies.firstWhere((e) => e.ccy == convertedAmountCcy).rate,
    );

    update(() {});
  }

  void changeAmountCcy(String? newCcy) {
    amountCcy = newCcy;
    

    oneResultAmount = convertAmount(
      "1",
      currencies.firstWhere((e) => e.ccy == amountCcy).rate,
      currencies.firstWhere((e) => e.ccy == convertedAmountCcy).rate,
    );

    resultAmount = convertAmount(
      inputAmount,
      currencies.firstWhere((e) => e.ccy == amountCcy).rate,
      currencies.firstWhere((e) => e.ccy == convertedAmountCcy).rate,
    );

    update(() {});
  }

  void changeConvertedAmountCcy(String? newCcy) {
    convertedAmountCcy = newCcy;

    oneResultAmount = convertAmount(
      "1",
      currencies.firstWhere((e) => e.ccy == amountCcy).rate,
      currencies.firstWhere((e) => e.ccy == convertedAmountCcy).rate,
    );

    resultAmount = convertAmount(
      inputAmount,
      currencies.firstWhere((e) => e.ccy == amountCcy).rate,
      currencies.firstWhere((e) => e.ccy == convertedAmountCcy).rate,
    );

    update(() {});
  }

  String convertAmount(String? inputAmountInCcy, String? amountInCcy,
      String? convertedAmountInCcy) {
    double? a = double.tryParse(inputAmountInCcy ?? "");
    double? b = double.tryParse(amountInCcy ?? "");
    double? c = double.tryParse(convertedAmountInCcy ?? "");

    if (a == null || b == null || c == null) {
      throw const FormatException("Convert Amount data is empty");
    }

    return ((a * b) / c).toStringAsFixed(4);
  }

  String initialSelection() {
    Future.delayed(const Duration(seconds: 1), () => update(() {}));
    return currencies.first.ccy;
  }

  void change() {
    String? temp = amountCcy;
    amountCcy = convertedAmountCcy;
    convertedAmountCcy = temp;
    convertAmount(inputAmount, amountCcy, convertedAmountCcy);
    update(() {});
  }
}
