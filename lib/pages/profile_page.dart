import 'package:flutter/material.dart';
import '../modules/user.dart';
import '../services/storage_service.dart';
import '../widgets/background_widget.dart';
import '../widgets/button_style.dart';
import 'edit_user_page.dart';

class ProfilePage extends StatefulWidget {
  final StorageService storageService;

  ProfilePage({required this.storageService});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late TextEditingController emailController;
  User? currentUser;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    currentUser = await widget.storageService.getUser("userEmail@example.com");
    if (currentUser != null) {
      setState(() {
        emailController.text = currentUser!.email;
      });
    }
  }

  // Метод для виходу з облікового запису
  Future<void> _logOut(BuildContext context) async {
    await widget.storageService.clearUserData();
    await widget.storageService.setLoggedIn(false);  // Зміна статусу логування на false
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackgroundWidget(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "AETHERVEIL FANTASY",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  CircleAvatar(
                    radius: 50,
                    child: Icon(Icons.person, size: 50, color: Color(0xFF427065)),
                  ),
                  SizedBox(height: 20),
                  Text(
                    currentUser?.email ?? 'Unknown User',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    style: buttonStyle(),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditUserPage(storageService: widget.storageService),
                        ),
                      );
                    },
                    child: Text('Edit and Save', style: TextStyle(color: Colors.white)),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    style: buttonStyle(),
                    onPressed: () => _logOut(context),  // Виклик методу для виходу
                    child: Text('Log out', style: TextStyle(color: Colors.white)),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    style: buttonStyle(),
                    onPressed: () {
                      Navigator.pushNamed(context, '/'); // Повернення на HomePage
                    },
                    child: Text('Back to Home', style: TextStyle(color: Colors.white)),
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
    emailController.dispose();
    super.dispose();
  }
}
