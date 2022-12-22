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
}
