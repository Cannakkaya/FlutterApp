import 'package:flutter/material.dart';
import 'package:psikolog_app/services/directus_service.dart';

class AssistantApplyScreen extends StatelessWidget {
  final TextEditingController psychologistIdController =
      TextEditingController();
  final DirectusService _directusService = DirectusService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Apply as Assistant')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: psychologistIdController,
              decoration: InputDecoration(labelText: 'Psychologist ID'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                String psychologistId = psychologistIdController.text;
                // Asistan olarak başvuruyu yap
                await _directusService.applyAsAssistant(
                    'yourUserId', psychologistId);

                Navigator.pop(context);
              },
              child: Text('Apply'),
            ),
          ],
        ),
      ),
    );
  }
}
