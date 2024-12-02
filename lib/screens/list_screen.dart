import 'package:flutter/material.dart';

import '../colors/colors.dart';

class ListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List', style: TextStyle(color: Colors.white)),
        backgroundColor: AppColors.primaryRed,
      ),
      body: Center(
        child: Text('List of items'),
      ),
    );
  }
}
