import 'package:package_info_plus/package_info_plus.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UpdateChecker {
  final SupabaseClient _supabase = Supabase.instance.client;

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
}
