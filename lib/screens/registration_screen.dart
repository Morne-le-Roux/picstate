import 'package:flutter/material.dart';
import 'package:picstate/constants.dart';
import 'package:picstate/custom_widgets/rounded_button.dart';
import 'package:picstate/custom_widgets/text_input.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String password = "";
  String password2 = "";
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
                child: Hero(
                  tag: "name",
                  child: Material(
                    color: Colors.transparent,
                    child: Text(
                      "PICstate",
                      style: kHeadingTextStyle,
                    ),
                  ),
                ),
              ),

              //Spacing

              const SizedBox(
                height: 50,
              ),

              //Email field
              Hero(
                tag: "email",
                child: BasicTextField(
                    hintText: "Email Address",
                    obscureText: false,
                    onChanged: (value) {
                      email = value;
                    }),
              ),

              //Spacing between fields
              const SizedBox(
                height: 20,
              ),

              //Password Field
              Hero(
                tag: "password",
                child: BasicTextField(
                    hintText: "Password",
                    obscureText: true,
                    onChanged: (value) {
                      password = value;
                    }),
              ),

              //Spacing between fields
              const SizedBox(
                height: 10,
              ),

              //confirm password

              BasicTextField(
                  hintText: "Confirm Password",
                  obscureText: true,
                  onChanged: (value) {
                    password2 = value;
                  }),

              //spacing

              const SizedBox(
                height: 20,
              ),

              Hero(
                tag: "login",
                child: Material(
                  color: Colors.transparent,
                  child: RoundedButton(
                    text: "Register",
                    onTap: () => Navigator.pop(context),
                  ),
                ),
              ),

              const SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
