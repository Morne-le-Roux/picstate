// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:picstate/constants.dart';
import 'package:picstate/custom_widgets/rounded_button.dart';
import 'package:picstate/custom_widgets/text_input.dart';
import 'package:picstate/screens/home_screen.dart';
import 'package:picstate/screens/registration_screen.dart';
import 'package:picstate/supabase_stuff.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final SupaBaseStuff _supaBaseStuff = SupaBaseStuff();
  bool? _rememberMe;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  ///
  ///

  final supabase = Supabase.instance.client;

  Future<void> loadRememberMe() async {
    final SharedPreferences prefs = await _prefs;
    final bool rememberMe = prefs.getBool('rememberMe') == null ? false : true;
    _rememberMe = rememberMe;
    _emailController.text =
        rememberMe == true ? prefs.getString('email').toString() : "";
    _passwordController.text =
        rememberMe == true ? prefs.getString('password').toString() : "";
  }

  @override
  void initState() {
    super.initState();
    loadRememberMe();
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
                    controller: _emailController,
                    icon: Icons.email_rounded,
                    fontColor: Colors.yellow.shade800,
                    hintText: "Email Address",
                    obscureText: false,
                    onChanged: (value) {
                      _emailController.text = value;
                      _emailController.selection = TextSelection(
                          baseOffset: value.length, extentOffset: value.length);
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
                    controller: _passwordController,
                    icon: Icons.password,
                    fontColor: Colors.yellow.shade800,
                    hintText: "Password",
                    obscureText: true,
                    onChanged: (value) {
                      _passwordController.text = value;
                      _passwordController.selection = TextSelection(
                          baseOffset: value.length, extentOffset: value.length);
                    }),
              ),

//spacing

              const SizedBox(height: 20),

//REMEMBER ME?
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                    activeColor: Colors.amber,
                    value: _rememberMe ?? false,
                    onChanged: (bool? value) {
                      setState(() {
                        _rememberMe = value;
                      });
                    },
                  ),
                  Text(
                    "Remember me?",
                    style: kHintTextStyle,
                  ),
                ],
              ),

              const SizedBox(height: 20),

              Hero(
                tag: "login",
                child: Material(
                  color: Colors.transparent,
                  child: RoundedButton(
                    text: "Login",
                    onTap: () async {
                      SharedPreferences prefs = await _prefs;
                      prefs.setBool(
                          'rememberMe', _rememberMe == true ? true : false);
                      try {
                        final AuthResponse response =
                            await _supaBaseStuff.userLogin(
                                _passwordController.text,
                                _emailController.text);

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
