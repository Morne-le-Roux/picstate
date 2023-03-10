// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:picstate/constants.dart';
import 'package:picstate/custom_widgets/rounded_button.dart';
import 'package:picstate/custom_widgets/text_input.dart';
import 'package:picstate/screens/home_screen.dart';
import 'package:picstate/screens/registration_screen.dart';
import 'package:picstate/supabase_stuff.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final SupaBaseStuff _supaBaseStuff = SupaBaseStuff();
  String _password = "";
  String _email = "";

  ///
  ///

  final supabase = Supabase.instance.client;

  @override
  void initState() {
    super.initState();
  }

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
                    icon: Icons.email_rounded,
                    fontColor: Colors.yellow,
                    hintText: "Email Address",
                    obscureText: false,
                    onChanged: (value) {
                      _email = value;
                    }),
              ),

              //Spacing between fields
              const SizedBox(
                height: 10,
              ),

              //Password Field
              Hero(
                tag: "password",
                child: BasicTextField(
                    icon: Icons.password,
                    fontColor: Colors.yellow,
                    hintText: "Password",
                    obscureText: true,
                    onChanged: (value) {
                      _password = value;
                    }),
              ),

              //spacing

              const SizedBox(
                height: 20,
              ),

              Hero(
                tag: "login",
                child: Material(
                  color: Colors.transparent,
                  child: RoundedButton(
                    text: "Login",
                    onTap: () async {
                      try {
                        final AuthResponse response =
                            await _supaBaseStuff.userLogin(_password, _email);

                        if (response.user != null) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomeScreen()));
                        }
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(e.toString())));
                      }
                    },
                  ),
                ),
              ),

              const SizedBox(
                height: 40,
              ),

              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegistrationScreen(),
                      ));
                },
                child: Text(
                  "Not a Member? Subscribe instead.",
                  style: kButtonTextStyle.copyWith(color: Colors.amber),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
