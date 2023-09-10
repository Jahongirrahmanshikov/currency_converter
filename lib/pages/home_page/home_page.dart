import 'package:circle_flags/circle_flags.dart';
import 'package:currency_converter/styles/app_color.dart';
import 'controller/home_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeController controller;
  TextEditingController _textController = TextEditingController();

  double height = 80;

  _HomePageState() {
    controller = HomeController(setState)..getApiData();
  }

  @override
  Widget build(BuildContext context) {
    bool isLoading = controller.isLoading;
    return SafeArea(
      child: isLoading == true
          ? const Center(child: CircularProgressIndicator())
          : Scaffold(
              backgroundColor: AppColors.bg,
              resizeToAvoidBottomInset: false,
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  children: [
                    const SizedBox(height: 15),
                    const Text(
                      "Currency Converter",
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: height),
                    Column(
                      children: [
                        DecoratedBox(
                          decoration: const BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: TextField(
                            controller: _textController,
                            onTap: () {
                              height = 20;
                              setState(() {});
                            },
                            onEditingComplete: () {
                              height = 80;
                              setState(() {});
                            },
                            onChanged: controller.inputAmountText,
                            cursorColor: AppColors.white,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w500,
                            ),
                            decoration: InputDecoration(
                              hintText:
                                  controller.resultAmount == null ? "0" : "1",
                              border: const UnderlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            DropdownMenu(
                              menuHeight: 200,
                              initialSelection: controller.amountCcy,
                              onSelected: controller.changeAmountCcy,
                              textStyle: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 17,
                              ),
                              leadingIcon: CircleFlag(
                                controller.amountCcy?.substring(0, 2) ?? "",
                                size: 24,
                              ),
                              width: 140,
                              inputDecorationTheme: const InputDecorationTheme(
                                filled: true,
                                fillColor: AppColors.white,
                              ),
                              dropdownMenuEntries:
                                  controller.currenciesString.map((e) {
                                return DropdownMenuEntry(
                                  value: e,
                                  label: e,
                                );
                              }).toList(),
                            ),
                            SizedBox(
                              width: 50,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () {
                                  String? temp = controller.amountCcy;
                                  controller.amountCcy =
                                      controller.convertedAmountCcy;
                                  controller.convertedAmountCcy = temp;
                                  controller.resultAmount = "0";
                                  _textController.clear();
                                  setState(() {});
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.blue,
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(13.0),
                                  child: Center(
                                    child: RotatedBox(
                                      quarterTurns: 1,
                                      child: Icon(
                                        CupertinoIcons.arrow_up_arrow_down,
                                        color: AppColors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            DropdownMenu(
                              onSelected: controller.changeConvertedAmountCcy,
                              textStyle: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 17,
                              ),
                              menuHeight: 200,
                              leadingIcon: CircleFlag(
                                controller.convertedAmountCcy
                                        ?.substring(0, 2) ??
                                    "",
                                size: 24,
                              ),
                              width: 140,
                              inputDecorationTheme: const InputDecorationTheme(
                                filled: true,
                                fillColor: AppColors.white,
                              ),
                              initialSelection: controller.convertedAmountCcy,
                              dropdownMenuEntries:
                                  controller.currenciesString.map((e) {
                                return DropdownMenuEntry(
                                  value: e,
                                  label: e,
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                        SizedBox(height: height),
                        SizedBox(
                          width: double.infinity,
                          height: 180,
                          child: DecoratedBox(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                              color: AppColors.white,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  children: [
                                    const Text(
                                      "Result:",
                                      style: TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      controller.resultAmount ?? "0",
                                      maxLines: 1,
                                      style: const TextStyle(
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.blue,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "1 ${controller.amountCcy} = ${controller.oneResultAmount} ${controller.convertedAmountCcy})",
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
