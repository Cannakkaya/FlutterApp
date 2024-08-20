import 'dart:convert';
import 'package:http/http.dart' as http;

class DirectusService {
  final String baseUrl = 'http://localhost:8055'; // Directus API URL
  final String collection = 'users'; // Koleksiyon adı
  final String apiToken =
      'mio5ABagZum2o1pJBT3_HfePsqIF6hSWP_'; // API key burada

  // Kullanıcı oluşturma
  Future<void> createUser(String name, String email, String password) async {
    final url = Uri.parse('$baseUrl/items/$collection'); // Directus API URL'si
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiToken',
      },
      body: jsonEncode({
        'data': {
          'first_name': name, // Kullanıcı adı
          'email': email, // E-posta
          'password': password, // Şifre
          'status': 'active' // Durum
        }
      }),
    );

    if (response.statusCode == 200) {
      print('User created successfully');
    } else {
      print('Failed to create user: ${response.body}');
    }
  }

  // Kullanıcı güncelleme
  Future<void> updateUser(
      String id, String name, String email, String password) async {
    final url = Uri.parse(
        '$baseUrl/items/$collection/$id'); // ID ile kullanıcı güncelleme
    final response = await http.patch(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiToken',
      },
      body: jsonEncode({
        'data': {
          'first_name': name, // Kullanıcı adı
          'email': email, // E-posta
          'password': password // Şifre
        }
      }),
    );

    if (response.statusCode == 200) {
      print('User updated successfully');
    } else {
      print('Failed to update user: ${response.body}');
    }
  }

  // Kullanıcı silme
  Future<void> deleteUser(String id) async {
    final url =
        Uri.parse('$baseUrl/items/$collection/$id'); // ID ile kullanıcı silme
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

  // Kullanıcı bilgilerini alma
  Future<Map<String, dynamic>> getUser(String id) async {
    final url = Uri.parse(
        '$baseUrl/items/$collection/$id'); // ID ile kullanıcı bilgisi alma
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $apiToken',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data']; // 'data' kısmını döndürüyoruz
    } else {
      print('Failed to fetch user: ${response.body}');
      return {};
    }
  }
}
