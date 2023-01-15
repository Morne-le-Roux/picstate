import 'package:flutter/material.dart';
import 'package:picstate/constants.dart';
import 'package:picstate/custom_widgets/rounded_button.dart';
import 'package:picstate/custom_widgets/text_input.dart';
import 'package:picstate/screens/home_screen.dart';
import 'package:picstate/screens/login_screen.dart';
import 'package:picstate/supabase_settings.dart';
import 'package:picstate/supabase_stuff.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final SupaBaseStuff _supaBaseStuff = SupaBaseStuff();
  String _password = "";
  String _password2 = "";
  String _email = "";
  String _username = "";
  String _securityKey = "";

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

//USERNAME
              BasicTextField(
                  icon: Icons.person,
                  fontColor: Colors.yellow,
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
                    icon: Icons.password,
                    fontColor: Colors.yellow,
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
                  icon: Icons.password,
                  fontColor: Colors.yellow,
                  hintText: "Confirm Password",
                  obscureText: true,
                  onChanged: (value) {
                    _password2 = value;
                  }),

//Spacing between fields
              const SizedBox(
                height: 20,
              ),

//Workspace Pin Code.

//This is set in supabase_settings.dart
//This needs to correspond with that setting so that not just anybody can
//register and add/remove tasks that your team uses.

              BasicTextField(
                  icon: Icons.people,
                  fontColor: Colors.yellow,
                  hintText: "Security Code.",
                  obscureText: true,
                  onChanged: (value) {
                    _securityKey = value;
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
                      //checks security key
                      if (_securityKey == securityKey) {
                        //checks password
                        if (_password == _password2) {
                          //if both successful
                          try {
                            _supaBaseStuff.userRegister(
                                _email, _password, _username);
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(e.toString())));
                          }
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomeScreen(),
                              ));
                          //if passwords don't match
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Passwords do not match!")));
                        }
                        //if security key does not match
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text(
                                "Security Key does not match! This app is made for employees only.")));
                      }

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()));
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
