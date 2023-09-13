import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SupaBaseStuff {
  final _supabase = Supabase.instance.client;

  //checks if app needs an update
  needsUpdate() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    //checks current app version
    String versionString = packageInfo.version;

    //checks newest app version number
    final latestVersionNumberData =
        await _supabase.from("versioncheck").select("versionNumber");
    final latestVersionNumberString =
        latestVersionNumberData[0]["versionNumber"];

    //uses getExtendedVersionNumber to parse version numbers to integers for comparison
    final latestVersionNumber =
        getExtendedVersionNumber(latestVersionNumberString);
    final version = getExtendedVersionNumber(versionString);

    //checks if current version number is smaller than latest version number
    final needsUpdate = version < latestVersionNumber;

    return needsUpdate == true ? true : false;
  }

  //parses Strings like 1.2.3 to a large iteger so version numbers can be compared
  int getExtendedVersionNumber(String version) {
    List versionCells = version.split(".");
    versionCells = versionCells.map((e) => int.parse(e)).toList();
    return versionCells[0] * 100000 + versionCells[1] * 1000 + versionCells[2];
  }

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

//Listens to tasks in task table
  Stream taskStream() {
    return _supabase.from("tasktable").stream(primaryKey: ["id"]);
  }

  Stream orderStream() {
    return _supabase.from("ordertable").stream(primaryKey: ["id"]);
  }

  updateData(int id, String statusValue) async {
    await _supabase
        .from("tasktable")
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
