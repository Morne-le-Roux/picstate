import 'package:supabase_flutter/supabase_flutter.dart';

class SupaBaseStuff {
  final _supabase = Supabase.instance.client;

  addData(String newTaskName, String dueDate) async {
    await _supabase
        .from("tasktable")
        .insert({"task_name": newTaskName, "due_date": dueDate});
  }

  Stream listenToTasks() {
    return _supabase.from("tasktable").stream(primaryKey: ["id"]);
  }

  updateData(int id, bool statusValue) async {
    _supabase.from("tasktable").update({"status": statusValue}).eq("id", id);
  }

  deleteData(int id) async {
    await _supabase.from("tasktable").delete().eq("id", id);
  }

  userLogin(String password, String email) async {
    return await _supabase.auth
        .signInWithPassword(password: password, email: email);
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
