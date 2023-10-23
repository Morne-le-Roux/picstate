// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:picstate/config/constants.dart';
import 'package:picstate/core/widgets/rounded_button.dart';
import 'package:picstate/features/auth/domain/usecases/login.dart';
import 'package:picstate/features/auth/domain/usecases/shared_preferences.dart';
import 'package:picstate/features/auth/presentation/widgets/login_text_input.dart';
import 'package:picstate/features/main_screen/presentation/pages/home_screen.dart';
import 'package:picstate/features/auth/presentation/pages/registration_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final Login _login = Login();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _supabase = Supabase.instance.client;
  final bool _rememberMe = false;
  bool _loading = true;

  ///
  ///

//!LOGIN CODE
  void login() async {
    setState(() {
      _loading = true;
    });
    try {
      final AuthResponse response = await _login.userLogin(
          _passwordController.text, _emailController.text);

      if (response.user != null) {
        setState(() {
          _loading = false;
        });
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const HomeScreen()));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

//! Stuff to run when the screen is opened.

  void _initData() async {
    Data data = Data();
    await data.initPreferences();

    if (await data.getRememberMe() == true) {
      Map<String, String> returnedData = await data.getStoredData();
      _emailController.text = returnedData["storedEmail"].toString();
      _passwordController.text = returnedData["storedPassword"].toString();
    }
    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _initData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: ModalProgressHUD(
        progressIndicator: const CircularProgressIndicator(
          color: Colors.amber,
          backgroundColor: Colors.transparent,
        ),
        inAsyncCall: _loading,
        child: SafeArea(
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
                  child: LoginTextInput(
                      controller: _emailController,
                      icon: Icons.email_rounded,
                      fontColor: Colors.yellow.shade800,
                      hintText: "Email Address",
                      obscureText: false,
                      onChanged: (value) {
                        _emailController.text = value;
                        _emailController.selection = TextSelection(
                            baseOffset: value.length,
                            extentOffset: value.length);
                      }),
                ),

                //Spacing between fields
                const SizedBox(
                  height: 10,
                ),

                //Password Field
                Hero(
                  tag: "password",
                  child: LoginTextInput(
                    controller: _passwordController,
                    icon: Icons.password,
                    fontColor: Colors.yellow.shade800,
                    hintText: "Password",
                    obscureText: true,
                    onChanged: (value) {
                      _passwordController.text = value;
                      _passwordController.selection = TextSelection(
                          baseOffset: value.length, extentOffset: value.length);
                    },
                    onSubmitted: (value) {
                      Data().setRememberMe(_rememberMe);
                      if (_rememberMe) {
                        Data().setStoredData(
                            email: _emailController.text,
                            password: _passwordController.text);
                      }
                      login();
                    },
                  ),
                ),

                //spacing

                const SizedBox(height: 20),

                //REMEMBER ME?
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Checkbox(
                      activeColor: Colors.amber,
                      value: _rememberMe,
                      onChanged: (bool? value) {
                        setState(() {
                          _rememberMe = value ?? false;
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
                      onTap: () {
                        Data().setRememberMe(_rememberMe);
                        if (_rememberMe) {
                          Data().setStoredData(
                              email: _emailController.text,
                              password: _passwordController.text);
                        }
                        login();
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
      ),
    );
  }
}
