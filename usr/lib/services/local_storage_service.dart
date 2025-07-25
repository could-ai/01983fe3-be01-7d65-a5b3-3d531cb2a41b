import 'package:shared_preferences/shared_preferences.dart';
import 'package:couldai_user_app/models/password_entry.dart';

class LocalStorageService {
  static const String _passwordsKey = 'passwords';

  Future<List<PasswordEntry>> loadPasswords() async {
    final prefs = await SharedPreferences.getInstance();
    final String? passwordsString = prefs.getString(_passwordsKey);

    if (passwordsString == null) {
      return [];
    }

    try {
      return PasswordEntry.decode(passwordsString);
    } catch (e) {
      print('Error decoding passwords: $e');
      return [];
    }
  }

  Future<void> savePasswords(List<PasswordEntry> passwords) async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedData = PasswordEntry.encode(passwords);
    await prefs.setString(_passwordsKey, encodedData);
  }
}
