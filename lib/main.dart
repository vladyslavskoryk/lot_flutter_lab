import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'colors/colors.dart';
import 'screens/home_screen.dart';
import 'screens/list_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User App',
      theme: ThemeData(
        primaryColor: AppColors.primarySwatch,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: WelcomeScreen(), // Set WelcomeScreen as the initial screen
    );
  }
}

// WelcomeScreen
class WelcomeScreen extends StatelessWidget {
  Future<bool> _checkInternetConnection() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  void _showNoInternetDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('No Internet Connection'),
        content:
            Text('Please connect to the internet for the best experience.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK', style: TextStyle(color: AppColors.primaryRed)),
          ),
        ],
      ),
    );
  }

  Future<void> _navigateWithCheck(
      BuildContext context, Widget destination) async {
    final hasInternet = await _checkInternetConnection();
    if (!hasInternet) {
      _showNoInternetDialog(context);
    }
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => destination),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome', style: TextStyle(color: Colors.white)),
        backgroundColor: AppColors.primaryRed,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Image.asset(
          'assets/logo.png', // Save the generated logo as assets/logo.png
          height: 300,
        ),
            Text(
              'Welcome to UniList!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryRed,
              ),
            ),
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: () => _navigateWithCheck(context, LoginScreen()),
              child: Text('Login', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryRed,
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _navigateWithCheck(context, RegisterScreen()),
              child: Text('Register', style: TextStyle(color: Colors.white)),
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

// MainScreen with Bottom Navigation
class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final _pages = [
    {'widget': HomeScreen(), 'label': 'Home', 'icon': Icons.home},
    {'widget': ListScreen(), 'label': 'List', 'icon': Icons.list},
    {'widget': ProfileScreen(), 'label': 'Profile', 'icon': Icons.person},
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex]['widget'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        items: _pages
            .map((page) => BottomNavigationBarItem(
                  icon: Icon(page['icon'] as IconData),
                  label: page['label'] as String,
                ))
            .toList(),
        currentIndex: _selectedIndex,
        selectedItemColor: AppColors.primaryRed,
        onTap: _onItemTapped,
      ),
    );
  }
}
