import 'package:flutter/material.dart';
import 'package:picstate/screens/login_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'supabase_settings.dart';

//! create a supabase_settings.dart in your lib folder, add your details there with the below variables, and import the file.
// String supabaseUrl = 'yourSupaBaseUrl';
// String supabaseKey = 'yourSupabaseKey';

//

Future<void> main() async {
  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseKey);
  runApp(const PicState());
}

class PicState extends StatelessWidget {
  const PicState({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
