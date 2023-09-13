import 'package:flutter/material.dart';
import 'package:picstate/logic/constants.dart';

class MenuButton extends StatefulWidget {
  const MenuButton({
    super.key,
    required this.heading,
    required this.content,
    required this.color,
  });

  final String heading;
  final String content;
  final Gradient color;

  @override
  State<MenuButton> createState() => _MenuButtonState();
}

class _MenuButtonState extends State<MenuButton> {
  @override
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      // height: 50,
      // width: 200,
      duration: const Duration(milliseconds: 100),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        margin: const EdgeInsets.only(top: 15, left: 10, right: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border:
                Border.all(color: const Color.fromARGB(255, 0, 0, 0), width: 2),
            gradient: widget.color),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.heading,
              style: kTaskTextStyle.copyWith(fontSize: 18),
            ),
            Text(
              widget.content,
              style: kHintTextStyle.copyWith(
                  color: const Color.fromARGB(149, 0, 0, 0)),
            ),
          ],
        ),
      ),
    );
  }
}
