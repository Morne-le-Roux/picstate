import 'package:flutter/material.dart';
import 'package:picstate/constants.dart';

class TopBar extends StatelessWidget {
  const TopBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: kButtonColor,
          border: Border.all(color: Colors.black87, width: 1.5)),
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'PRINT&IMAGE CENTRE',
            style: kTaskTextStyle.copyWith(
                fontSize: 45,
                fontStyle: FontStyle.italic,
                color: Colors.white60,
                shadows: <Shadow>[]),
          )
        ],
      ),
    );
  }
}
