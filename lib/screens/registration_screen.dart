import 'package:flutter/material.dart';
import 'package:picstate/constants.dart';
import 'package:picstate/custom_widgets/rounded_button.dart';
import 'package:picstate/custom_widgets/text_input.dart';
import 'package:picstate/screens/home_screen.dart';
import 'package:picstate/supabase_stuff.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String _password = "";
  String _password2 = "";
  String _email = "";
  String _username = "";

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
                      _email = value;
                    }),
              ),

//Spacing between fields
              const SizedBox(
                height: 10,
              ),

//USERNAME
              BasicTextField(
                  hintText: "Username",
                  obscureText: false,
                  onChanged: (value) {
                    _username = value;
                  }),

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
                      _password = value;
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
                    _password2 = value;
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
                    onTap: () {
                      if (_password == _password2) {
                        try {
                          SupaBaseDoStuff()
                              .userRegister(_email, _password, _username);
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(e.toString())));
                        }
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomeScreen(),
                            ));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Passwords do not match!")));
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
