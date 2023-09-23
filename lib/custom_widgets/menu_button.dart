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
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: AnimatedContainer(
        width: 200,
        height: 100,
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.only(top: 15, left: 10, right: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: widget.color,
        ),
        child: Material(
          elevation: 5,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //heading
                Text(
                  widget.heading,
                  style: kTaskTextStyle.copyWith(fontSize: 18),
                ),

                //content
                Text(
                  widget.content,
                  style: kHintTextStyle.copyWith(
                    color: const Color.fromARGB(149, 0, 0, 0),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
