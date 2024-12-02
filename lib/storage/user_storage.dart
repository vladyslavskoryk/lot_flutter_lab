import 'package:shared_preferences/shared_preferences.dart';

abstract class UserStorage {
  Future<void> saveUser(String email, String name);
  Future<Map<String, String>?> getUser();
  Future<void> clearUser();
}

class LocalUserStorage implements UserStorage {
  static const String _emailKey = 'email';
  static const String _nameKey = 'name';

  @override
  Future<void> saveUser(String email, String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_emailKey, email);
    await prefs.setString(_nameKey, name);
  }

  @override
  Future<Map<String, String>?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString(_emailKey);
    final name = prefs.getString(_nameKey);

    if (email != null && name != null) {
      return {'email': email, 'name': name};
    }
    return null;
  }

  @override
  Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_emailKey);
    await prefs.remove(_nameKey);
  }
}
