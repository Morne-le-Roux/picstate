import 'package:countup/countup.dart';
import "package:flutter/material.dart";
import 'package:picstate/config/constants.dart';
import 'package:picstate/core/widgets/rounded_button.dart';
import 'package:picstate/features/price_calc/controllers/calculator.dart';
import 'package:picstate/features/price_calc/domain/shared_prefs.dart';

class InvoiceBook extends StatefulWidget {
  const InvoiceBook({super.key});

  @override
  State<InvoiceBook> createState() => _InvoiceBookState();
}

class _InvoiceBookState extends State<InvoiceBook> {
  final List<bool> _bookSizeSelected = List.generate(3, (_) => false);
  final List<bool> _bookFinishSelected = List.generate(2, (_) => false);
  Calculator calc = Calculator();
  double calculatedCost = 0;
  bool _loading = true;

  _getData() async {
    StoredData storedData = StoredData();
    await storedData.initPreferences();
    calc.setupCostController.text =
        storedData.getStoredData(key: "invoiceBookSetupCost").toString();
    print(calc.setupCostController.text);

    calc.printingCostController.text =
        storedData.getStoredData(key: "invoiceBookPrintingCost").toString();
    print(calc.printingCostController.text);

    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: !_loading,
      replacement: Center(
          child: Text(
        "Loading.",
        style: kTaskTextStyle.copyWith(color: Colors.white, fontSize: 50),
      )),
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              //CALCULATE BUTTTON
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  RoundedButton(
                      text: "Calculate!",
                      onTap: () {
                        setState(() {
                          calculatedCost = calc.calculate();
                        });
                      }),
                  RoundedButton(
                      text: "Close",
                      onTap: () {
                        setState(() {
                          Navigator.pop(context);
                        });
                      })
                ],
              ),
              //CALCULATE BUTTON

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flex(
                    direction: Axis.horizontal,
                    children: [
                      const Expanded(flex: 4, child: Text("Setup Cost")),
                      Expanded(
                          flex: 2,
                          child: SizedBox(
                              width: 100,
                              child: TextField(
                                decoration:
                                    const InputDecoration(prefixText: "R"),
                                keyboardType: TextInputType.number,
                                controller: calc.setupCostController,
                              ))),
                      Expanded(
                          flex: 1,
                          child: InkWell(
                              onTap: () async {
                                StoredData storedData = StoredData();
                                await storedData.initPreferences();
                                storedData.setStoredData(
                                    key: "invoiceBookSetupCost",
                                    value: calc.setupCostController.text);
                              },
                              child: const Icon(Icons.save,
                                  color: Colors.black45))),
                    ],
                  ),

                  //DIVIDER
                  const SizedBox(height: 40),
                  Flex(
                    direction: Axis.horizontal,
                    children: [
                      const Expanded(
                          flex: 4, child: Text("Printing Cost (Per Page)")),
                      Expanded(
                          flex: 2,
                          child: SizedBox(
                              width: 100,
                              child: TextField(
                                decoration:
                                    const InputDecoration(prefixText: "R"),
                                keyboardType: TextInputType.number,
                                controller: calc.printingCostController,
                              ))),
                      Expanded(
                          flex: 1,
                          child: InkWell(
                              onTap: () async {
                                StoredData storedData = StoredData();
                                await storedData.initPreferences();
                                storedData.setStoredData(
                                    key: "invoiceBookPrintingCost",
                                    value: calc.printingCostController.text);
                              },
                              child: const Icon(Icons.save,
                                  color: Colors.black45))),
                    ],
                  ),

                  //DIVIDER
                  const SizedBox(height: 40),
                  //DIVIDER

                  Center(
                    child: ToggleButtons(
                      borderRadius: BorderRadius.circular(20),
                      constraints:
                          const BoxConstraints(minHeight: 50, minWidth: 100),
                      isSelected: _bookSizeSelected,
                      onPressed: (index) {
                        setState(() {
                          for (var i = 0; i < _bookSizeSelected.length; i++) {
                            _bookSizeSelected[i] = i == index;
                            calc.selectedSize = index;
                          }
                        });
                      },
                      children: const [
                        Text("A6"),
                        Text("A5"),
                        Text("A4"),
                      ],
                    ),
                  ),

                  //DIVIDER
                  const SizedBox(height: 40),
                  //DIVIDER

                  Center(
                    child: ToggleButtons(
                      borderRadius: BorderRadius.circular(20),
                      constraints:
                          const BoxConstraints(minHeight: 50, minWidth: 100),
                      isSelected: _bookFinishSelected,
                      onPressed: (index) {
                        setState(() {
                          for (var i = 0; i < _bookFinishSelected.length; i++) {
                            _bookFinishSelected[i] = i == index;
                            calc.selectedFinish = index;
                          }
                        });
                      },
                      children: const [
                        Text("Duplicate"),
                        Text("Triplicate"),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 80),
                child: Visibility(
                    visible: calculatedCost == 0 ? false : true,
                    child: Countup(
                      begin: 0,
                      end: calculatedCost,
                      duration: const Duration(seconds: 2),
                      prefix: "R",
                      style: kTaskTextStyle.copyWith(fontSize: 80),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
