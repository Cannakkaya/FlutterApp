import 'package:flutter/material.dart';

class ContactScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('İletişime Geç'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'İletişim Bilgileri',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall, // headline6 yerine headlineSmall kullanıldı
            ),
            SizedBox(height: 20),
            Text(
              'Email: your-email@example.com',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium, // bodyText1 yerine bodyMedium kullanıldı
            ),
            SizedBox(height: 10),
            Text(
              'Telefon: +1234567890',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium, // bodyText1 yerine bodyMedium kullanıldı
            ),
            SizedBox(height: 30),
            Text(
              'Bize mesaj bırakın:',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall, // headline6 yerine headlineSmall kullanıldı
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Adınız',
              ),
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Mesajınız',
              ),
              maxLines: 5,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Mesaj gönderme işlemleri burada yapılabilir
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Mesajınız gönderildi!')),
                );
              },
              child: Text('Gönder'),
            ),
          ],
        ),
      ),
    );
  }
}
