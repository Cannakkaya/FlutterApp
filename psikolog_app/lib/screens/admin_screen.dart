import 'package:flutter/material.dart';

class AdminScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Admin Paneli')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                    context, '/admin_randevu_manage'); // Randevu yönetim ekranı
              },
              child: Text('Randevu Yönetimi'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                    context, '/oyun'); // Mini oyun yönetim ekranı
              },
              child: Text('Mini Oyun Yönetimi'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                    context, '/contact'); // İletişim bilgileri yönetim ekranı
              },
              child: Text('İletişim Bilgileri Yönetimi'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                    context, '/manageUsers'); // Kullanıcı yönetim ekranı
              },
              child: Text('Kullanıcı Yönetimi'),
            ),
          ],
        ),
      ),
    );
  }
}
