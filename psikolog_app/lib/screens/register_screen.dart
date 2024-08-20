import 'package:flutter/material.dart';
import 'package:psikolog_app/services/directus_service.dart';
import 'package:psikolog_app/services/directus_service.dart'; // Servis dosyanızın yolu

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final DirectusService directusService = DirectusService();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;
  String errorMessage = '';

  void register() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    final name = nameController.text;
    final email = emailController.text;
    final password = passwordController.text;

    try {
      await directusService.createUser(name, email, password);
      // Kayıt başarılı, başarılı mesajı gösterebilir veya başka bir ekrana geçiş yapabilirsiniz
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User registered successfully')),
      );
    } catch (error) {
      setState(() {
        errorMessage = 'Failed to register user: $error';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            if (isLoading) CircularProgressIndicator(),
            if (errorMessage.isNotEmpty)
              Text(errorMessage, style: TextStyle(color: Colors.red)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: isLoading ? null : register,
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
