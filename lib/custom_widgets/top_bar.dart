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
      // margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: const Border(bottom: BorderSide(color: Colors.black, width: 2)),
        gradient: kButtonColor,
      ),
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
