import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psikolog_app/services/directus_service.dart';
import 'package:psikolog_app/services/directus_service.dart'; // DirectusService import edilmelidir
import '../providers/user_role_provider.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final DirectusService _directusService =
      DirectusService(); // DirectusService örneği

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
              decoration: InputDecoration(labelText: 'E-Mail'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                String username = usernameController.text;
                String password = passwordController.text;

                // Directus API ile kullanıcı doğrulaması
                Map<String, dynamic> user =
                    await _directusService.loginUser(username, password);

                if (user.isNotEmpty) {
                  // Rol bazlı yönlendirme ve rol güncelleme
                  final userRoleProvider =
                      Provider.of<UserRoleProvider>(context, listen: false);

                  // Rolü belirle
                  String role = user['role'] ?? 'musteri';
                  UserRole userRole;
                  switch (role) {
                    case 'admin':
                      userRole = UserRole.admin;
                      break;
                    case 'psikolog':
                      userRole = UserRole.psychologist;
                      break;
                    case 'asistan':
                      userRole = UserRole.assistant;
                      break;
                    case 'musteri':
                      userRole = UserRole.customer;
                      break;
                    default:
                      userRole = UserRole.customer;
                      break;
                  }
                  userRoleProvider.setRole(userRole);

                  // Yönlendirme
                  if (userRole == UserRole.admin) {
                    Navigator.pushReplacementNamed(context, '/admin');
                  } else if (userRole == UserRole.psychologist) {
                    Navigator.pushReplacementNamed(context, '/psikolog');
                  } else if (userRole == UserRole.assistant) {
                    Navigator.pushReplacementNamed(context, '/asistan');
                  } else if (userRole == UserRole.customer) {
                    Navigator.pushReplacementNamed(context, '/musteri');
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Invalid username or password')),
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
