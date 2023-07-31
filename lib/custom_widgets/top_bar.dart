import 'package:flutter/material.dart';
import 'package:picstate/constants.dart';

class TopBar extends StatelessWidget {
  const TopBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: kButtonColor,
          border: Border.all(color: Colors.black87, width: 1.5)),
      height: 60,
      width: double.infinity,
      child: FittedBox(
        fit: BoxFit.contain,
        child: Text(
          'PRINT&IMAGE CENTRE',
          style: kTaskTextStyle.copyWith(
              fontStyle: FontStyle.italic,
              color: Colors.white60,
              shadows: <Shadow>[]),
        ),
      ),
    );
  }
}
