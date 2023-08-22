import 'package:flutter/material.dart';
import 'package:picstate/constants.dart';

class MenuButton extends StatelessWidget {
  const MenuButton({
    super.key,
    required this.heading,
    required this.content,
  });

  final String heading;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      margin: const EdgeInsets.only(top: 15, left: 10, right: 10),
      decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black, width: 2),
          gradient: kButtonColor),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            heading,
            style: kTaskTextStyle.copyWith(fontSize: 18),
          ),
          Text(
            content,
            style: kHintTextStyle.copyWith(
                color: const Color.fromARGB(149, 0, 0, 0)),
          ),
        ],
      ),
    );
  }
}
