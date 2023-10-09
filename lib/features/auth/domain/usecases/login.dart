import 'package:supabase_flutter/supabase_flutter.dart';

class Login {
  final _supabase = Supabase.instance.client;

  userLogin(String password, String email) async {
    return await _supabase.auth
        .signInWithPassword(password: password, email: email);
  }
}
