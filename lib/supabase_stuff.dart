import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SupaBaseStuff {
  final _supabase = Supabase.instance.client;

  needsUpdate() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    //checks current app version
    double version = double.parse(packageInfo.version);

    //checks newest app version number
    final latestVersionNumberString =
        await _supabase.from("versioncheck").select("versionNumber");
    final latestVersionNumber =
        double.parse(latestVersionNumberString[0]["versionNumber"]);

    print(version < latestVersionNumber ? "true" : "false");
  }

  addData(String newTaskName, String dueDate, String createdBy,
      String? description) async {
    await _supabase.from("tasktable").insert({
      "task_name": newTaskName,
      "due_date": dueDate,
      "description": description,
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
