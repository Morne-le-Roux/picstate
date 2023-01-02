import 'package:supabase_flutter/supabase_flutter.dart';

class SupaBaseDoStuff {
  final _supabase = Supabase.instance.client;

  addData(String taskValue, bool statusValue) {
    _supabase
        .from("tasktable")
        .insert({"task": taskValue, "status": statusValue});
  }

  Stream listenToTasks() {
    return _supabase.from("tasktable").stream(primaryKey: ["id"]);
  }

  updateData(int id, bool statusValue) async {
    _supabase.from("tasktable").update({"status": statusValue}).eq("id", id);
  }

  deleteData(int id) {
    _supabase.from("tasktable").delete().eq("id", id);
  }

  userLogin(String password, String email) async {
    await _supabase.auth.signInWithPassword(password: password, email: email);
  }

  userRegister(
    String email,
    String password,
    String username,
  ) async {
    await _supabase.auth
        .signUp(password: password, email: email, data: {"Username": username});
  }
}
