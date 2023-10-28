import "package:flutter/material.dart";
import 'package:picstate/features/price_calc/controllers/calculator.dart';

class InvoiceBook extends StatefulWidget {
  const InvoiceBook({super.key});

  @override
  State<InvoiceBook> createState() => _InvoiceBookState();
}

class _InvoiceBookState extends State<InvoiceBook> {
  final List<bool> _bookSizeSelected = List.generate(3, (_) => false);

  @override
  Widget build(BuildContext context) {
    Calculator calc = Calculator();
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          decoration: const InputDecoration(prefixText: "R"),
                          keyboardType: TextInputType.number,
                          controller: calc.setupCost,
                        ))),
                const Expanded(
                    flex: 1, child: Icon(Icons.save, color: Colors.black45)),
              ],
            ),
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
                          decoration: const InputDecoration(prefixText: "R"),
                          keyboardType: TextInputType.number,
                          controller: calc.printingCost,
                        ))),
                const Expanded(
                    flex: 1, child: Icon(Icons.save, color: Colors.black45)),
              ],
            ),
            Center(
              child: ToggleButtons(
                borderRadius: BorderRadius.circular(20),
                constraints: const BoxConstraints(minHeight: 50, minWidth: 100),
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
          ],
        ),
      ),
    );
  }
}
