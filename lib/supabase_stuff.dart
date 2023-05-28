import 'package:supabase_flutter/supabase_flutter.dart';

class SupaBaseStuff {
  final _supabase = Supabase.instance.client;

  addData(String newTaskName, String dueDate, String createdBy) async {
    await _supabase.from("tasktable").insert({
      "task_name": newTaskName,
      "due_date": dueDate,
      "created_by": createdBy
    });
  }

  Stream listenToTasks() {
    return _supabase.from("tasktable").stream(primaryKey: ["id"]);
  }

  updateData(int id, String statusValue) async {
    await _supabase
        .from("tasktable")
        .update({"state": statusValue}).eq("id", id);
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

  getUserName() {
    var user = _supabase.auth.currentSession!.user.userMetadata;
    return user!["Username"];
  }
}
