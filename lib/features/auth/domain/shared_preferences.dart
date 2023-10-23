import 'package:shared_preferences/shared_preferences.dart';

class Data {
  late SharedPreferences _preferences;
  Data() {
    initPreferences();
  }

  Future<void> initPreferences() async {
    _preferences = await SharedPreferences.getInstance();
  }

  Future<Map<String, String>> getStoredData() async {
    String storedEmail = _preferences.getString('email') == null
        ? ""
        : _preferences.getString('email').toString();
    String storedPassword = _preferences.getString('password') == null
        ? ""
        : _preferences.getString('password').toString();

    return {"storedEmail": storedEmail, "storedPassword": storedPassword};
  }

  void setStoredData({required email, required password}) async {
    await _preferences.setString('email', email);
    await _preferences.setString('password', password);
  }

  void setRememberMe(bool rememberMe) async {
    await _preferences.setBool('rememberMe', rememberMe);
  }

  Future<bool> getRememberMe() async {
    bool value = _preferences.getBool('rememberMe') ?? false;
    return value;
  }
}
