import 'package:flutter/material.dart';

class UnknownScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bilinmeyen Sayfa'),
      ),
      body: Center(
        child: Text('Bu sayfa mevcut değil.'),
      ),
    );
  }
}
