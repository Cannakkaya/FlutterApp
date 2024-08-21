import 'package:flutter/material.dart';
import 'package:psikolog_app/services/directus_service.dart';
import 'package:psikolog_app/services/directus_service.dart';

class RoleApplicationScreen extends StatefulWidget {
  final String userId;

  RoleApplicationScreen({required this.userId});

  @override
  _RoleApplicationScreenState createState() => _RoleApplicationScreenState();
}

class _RoleApplicationScreenState extends State<RoleApplicationScreen> {
  final DirectusService _directusService = DirectusService();
  final TextEditingController _detailsController = TextEditingController();
  String _selectedRole = 'asistan';
  String _selectedPsychologistId = '';

  void _applyForRole() async {
    if (_selectedRole == 'asistan') {
      await _directusService.applyAsAssistant(
          widget.userId, _selectedPsychologistId);
    } else if (_selectedRole == 'psikolog') {
      final details = {'education': _detailsController.text};
      await _directusService.applyAsPsychologist(widget.userId, details);
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Role Application'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButton<String>(
              value: _selectedRole,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedRole = newValue!;
                });
              },
              items: <String>['asistan', 'psikolog']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            if (_selectedRole == 'psikolog')
              TextField(
                controller: _detailsController,
                decoration:
                    InputDecoration(labelText: 'Details (e.g., Education)'),
              ),
            if (_selectedRole == 'asistan')
              TextField(
                decoration:
                    InputDecoration(labelText: 'Select Psychologist ID'),
                onChanged: (value) {
                  _selectedPsychologistId = value;
                },
              ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _applyForRole,
              child: Text('Apply'),
            ),
          ],
        ),
      ),
    );
  }
}
