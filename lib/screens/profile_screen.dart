import 'package:flutter/material.dart';
import '../colors/colors.dart';
import 'edit_profile_screen.dart';
import 'register_screen.dart';
import '../storage/user_storage.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final UserStorage _userStorage = LocalUserStorage();
  String _userName = 'Guest';
  String _userEmail = 'guest@example.com';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final userData = await _userStorage.getUser();
    if (userData != null) {
      setState(() {
        _userName = userData['name'] ?? 'Guest';
        _userEmail = userData['email'] ?? 'guest@example.com';
      });
    }
  }

  Future<void> _editProfile(BuildContext context) async {
    final updatedData = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfileScreen(
          name: _userName,
          email: _userEmail,
        ),
      ),
    );

    if (updatedData is Map<String, String>) {
      setState(() {
        _userName = updatedData['name']!;
        _userEmail = updatedData['email']!;
      });
      await _userStorage.saveUser(_userEmail, _userName);
      _showSnackBar(context, 'Profile updated successfully', Colors.green);
    }
  }

  void _confirmLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Log Out'),
        content: Text('Are you sure you want to log out?'),
        actions: [
          _buildDialogButton(
            context,
            label: 'Cancel',
            color: Colors.grey,
            onPressed: () => Navigator.of(context).pop(),
          ),
          _buildDialogButton(
            context,
            label: 'Log Out',
            color: Colors.red,
            onPressed: () async {
              Navigator.of(context).pop(); // Close the dialog
              await _userStorage.clearUser(); // Clear user data
              _showSnackBar(context, 'Logged out successfully', Colors.green);
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => RegisterScreen()),
                    (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message, Color backgroundColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
      ),
    );
  }

  TextButton _buildDialogButton(BuildContext context,
      {required String label, required Color color, required VoidCallback onPressed}) {
    return TextButton(
      onPressed: onPressed,
      child: Text(label, style: TextStyle(color: color)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile', style: TextStyle(color: Colors.white)),
        backgroundColor: AppColors.primaryRed,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildAvatar(),
            SizedBox(height: 16),
            _buildUserInfo(),
            SizedBox(height: 24),
            _buildActionButton(
              context,
              label: 'Edit Profile',
              onPressed: () => _editProfile(context),
            ),
            SizedBox(height: 16),
            _buildActionButton(
              context,
              label: 'Log Out',
              onPressed: () => _confirmLogout(context),
            ),
          ],
        ),
      ),
    );
  }

  CircleAvatar _buildAvatar() {
    return CircleAvatar(
      radius: 50,
      backgroundColor: AppColors.primaryRed,
      child: Icon(Icons.person, size: 50, color: Colors.white),
    );
  }

  Column _buildUserInfo() {
    return Column(
      children: [
        Text(
          _userName,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          _userEmail,
          style: TextStyle(fontSize: 16, color: Colors.grey[700]),
        ),
      ],
    );
  }

  ElevatedButton _buildActionButton(BuildContext context,
      {required String label, required VoidCallback onPressed}) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(label, style: TextStyle(color: Colors.white)),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryRed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        minimumSize: Size(200, 50),
      ),
    );
  }
}
