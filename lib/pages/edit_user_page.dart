import 'package:flutter/material.dart';
import '../modules/user.dart';
import '../services/storage_service.dart';
import '../widgets/button_style.dart';
import '../widgets/background_widget.dart';  // Ensure BackgroundWidget is imported
import '../widgets/custom_text_field.dart';  // Import the CustomTextField widget

// Regular expression for validating email format
final RegExp emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

class EditUserPage extends StatefulWidget {
  final StorageService storageService;

  EditUserPage({required this.storageService});

  @override
  _EditUserPageState createState() => _EditUserPageState();
}

class _EditUserPageState extends State<EditUserPage> {
  late TextEditingController newEmailController;
  late TextEditingController newPasswordController;
  late TextEditingController confirmPasswordController;

  @override
  void initState() {
    super.initState();
    newEmailController = TextEditingController();
    newPasswordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  // Save changes logic
  Future<void> _saveChanges(BuildContext context) async {
    String newEmail = newEmailController.text.trim();
    String newPassword = newPasswordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    // Validate the email format
    if (!emailRegex.hasMatch(newEmail)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a valid email address.')),
      );
      return;
    }

    // Check if passwords match
    if (newPassword != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Passwords do not match.')),
      );
      return;
    }

    if (newPassword.isNotEmpty) {
      // Save the updated user data
      User updatedUser = User(email: newEmail, password: newPassword);
      await widget.storageService.saveUser(updatedUser);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Changes saved successfully!')),
      );

      // Navigate back after saving
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Background widget is now added to the scaffold's body
      body: Stack(
        children: [
          BackgroundWidget(),  // This widget adds the background to the page
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Back button
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        Navigator.pop(context); // Go back to the previous page
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  // Replace TextField with CustomTextField for new email
                  CustomTextField(
                    controller: newEmailController,
                    hintText: "New Email",
                    textColor: Colors.black,
                  ),
                  SizedBox(height: 16),
                  // Replace TextField with CustomTextField for new password
                  CustomTextField(
                    controller: newPasswordController,
                    hintText: "New Password",
                    isPassword: true,
                    textColor: Colors.black,
                  ),
                  SizedBox(height: 16),
                  // Replace TextField with CustomTextField for confirm password
                  CustomTextField(
                    controller: confirmPasswordController,
                    hintText: "Confirm New Password",
                    isPassword: true,
                    textColor: Colors.black,
                  ),
                  SizedBox(height: 16),
                  // Save Changes button
                  ElevatedButton(
                    style: buttonStyle(),
                    onPressed: () => _saveChanges(context),
                    child: Text('Save Changes', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    newEmailController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
