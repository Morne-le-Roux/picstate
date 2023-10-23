import 'package:supabase_flutter/supabase_flutter.dart';

class Register {
  final _supabase = Supabase.instance.client;

  userRegister(
    String email,
    String password,
    String username,
  ) async {
    await _supabase.auth
        .signUp(password: password, email: email, data: {"Username": username});
  }
}
