// lib/services/local_storage.dart
import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveGameProgress(String key, dynamic value) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString(key, value);
}

Future<String?> loadGameProgress(String key) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString(key);
}
