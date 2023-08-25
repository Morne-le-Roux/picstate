import 'package:flutter/material.dart';
import 'package:picstate/constants.dart';

class MenuButton extends StatefulWidget {
  MenuButton({
    super.key,
    required this.heading,
    required this.content,
    required this.selected,
    required this.onTap,
  });

  final String heading;
  final String content;
  bool selected = false;
  final void Function() onTap;

  @override
  State<MenuButton> createState() => _MenuButtonState();
}

class _MenuButtonState extends State<MenuButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.onTap;
          widget.selected = !widget.selected;
        });
      },
      child: AnimatedContainer(
        // height: 50,
        // width: 200,
        duration: const Duration(milliseconds: 100),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          margin: const EdgeInsets.only(top: 15, left: 10, right: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                  color: const Color.fromARGB(255, 0, 0, 0), width: 2),
              gradient: widget.selected ? kSelectedButtonColor : kButtonColor),
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
      ),
    );
  }
}
