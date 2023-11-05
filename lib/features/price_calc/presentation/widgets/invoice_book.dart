import 'package:countup/countup.dart';
import "package:flutter/material.dart";
import 'package:picstate/config/constants.dart';
import 'package:picstate/core/widgets/rounded_button.dart';
import 'package:picstate/features/price_calc/controllers/calculator.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            RoundedButton(
                text: "Calculate!",
                onTap: () {
                  setState(() {
                    calculatedCost = calc.calculate();
                  });
                }),
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
                    const Expanded(
                        flex: 1,
                        child: Icon(Icons.save, color: Colors.black45)),
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
                    const Expanded(
                        flex: 1,
                        child: Icon(Icons.save, color: Colors.black45)),
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
    );
  }
}
