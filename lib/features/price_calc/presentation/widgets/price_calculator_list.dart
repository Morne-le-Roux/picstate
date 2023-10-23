import 'package:flutter/material.dart';
import 'package:picstate/features/price_calc/models/items_model.dart';
import 'package:picstate/features/price_calc/presentation/widgets/item.dart';

class PriceCalculatorList extends StatefulWidget {
  const PriceCalculatorList({super.key});

  @override
  State<PriceCalculatorList> createState() => _PriceCalculatorListState();
}

class _PriceCalculatorListState extends State<PriceCalculatorList> {
  final ItemsModel _items = ItemsModel();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: _items.itemsList.length,
        itemBuilder: (context, index) => Item(
          name: _items.itemsList[index],
          index: index,
        ),
      ),
    );
  }
}
