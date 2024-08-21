import 'package:flutter/material.dart';

class RoleApplicationScreen extends StatelessWidget {
  final String userId;

  RoleApplicationScreen({required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Role Application'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('User ID: $userId'),
            // Diğer UI bileşenlerini buraya ekleyin
          ],
        ),
      ),
    );
  }
}
