import 'package:flutter/material.dart';
import 'package:picstate/config/constants.dart';

class LoginTextInput extends StatefulWidget {
  const LoginTextInput({
    super.key,
    this.width = 400,
    this.hintText = "",
    this.controller,
    this.obscureText = false,
    this.multiline = false,
    this.onSubmitted,
    this.height,
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
  final double? height;

  @override
  State<LoginTextInput> createState() => LoginTextInputState();
}

class LoginTextInputState extends State<LoginTextInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      padding: const EdgeInsets.only(left: 5, top: 5),
      //border decoration
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromARGB(255, 255, 255, 255)),
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
              color: const Color.fromARGB(255, 255, 255, 255),
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
