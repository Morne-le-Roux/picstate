import 'package:flutter/material.dart';
import 'package:picstate/constants.dart';

class BasicTextField extends StatefulWidget {
  const BasicTextField({
    super.key,
    required this.hintText,
    this.controller,
    required this.onChanged,
    required this.obscureText,
    required this.fontColor,
  });

  final String hintText;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final bool obscureText;
  final Color fontColor;

  @override
  State<BasicTextField> createState() => _BasicTextFieldState();
}

class _BasicTextFieldState extends State<BasicTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      //border decoration
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: TextField(
        style: TextStyle(color: widget.fontColor),
        obscureText: widget.obscureText,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: widget.hintText,
            hintStyle: kHintTextStyle),
        onChanged: widget.onChanged,
      ),
    );
  }
}
