// directus_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class DirectusService {
  final String baseUrl = 'http://localhost:8055'; // Directus API URL
  final String collection = 'appointments'; // Koleksiyon adı (randevular)
  final String apiToken = 'yOHGTq43vzP9NCbYtXAaYLbojG-iB5YI'; // API anahtarı

  // Kullanıcı kaydı
  Future<void> createUser(String name, String email, String password) async {
    final url = Uri.parse('$baseUrl/items/users');
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
        'role': 'musteri', // Otomatik olarak müşteri rolü atanıyor
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
    final url = Uri.parse('$baseUrl/items/users/$id');
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

  // Kullanıcı rolünü güncelleme
  Future<void> updateUserRole(String id, String role) async {
    final url = Uri.parse('$baseUrl/items/users/$id');
    final response = await http.patch(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiToken',
      },
      body: jsonEncode({
        'role': role,
      }),
    );

    if (response.statusCode == 200) {
      print('User role updated successfully');
    } else {
      print('Failed to update role: ${response.body}');
    }
  }

  // Kullanıcı başvurusu (Asistan olarak başvuru)
  Future<void> applyAsAssistant(String id, String psychologistId) async {
    final url = Uri.parse('$baseUrl/items/users/$id');
    final response = await http.patch(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiToken',
      },
      body: jsonEncode({
        'psychologist_id': psychologistId,
        'role': 'asistan',
      }),
    );

    if (response.statusCode == 200) {
      print('Applied as assistant successfully');
    } else {
      print('Failed to apply as assistant: ${response.body}');
    }
  }

  // Psikolog olarak başvuru
  Future<void> applyAsPsychologist(
      String id, Map<String, dynamic> details) async {
    final url = Uri.parse('$baseUrl/items/users/$id');
    final response = await http.patch(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiToken',
      },
      body: jsonEncode({
        'role': 'pending_psychologist', // Başvuru durumunu belirtiyoruz
        'application_details': details, // Başvuru detayları
      }),
    );

    if (response.statusCode == 200) {
      print('Applied as psychologist successfully');
    } else {
      print('Failed to apply as psychologist: ${response.body}');
    }
  }

  // Kullanıcı silme
  Future<void> deleteUser(String id) async {
    final url = Uri.parse('$baseUrl/items/users/$id');
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

  // Kullanıcı alma
  Future<Map<String, dynamic>> getUser(String id) async {
    final url = Uri.parse('$baseUrl/items/users/$id');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $apiToken',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print('Failed to fetch user: ${response.body}');
      return {};
    }
  }

  // Kullanıcı giriş doğrulaması
  Future<Map<String, dynamic>> loginUser(String email, String password) async {
    final url = Uri.parse(
        '$baseUrl/items/users?filter[email][_eq]=$email&filter[password][_eq]=$password');
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

  // Psikolog için randevular alma
  Future<Map<String, dynamic>> getAppointmentsForPsychologist(
      String psychologistId) async {
    final url = Uri.parse(
        '$baseUrl/items/appointments?filter[psychologist_id][_eq]=$psychologistId');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $apiToken',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print('Failed to fetch appointments: ${response.body}');
      return {};
    }
  }
}
