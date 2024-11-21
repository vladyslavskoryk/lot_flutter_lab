import 'package:flutter/material.dart';
import '../modules/user.dart';
import '../services/storage_service.dart';
import '../widgets/button_style.dart';
import '../widgets/custom_text_field.dart';

class LoginPage extends StatelessWidget {
  final StorageService storageService;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginPage({required this.storageService});

  void _login(BuildContext context) async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    User? user = await storageService.getUser(email);

    if (user != null && user.password == password) {
      await storageService.setLoggedIn(true);  // Установка статусу залогованості в true
      Navigator.pushNamed(context, '/profile');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed. Incorrect email or password.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/logo.png", height: 200),
                Text(
                  "AETHERVEIL FANTASY",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 50),
                CustomTextField(
                  controller: emailController,
                  hintText: "E-mail",
                  textColor: Colors.black,
                ),
                SizedBox(height: 16),
                CustomTextField(
                  controller: passwordController,
                  hintText: "Password",
                  isPassword: true,
                  textColor: Colors.black,
                ),
                SizedBox(height: 24),
                ElevatedButton(
                  style: buttonStyle(),
                  onPressed: () => _login(context),
                  child: Text(
                    "Login",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Back", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
