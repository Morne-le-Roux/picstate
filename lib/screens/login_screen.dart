import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:picstate/constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //Main Heading
            Center(
              child: Text(
                "PICstate",
                style: GoogleFonts.anton(color: Colors.black, fontSize: 80),
              ),
            )
          ],
        ),
      ),
    );
  }
}
