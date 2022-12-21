import 'package:flutter/material.dart';
import 'package:picstate/screens/home_screen.dart';
import "package:firebase_core/firebase_core.dart";
import "firebase_options.dart";

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const PicState());
}

class PicState extends StatelessWidget {
  const PicState({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
