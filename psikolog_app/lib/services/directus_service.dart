import 'dart:convert';
import 'package:http/http.dart' as http;

class DirectusService {
  final String baseUrl = 'http://localhost:8055'; // Directus API URL
  final String collection = 'users'; // Koleksiyon adı
  final String apiToken = 'yOHGTq43vzP9NCbYtXAaYLbojG-iB5YI'; // API anahtarı

  Future<void> createUser(String name, String email, String password) async {
    print("Click");
    final url = Uri.parse('$baseUrl/items/$collection');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiToken',
      },
      body: jsonEncode({
        'name': name,
        'email': email,
        'password': password,
        'created_at': DateTime.now().toIso8601String(),
      }),
    );

    if (response.statusCode == 200) {
      print('User created successfully');
    } else {
      print('Failed to create user: ${response.body}');
    }
  }

  Future<void> updateUser(
      String id, String name, String email, String password) async {
    final url = Uri.parse('$baseUrl/items/$collection/$id');
    final response = await http.patch(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiToken',
      },
      body: jsonEncode({
        'name': name,
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      print('User updated successfully');
    } else {
      print('Failed to update user: ${response.body}');
    }
  }

  Future<void> deleteUser(String id) async {
    final url = Uri.parse('$baseUrl/items/$collection/$id');
    final response = await http.delete(
      url,
      headers: {
        'Authorization': 'Bearer $apiToken',
      },
    );

    if (response.statusCode == 200) {
      print('User deleted successfully');
    } else {
      print('Failed to delete user: ${response.body}');
    }
  }

  Future<Map<String, dynamic>> getUser(String id) async {
    final url = Uri.parse('$baseUrl/items/$collection/$id');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $apiToken',
      },
    );

    if (response.statusCode == 200) {
      print(response.body);
      return jsonDecode(response.body);
    } else {
      print('Failed to fetch user: ${response.body}');
      return {};
    }
  }

  // Kullanıcı giriş doğrulaması
  Future<Map<String, dynamic>> loginUser(String email, String password) async {
    final url = Uri.parse(
        '$baseUrl/items/$collection?filter[email][_eq]=$email&filter[password][_eq]=$password');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $apiToken',
      },
    );

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      if (result['data'].isNotEmpty) {
        return result['data'][0];
      } else {
        print('No user found with provided credentials');
        return {};
      }
    } else {
      print('Failed to login user: ${response.body}');
      return {};
    }
  }
}
