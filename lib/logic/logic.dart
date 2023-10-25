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

  Stream orderStream() {
    return _supabase.from("ordertable").stream(primaryKey: ["id"]);
  }

  updateTaskData(int id, String statusValue) async {
    await _supabase
        .from("tasktable")
        .update({"state": statusValue}).eq("id", id);
  }

  updateOrderData(int id, String statusValue) async {
    await _supabase
        .from("ordertable")
        .update({"state": statusValue}).eq("id", id);
  }

  deleteTask(int id) async {
    await _supabase.from("tasktable").delete().eq("id", id);
  }

  deleteOrder(int id) async {
    await _supabase.from("ordertable").delete().eq("id", id);
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
