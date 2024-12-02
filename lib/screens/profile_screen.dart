import 'package:flutter/material.dart';
import '../colors/colors.dart';
import 'register_screen.dart';
import 'login_screen.dart';
import '../storage/user_storage.dart';

class ProfileScreen extends StatelessWidget {
  final UserStorage _userStorage = LocalUserStorage();

  void _register(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegisterScreen()),
    );
  }

  void _signIn(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  void _logOut(BuildContext context) async {
    await _userStorage.clearUser(); // Clear user data
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Logged out successfully'),
      backgroundColor: Colors.green,
    ));
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => LoginScreen(
          onLoginSuccess: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ProfileScreen()),
            );
          },
        ),
      ),
          (route) => false,
    );
  }

  Future<Map<String, String>> _fetchUserData() async {
    return await _userStorage.getUser() ?? {'name': 'Guest', 'email': 'guest@example.com'};
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile', style: TextStyle(color: Colors.white)),
        backgroundColor: AppColors.primaryRed,
      ),
      body: FutureBuilder<Map<String, String>>(
        future: _fetchUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading user data'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('No user data found'));
          }

          final userData = snapshot.data!;
          final userName = userData['name'] ?? 'Guest';
          final userEmail = userData['email'] ?? 'guest@example.com';

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // User Icon
                CircleAvatar(
                  radius: 50,
                  backgroundColor: AppColors.primaryRed,
                  child: Icon(
                    Icons.person,
                    size: 50,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 16),
                // User Info
                Text(
                  userName,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  userEmail,
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
                SizedBox(height: 24),
                // Register Button
                ElevatedButton(
                  onPressed: () => _register(context),
                  child: Text(
                    'Register',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryRed,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    minimumSize: Size(200, 50),
                  ),
                ),
                SizedBox(height: 16),
                // Sign In Button
                ElevatedButton(
                  onPressed: () => _signIn(context),
                  child: Text(
                    'Sign In',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryRed,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    minimumSize: Size(200, 50),
                  ),
                ),
                SizedBox(height: 16),
                // Log Out Button
                ElevatedButton(
                  onPressed: () => _logOut(context),
                  child: Text(
                    'Log Out',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryRed,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    minimumSize: Size(200, 50),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
