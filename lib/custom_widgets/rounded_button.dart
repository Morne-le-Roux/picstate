import 'package:flutter/material.dart';
import 'package:picstate/constants.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 50,
      decoration: BoxDecoration(
          color: kButtonColor,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          boxShadow: const [
            BoxShadow(
                color: Colors.black12,
                blurRadius: 5,
                spreadRadius: 1,
                offset: Offset(2, 2))
          ]),
      child: Center(
        child: Text(
          text,
          style: kButtonTextStyle,
        ),
      ),
    );
  }
}
