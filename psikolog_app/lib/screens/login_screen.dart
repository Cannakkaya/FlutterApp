import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_role_provider.dart'; // UserRoleProvider import edilmelidir

class User {
  final String username;
  final String password;
  final String role;

  User({required this.username, required this.password, required this.role});
}

class LoginScreen extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final List<User> users = [
    User(username: 'admin', password: 'admin123', role: 'admin'),
    User(username: 'psikolog', password: 'psikolog123', role: 'psikolog'),
    User(username: 'asistan', password: 'asistan123', role: 'asistan'),
    User(username: 'musteri', password: 'musteri123', role: 'musteri'),
  ];

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
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String username = usernameController.text;
                String password = passwordController.text;

                // Kullanıcı doğrulaması
                User? user = users.firstWhere(
                  (user) =>
                      user.username == username && user.password == password,
                  orElse: () => User(
                      username: '',
                      password: '',
                      role: 'none'), // Varsayılan bir User döndür
                );

                if (user.role != 'none') {
                  // Rol bazlı yönlendirme ve rol güncelleme
                  final userRoleProvider =
                      Provider.of<UserRoleProvider>(context, listen: false);

                  // Rolü enum'a dönüştür
                  UserRole role;
                  switch (user.role) {
                    case 'admin':
                      role = UserRole.admin;
                      break;
                    case 'psikolog':
                      role = UserRole.psychologist;
                      break;
                    case 'asistan':
                      role = UserRole.assistant;
                      break;
                    case 'musteri':
                      role = UserRole.customer;
                      break;
                    default:
                      role = UserRole.customer;
                      break;
                  }
                  userRoleProvider.setRole(role);

                  // Yönlendirme
                  if (user.role == 'admin') {
                    Navigator.pushReplacementNamed(context, '/admin');
                  } else if (user.role == 'psikolog') {
                    Navigator.pushReplacementNamed(context, '/psikolog');
                  } else if (user.role == 'asistan') {
                    Navigator.pushReplacementNamed(context, '/asistan');
                  } else if (user.role == 'musteri') {
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
