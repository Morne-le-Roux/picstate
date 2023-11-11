import 'package:shared_preferences/shared_preferences.dart';

class StoredData {
  late SharedPreferences _preferences;
  StoredData() {
    initPreferences();
  }

  Future<void> initPreferences() async {
    _preferences = await SharedPreferences.getInstance();
  }

  String getStoredData({required key}) {
    String? dataReturned = _preferences.getString(key) ?? "";

    return dataReturned;
  }

  void setStoredData({required key, required value}) async {
    await _preferences.setString(key, value);
  }
}
