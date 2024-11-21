import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../modules/user.dart';

abstract class StorageService {
  Future<void> saveUser(User user);

  Future<User?> getUser(String email);

  Future<void> clearUserData();

  Future<void> setLoggedIn(
      bool value); // Метод для збереження статусу логування
  Future<bool> isLoggedIn(); // Метод для перевірки статусу логування
}

class LocalStorageService implements StorageService {
  @override
  Future<void> saveUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(user.email,
        jsonEncode({'email': user.email, 'password': user.password}));
    prefs.setBool('isLoggedIn', true); // Збереження статусу логування
  }

  @override
  Future<User?> getUser(String email) async {
    final prefs = await SharedPreferences.getInstance();
    String? userData = prefs.getString(email);
    if (userData != null) {
      Map<String, dynamic> data = jsonDecode(userData);
      return User(email: data['email'], password: data['password']);
    }
    return null;
  }

  @override
  Future<void> clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  @override
  Future<void> setLoggedIn(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', value);
  }

  @override
  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }
}
