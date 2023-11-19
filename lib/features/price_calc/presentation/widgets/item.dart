import 'package:flutter/material.dart';
import 'package:picstate/config/constants.dart';
import 'package:picstate/features/price_calc/presentation/widgets/invoice_book.dart';

class Item extends StatelessWidget {
  final String name;
  final int index;
  const Item({
    super.key,
    required this.name,
    required this.index,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return const InvoiceBook();
          },
        );
      },
      child: Material(
        elevation: 5,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          //height of the widget
          height: 60,
          decoration: BoxDecoration(
            //gradient settings
            gradient: LinearGradient(
                //Based on Task inedx in the listviewbuilder, will invert the gradient so the tasks separate a bit better in list view
                begin: index % 2 == 0
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                end: index % 2 == 0
                    ? Alignment.centerLeft
                    : Alignment.centerRight,
                //gradient color
                colors: kColorTodo),
          ),
          child: Container(
            margin: const EdgeInsets.all(4),
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Center(
              child: Text(
                name,
                style: kTaskTextStyle.copyWith(fontSize: 20),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
