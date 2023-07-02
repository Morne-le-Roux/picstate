import 'package:flutter/material.dart';
import 'package:picstate/screens/login_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'supabase_settings.dart';

//! create a supabase_settings.dart in your lib folder, add your details there with the below variables,
//! and import the file if its not already imported.
//! security key can be anything you choose, this will be the key users need to register and use your app.
//! your table name in supabase needs to be 'tasktable', or edit the code in supabase_stuff.dart accordingly.

// const String supabaseUrl = 'yourSupaBaseUrl';
// const String supabaseKey = 'yourSupabaseKey';
// const String securityKey = 'yourSecurityKey';

//

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseKey);
  runApp(const PicState());
}

class PicState extends StatefulWidget {
  const PicState({super.key});

  @override
  State<PicState> createState() => _PicStateState();
}

class _PicStateState extends State<PicState> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

//If app is resumed, push login screen
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const LoginScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
