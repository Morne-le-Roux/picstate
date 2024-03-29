import 'package:flutter/material.dart';
import 'package:picstate/config/constants.dart';

class MenuButton extends StatefulWidget {
  const MenuButton({
    super.key,
    required this.heading,
    required this.content,
    required this.selected,
  });

  final String heading;
  final String content;
  final bool selected;

  @override
  State<MenuButton> createState() => _MenuButtonState();
}

class _MenuButtonState extends State<MenuButton> {
  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.fitWidth,
      child: AnimatedContainer(
        margin: const EdgeInsets.only(top: 20, left: 8, right: 8),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: widget.selected
              ? const Color.fromARGB(255, 255, 232, 151)
              : Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        width: 180,
        height: 100,
        duration: const Duration(milliseconds: 500),
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
    );
  }
}
