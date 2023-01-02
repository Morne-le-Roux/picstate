import 'package:picstate/supabase_settings.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupaBaseDoStuff {
  final client = SupabaseClient(supabaseUrl, supabaseKey);

  addData(String taskValue, bool statusValue) {
    client.from("tasktable").insert({"task": taskValue, "status": statusValue});
  }

  readData() async {
    final dataList = await client
        .from("tasktable")
        .select()
        .order("task", ascending: true) as List;
    return dataList;
  }

  updateData(int id, bool statusValue) async {
    client.from("tasktable").update({"status": statusValue}).eq("id", id);
  }

  deleteData(int id) {
    client.from("tasktable").delete().eq("id", id);
  }

  userLogin(String email, String password) async {
    await client.auth.signInWithPassword(password: password, email: email);
  }

  userRegister(
    String email,
    String password,
    String username,
  ) async {
    await client.auth
        .signUp(password: password, email: email, data: {"Username": username});
  }
}
