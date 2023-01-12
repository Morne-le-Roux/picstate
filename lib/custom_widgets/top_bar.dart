import 'package:flutter/material.dart';
import 'package:picstate/constants.dart';

class TopBar extends StatelessWidget {
  const TopBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      color: Colors.amber,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '"//TODO: Insert corny productivity quote here."',
            style: kTaskTextStyle.copyWith(
                fontStyle: FontStyle.italic, color: Colors.white60),
          )
        ],
      ),
    );
  }
}
