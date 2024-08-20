// lib/screens/game_screen.dart
import 'package:flutter/material.dart';
import '../models/question.dart';
import '../data/questions.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  List<Question> _questions = [];
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _questions = questions; // Soruları yükle
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Oyun')),
      body: _questions.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Text(_questions[_currentIndex].question),
                // Yanıt girme alanları ve diğer bileşenler
                ElevatedButton(
                  onPressed: () {
                    // Sonraki soruya geç
                    setState(() {
                      if (_currentIndex < _questions.length - 1) {
                        _currentIndex++;
                      } else {
                        // Oyun bitiminde yapılacaklar
                      }
                    });
                  },
                  child: Text('Sonraki Soru'),
                ),
              ],
            ),
    );
  }
}
