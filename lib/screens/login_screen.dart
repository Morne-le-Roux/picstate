import 'package:flutter/material.dart';
import 'package:picstate/constants.dart';
import 'package:picstate/custom_widgets/rounded_button.dart';
import 'package:picstate/custom_widgets/text_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String password = "";
  String email = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Main Heading
              Center(
                child: Text(
                  "PICstate",
                  style: kHeadingTextStyle,
                ),
              ),

              //Spacing

              const SizedBox(
                height: 50,
              ),

              //Email field
              BasicTextField(
                  hintText: "Email Address",
                  obscureText: false,
                  onChanged: (value) {
                    email = value;
                  }),

              //Spacing between fields
              const SizedBox(
                height: 10,
              ),

              //Password Field
              BasicTextField(
                  hintText: "Password",
                  obscureText: true,
                  onChanged: (value) {
                    password = value;
                  }),

              //spacing

              const SizedBox(
                height: 20,
              ),

              const RoundedButton(
                text: "Login",
              )
            ],
          ),
        ),
      ),
    );
  }
}
