import 'package:flutter/material.dart';
import '../services/directus_service.dart'; // DirectusService sınıfını import edin

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  bool _isLoading = false;

  Future<void> _register() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await DirectusService().createUser(
        _nameController.text,
        _emailController.text,
        _passwordController.text,
      );
      // Kayıt işlemi başarılı, başarılı mesajı gösterilebilir veya başka bir işlemler yapılabilir.
      Navigator.of(context).pushReplacementNamed('/login');
    } catch (error) {
      // Hata işleme
      print('Error: $error');
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            _isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _register,
                    child: Text('Register'),
                  ),
          ],
        ),
      ),
    );
  }
}
