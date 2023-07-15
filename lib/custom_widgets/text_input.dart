import 'package:flutter/material.dart';
import 'package:picstate/constants.dart';

class BasicTextField extends StatefulWidget {
  const BasicTextField({
    super.key,
    this.width = 400,
    this.hintText = "",
    this.controller,
    this.obscureText = false,
    this.multiline = false,
    this.onSubmitted,
    required this.fontColor,
    required this.icon,
    required this.onChanged,
  });

  final String hintText;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final bool obscureText;
  final Color fontColor;
  final IconData icon;
  final double width;
  final bool multiline;
  final void Function(String)? onSubmitted;

  @override
  State<BasicTextField> createState() => _BasicTextFieldState();
}

class _BasicTextFieldState extends State<BasicTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      padding: const EdgeInsets.only(left: 5, top: 5),
      //border decoration
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: TextField(
        controller: widget.controller,
        maxLines: widget.multiline ? null : 1,
        keyboardType: TextInputType.multiline,
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
        onSubmitted: widget.onSubmitted,
      ),
    );
  }
}
