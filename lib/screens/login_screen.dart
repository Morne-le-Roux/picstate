// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:picstate/logic/constants.dart';
import 'package:picstate/custom_widgets/rounded_button.dart';
import 'package:picstate/custom_widgets/text_input.dart';
import 'package:picstate/screens/home_screen.dart';
import 'package:picstate/screens/registration_screen.dart';
import 'package:picstate/logic/logic.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final Logic _supaBaseStuff = Logic();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final supabase = Supabase.instance.client;
  bool _rememberMe = false;
  bool _loading = false;

  ///
  ///

//LOGIN CODE
  void login() async {
    setState(() {
      _loading = true;
    });
    try {
      final AuthResponse response = await _supaBaseStuff.userLogin(
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

  void getStoredData() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    String storedEmail = preferences.getString('email') == null
        ? ""
        : preferences.getString('email').toString();
    String storedPassword = preferences.getString('password') == null
        ? ""
        : preferences.getString('password').toString();

    setState(() {
      _emailController.text = storedEmail;
      _passwordController.text = storedPassword;
      _loading = false;
    });
  }

  void setStoredData() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('email', _emailController.text);
    await preferences.setString('password', _passwordController.text);
  }

  void setRememberMe() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('rememberMe', _rememberMe);
  }

  void getRememberMe() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    bool value = preferences.getBool('rememberMe') ?? false;

    _rememberMe = value;
    bool loadData = value;

    if (loadData) {
      getStoredData();
    }
    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _loading = true;
    });
    getRememberMe();
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
                  child: BasicTextField(
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
                    },
                    onSubmitted: (value) {
                      setRememberMe();
                      if (_rememberMe) {
                        setStoredData();
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
                        setRememberMe();
                        if (_rememberMe) {
                          setStoredData();
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
