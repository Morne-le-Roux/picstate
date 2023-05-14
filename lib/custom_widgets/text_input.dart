import 'package:flutter/material.dart';
import 'package:picstate/constants.dart';

class BasicTextField extends StatefulWidget {
  const BasicTextField(
      {super.key,
      required this.hintText,
      this.controller,
      required this.onChanged,
      required this.obscureText,
      required this.fontColor,
      required this.icon});

  final String hintText;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final bool obscureText;
  final Color fontColor;
  final IconData icon;

  @override
  State<BasicTextField> createState() => _BasicTextFieldState();
}

class _BasicTextFieldState extends State<BasicTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      padding: const EdgeInsets.only(left: 5, top: 5),
      //border decoration
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: TextField(
        style: kTaskTextStyle.copyWith(
            color: widget.fontColor, fontStyle: FontStyle.italic),
        obscureText: widget.obscureText,
        decoration: InputDecoration(
            prefixIcon: Icon(
              widget.icon,
              color: Colors.grey,
            ),
            border: InputBorder.none,
            hintText: widget.hintText,
            hintStyle: kHintTextStyle),
        onChanged: widget.onChanged,
      ),
    );
  }
}
