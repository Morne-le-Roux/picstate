import "package:flutter/material.dart";
import 'package:picstate/features/price_calc/controllers/calculator.dart';

class InvoiceBook extends StatelessWidget {
  const InvoiceBook({super.key});

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
            const SizedBox(height: 20),
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
          ],
        ),
      ),
    );
  }
}
