import 'package:supabase_flutter/supabase_flutter.dart';

class Logic {
  final _supabase = Supabase.instance.client;

  addTask(String newTaskName, String dueDate, String createdBy,
      String? description) async {
    await _supabase.from("tasktable").insert({
      "task_name": newTaskName,
      "due_date": dueDate,
      "description": description,
      "created_by": createdBy
    });
  }

  addOrder(String newOrderName, String createdBy, String? description) async {
    await _supabase.from("ordertable").insert({
      "order_name": newOrderName,
      "description": description,
      "created_by": createdBy,
    });
  }

  Stream taskStream() {
    return _supabase.from("tasktable").stream(primaryKey: ["id"]);
  }

  updateTaskState(int id, String statusValue) async {
    await _supabase
        .from("tasktable")
        .update({"state": statusValue}).eq("id", id);
  }

  updateTaskName(int id, String data) async {
    await _supabase.from("tasktable").update({"task_name": data}).eq("id", id);
  }

  updateTaskDescription(int id, String data) async {
    await _supabase
        .from("tasktable")
        .update({"description": data}).eq("id", id);
  }

  deleteTask(int id) async {
    await _supabase.from("tasktable").delete().eq("id", id);
  }

  userLogin(String password, String email) async {
    return await _supabase.auth
        .signInWithPassword(password: password, email: email);
  }

  getUserName() {
    var user = _supabase.auth.currentSession!.user.userMetadata;
    return user!["Username"];
  }
}
