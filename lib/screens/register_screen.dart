import 'package:flutter/material.dart';

import '../colors/colors.dart';
import '../storage/user_storage.dart';
import '../utils/validation.dart';

class RegisterScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final UserStorage _userStorage = LocalUserStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register', style: TextStyle(color: Colors.white)),
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
                // Title
                Text(
                  'Register',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryRed,
                  ),
                ),
                SizedBox(height: 24),
                // Email Field
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
                // Name Field
                _buildTextField(
                  controller: _nameController,
                  hint: 'Name',
                  icon: Icons.person,
                  validator: (value) {
                    if (value == null || !isValidName(value)) {
                      return 'Name cannot contain numbers';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                // Password Field
                _buildTextField(
                  controller: _passwordController,
                  hint: 'Password',
                  icon: Icons.lock,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                // Confirm Password Field
                _buildTextField(
                  controller: _confirmPasswordController,
                  hint: 'Confirm Password',
                  icon: Icons.lock,
                  obscureText: true,
                  validator: (value) {
                    if (value != _passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 24),
                // Register Button
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await _userStorage.saveUser(
                        _emailController.text,
                        _nameController.text,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Registered successfully'),
                        backgroundColor: Colors.green,
                      ));
                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    'Register',
                    style: TextStyle(color: Colors.white), // White text color
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryRed,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    minimumSize: Size(double.infinity, 50), // Full-width button
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
