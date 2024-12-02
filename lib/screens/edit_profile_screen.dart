import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../colors/colors.dart';

class EditProfileScreen extends StatelessWidget {
  final String name;
  final String email;

  final TextEditingController _nameController;
  final TextEditingController _emailController;

  EditProfileScreen({required this.name, required this.email})
      : _nameController = TextEditingController(text: name),
        _emailController = TextEditingController(text: email);

  Future<bool> _checkInternetConnection() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  void _showNoInternetDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('No Internet Connection'),
        content: Text(
            'Please connect to the internet to save changes to your account.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK', style: TextStyle(color: AppColors.primaryRed)),
          ),
        ],
      ),
    );
  }

  Future<void> _saveChanges(BuildContext context) async {
    final hasInternet = await _checkInternetConnection();

    if (!hasInternet) {
      _showNoInternetDialog(context); // Notify the user about missing internet
      return;
    }

    // Proceed with saving changes
    Navigator.pop(context, {
      'name': _nameController.text,
      'email': _emailController.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        backgroundColor: AppColors.primaryRed,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                hintText: 'Name',
                prefixIcon: Icon(Icons.person, color: AppColors.primaryRed),
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                hintText: 'Email',
                prefixIcon: Icon(Icons.email, color: AppColors.primaryRed),
              ),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => _saveChanges(context),
              child: Text('Save', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryRed,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
