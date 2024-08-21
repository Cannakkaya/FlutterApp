import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psikolog_app/services/directus_service.dart';
import 'package:psikolog_app/providers/user_role_provider.dart';

class PsikologApplicationScreen extends StatefulWidget {
  @override
  _PsikologApplicationScreenState createState() =>
      _PsikologApplicationScreenState();
}

class _PsikologApplicationScreenState extends State<PsikologApplicationScreen> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _email = '';
  String _experience = '';

  @override
  Widget build(BuildContext context) {
    final directusService = Provider.of<DirectusService>(context);

    // Kullanıcı ID'sini almak için Provider kullanımı
    final userId = Provider.of<UserRoleProvider>(context).currentUserId;

    return Scaffold(
      appBar: AppBar(
        title: Text('Psikolog Başvurusu'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Adınız'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Bu alan boş bırakılamaz';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _name = value;
                  });
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      !RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                    return 'Geçerli bir email adresi girin';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _email = value;
                  });
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Deneyim'),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Bu alan boş bırakılamaz';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _experience = value;
                  });
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState?.validate() ?? false) {
                    final details = {
                      'name': _name,
                      'email': _email,
                      'experience': _experience,
                    };
                    await directusService.applyAsPsychologist(userId, details);

                    // Başvuru yapıldıktan sonra psikolog dashboard'una yönlendirin
                    Navigator.pushReplacementNamed(
                        context, '/psychologist-dashboard');
                  }
                },
                child: Text('Başvuruyu Gönder'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
