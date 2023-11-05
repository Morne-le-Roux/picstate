import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Calculator {
  TextEditingController setupCostController = TextEditingController();
  TextEditingController printingCostController = TextEditingController();
  late int selectedSize;
  late int selectedFinish;

  calculate() {
    int setupCost = int.parse(setupCostController.text);
    double printingCost = double.parse(printingCostController.text);
    double calculatedPrice = 0;

    int invoicesOnPage = selectedSize == 0
        ? 4 //If A6 sets 4 invoices on page
        : selectedSize == 1
            ? 2 //If A5 sets 2 invoices on page
            : 1; //If A4 sets 1 invoice on page

    if (selectedFinish == 0) {
      calculatedPrice = ((200 / invoicesOnPage) * printingCost) + setupCost;
    }

    if (selectedFinish == 1) {
      calculatedPrice = ((150 / invoicesOnPage) * printingCost) + setupCost;
    }

    return calculatedPrice;
  }
}
