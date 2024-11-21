import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/login_page.dart';
import 'pages/register_page.dart';
import 'pages/profile_page.dart';
import 'services/storage_service.dart';  // Make sure this import exists

class MyApp extends StatelessWidget {
  final LocalStorageService storageService = LocalStorageService();  // Initialize LocalStorageService

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aetherveil Fantasy',
      theme: ThemeData(primaryColor: Color(0xFF9c5b49)),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/login': (context) => LoginPage(storageService: storageService),  // Pass storageService here
        '/register': (context) => RegisterPage(storageService: storageService),  // Pass storageService here
        '/profile': (context) => ProfilePage(storageService: storageService),  // Pass storageService here
      },
    );
  }
}
