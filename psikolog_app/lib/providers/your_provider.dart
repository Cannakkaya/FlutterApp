import 'package:flutter/material.dart';

class YourProvider with ChangeNotifier {
  // Durum değişkenleri ve metodlar

  // Örneğin, bir sayacın değerini tutabiliriz
  int _counter = 0;

  int get counter => _counter;

  void incrementCounter() {
    _counter++;
    notifyListeners(); // Dinleyicilere güncellemeyi bildirir
  }
}
