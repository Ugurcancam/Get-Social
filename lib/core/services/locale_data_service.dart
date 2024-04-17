import 'package:shared_preferences/shared_preferences.dart';

class LocalDataService {
  Future<SharedPreferences> getPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs;
  }

  // Saving user email to Local Storage
  Future<void> saveUserEmail(String email) async {
    final prefs = await getPrefs();
    await prefs.setString('userEmail', email);
  }

  // Saving user namesurname to Local Storage
  Future<void> saveUserNameSurname(String namesurname) async {
    final prefs = await getPrefs();
    await prefs.setString('userNameSurname', namesurname);
  }

  // Saving user uid to Local Storage
  Future<void> saveUserId(String uid) async {
    final prefs = await getPrefs();
    await prefs.setString('userId', uid);
  }

  // Getting user email from Local Storage
  Future<String?> getUserEmail() async {
    final prefs = await getPrefs();
    return prefs.getString('userEmail');
  }

  // Getting string data from Local Storage
  Future<String?> getStringData(String value) async {
    final prefs = await getPrefs();
    return prefs.getString(value);
  }
}
