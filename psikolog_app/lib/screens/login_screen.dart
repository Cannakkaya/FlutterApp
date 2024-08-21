import 'package:flutter/material.dart';
import 'package:psikolog_app/services/directus_service.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final DirectusService _directusService = DirectusService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: usernameController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                String email = usernameController.text;
                String password = passwordController.text;

                // Directus API ile kullanıcı doğrulaması
                Map<String, dynamic> user =
                    await _directusService.loginUser(email, password);

                if (user.isNotEmpty) {
                  // Rol bazlı yönlendirme ve rol güncelleme
                  final role =
                      user['role'] ?? 'musteri'; // Varsayılan rol 'musteri'
                  if (role == 'admin') {
                    Navigator.pushReplacementNamed(context, '/admin');
                  } else if (role == 'psikolog') {
                    Navigator.pushReplacementNamed(context, '/psikolog');
                  } else if (role == 'asistan') {
                    Navigator.pushReplacementNamed(context, '/asistan');
                  } else {
                    Navigator.pushReplacementNamed(context, '/musteri');
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Invalid email or password')),
                  );
                }
              },
              child: Text('Login'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/register');
              },
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
