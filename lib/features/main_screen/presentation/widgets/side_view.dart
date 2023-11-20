import 'package:flutter/material.dart';
import 'package:picstate/config/constants.dart';

class SideView extends StatelessWidget {
  const SideView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Click on a task to view detials.",
        style: kHintTextStyle.copyWith(
            fontSize: 30, color: const Color.fromARGB(55, 158, 158, 158)),
      ),
    );
  }
}
