import 'package:flutter/material.dart';
import '../colors/colors.dart';
import '../storage/user_storage.dart';
import '../utils/validation.dart';

class LoginScreen extends StatelessWidget {
  final VoidCallback? onLoginSuccess;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final UserStorage _userStorage = LocalUserStorage();

  LoginScreen({this.onLoginSuccess}); // Add optional parameter

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: AppColors.primaryRed,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
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
                _buildTextField(
                  controller: _emailController,
                  hint: 'E-mail',
                  icon: Icons.email,
                  validator: (value) {
                    if (value == null || !isValidEmail(value)) {
                      return 'Invalid email';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                _buildTextField(
                  controller: _passwordController,
                  hint: 'Password',
                  icon: Icons.lock,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password cannot be empty';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final user = await _userStorage.getUser();
                      if (user != null &&
                          user['email'] == _emailController.text &&
                          user['password'] == _passwordController.text) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Login successful'),
                          backgroundColor: Colors.green,
                        ));
                        if (onLoginSuccess != null) {
                          onLoginSuccess!(); // Call the success callback
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Invalid email or password'),
                          backgroundColor: Colors.red,
                        ));
                      }
                    }
                  },
                  child: Text('Login'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryRed,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    minimumSize: Size(double.infinity, 50),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool obscureText = false,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon, color: AppColors.primaryRed),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
    );
  }
}
