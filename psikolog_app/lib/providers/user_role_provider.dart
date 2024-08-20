import 'package:flutter/foundation.dart';

enum UserRole { admin, psychologist, assistant, customer }

class UserRoleProvider with ChangeNotifier {
  UserRole _role = UserRole.customer; // Varsayılan rol customer

  UserRole get role => _role;

  void setRole(UserRole newRole) {
    _role = newRole;
    notifyListeners();
  }

  // String bazlı rol atama fonksiyonu
  void setRoleFromString(String newRole) {
    switch (newRole.toLowerCase()) {
      case 'admin':
        _role = UserRole.admin;
        break;
      case 'psikolog':
        _role = UserRole.psychologist;
        break;
      case 'asistan':
        _role = UserRole.assistant;
        break;
      case 'musteri':
        _role = UserRole.customer;
        break;
      default:
        _role = UserRole.customer;
    }
    notifyListeners();
  }
}
