import 'package:flutter/material.dart';
import '../widgets/background_widget.dart';
import '../widgets/button_style.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background widget
          BackgroundWidget(),
          // Centered content
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo image
                  Image.asset("assets/logo.png", height: 200),
                  SizedBox(height: 16),  // Small spacing between logo and text
                  // Text under the logo
                  Text(
                    "AETHERVEIL FANTASY",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "The Tower of the Gods",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 50),
                  // Login button
                  ElevatedButton(
                    style: buttonStyle(),
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    child: Text("Login", style: TextStyle(color: Colors.white)),
                  ),
                  SizedBox(height: 16), // Vertical spacing between buttons
                  // Register button
                  ElevatedButton(
                    style: buttonStyle(),
                    onPressed: () {
                      Navigator.pushNamed(context, '/register');
                    },
                    child: Text("Register", style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
