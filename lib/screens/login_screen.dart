import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../colors/colors.dart';
import '../storage/user_storage.dart';
import '../main.dart';

class LoginScreen extends StatelessWidget {
  final VoidCallback? onLoginSuccess;
  final UserStorage _userStorage = LocalUserStorage();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginScreen({this.onLoginSuccess});

  Future<bool> _checkInternetConnection() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  void _showDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK', style: TextStyle(color: AppColors.primaryRed)),
          ),
        ],
      ),
    );
  }

  Future<void> _handleLogin(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final hasInternet = await _checkInternetConnection();

      if (!hasInternet) {
        _showDialog(
          context,
          'No Internet',
          'Please check your internet connection and try again.',
        );
        return;
      }

      final user = await _userStorage.getUser();
      if (user != null &&
          user['email'] == _emailController.text &&
          user['password'] == _passwordController.text) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Login successful'),
          backgroundColor: Colors.green,
        ));
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => MainScreen()),
              (route) => false,
        );
      } else {
        _showDialog(
          context,
          'Login Failed',
          'Invalid email or password.',
        );
      }
    }
  }

  Future<void> _autoLogin(BuildContext context) async {
    final user = await _userStorage.getUser();
    if (user != null) {
      final hasInternet = await _checkInternetConnection();

      if (!hasInternet) {
        _showDialog(
          context,
          'Limited Access',
          'You are logged in offline. Some features may not work.',
        );
      }

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Call auto-login logic on build
    WidgetsBinding.instance.addPostFrameCallback((_) => _autoLogin(context));

    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: AppColors.primaryRed,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryRed,
                  ),
                ),
                SizedBox(height: 24),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: 'E-mail',
                    prefixIcon: Icon(Icons.email, color: AppColors.primaryRed),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an email';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    prefixIcon: Icon(Icons.lock, color: AppColors.primaryRed),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () => _handleLogin(context),
                  child: Text('Login'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryRed,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
