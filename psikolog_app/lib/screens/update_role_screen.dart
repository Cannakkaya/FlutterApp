import 'package:flutter/material.dart';
import 'package:psikolog_app/services/directus_service.dart';

class UpdateRoleScreen extends StatelessWidget {
  final TextEditingController userIdController = TextEditingController();
  final TextEditingController roleController = TextEditingController();
  final DirectusService _directusService = DirectusService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Update Role')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: userIdController,
              decoration: InputDecoration(labelText: 'User ID'),
            ),
            TextField(
              controller: roleController,
              decoration: InputDecoration(labelText: 'Role'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                String userId = userIdController.text;
                String role = roleController.text;
                // Kullanıcı rolünü güncelle
                await _directusService.updateUserRole(userId, role);

                Navigator.pop(context);
              },
              child: Text('Update Role'),
            ),
          ],
        ),
      ),
    );
  }
}
