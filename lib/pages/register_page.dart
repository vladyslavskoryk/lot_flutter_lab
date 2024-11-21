import 'package:flutter/material.dart';
import '../modules/user.dart';
import '../services/storage_service.dart';
import '../utils/validators.dart';
import '../widgets/button_style.dart';
import '../widgets/custom_text_field.dart';

class RegisterPage extends StatelessWidget {
  final StorageService storageService;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  RegisterPage({required this.storageService});

  void _register(BuildContext context) async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    if (!isValidEmail(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid email format.')),
      );
      return;
    }

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Passwords do not match.')),
      );
      return;
    }

    User newUser = User(email: email, password: password);
    await storageService.saveUser(newUser);

    Navigator.pushNamed(context, '/profile');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background.jpg"), // Вкажіть шлях до фону
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            // Горизонтальний відступ
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
                SizedBox(height: 16),
                CustomTextField(
                  controller: confirmPasswordController,
                  hintText: "Confirm Password",
                  isPassword: true,
                  textColor: Colors.black,
                ),
                SizedBox(height: 24),
                ElevatedButton(
                  style: buttonStyle(),
                  onPressed: () => _register(context),
                  child: Text("Register", style: TextStyle(color: Colors.white)),
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
