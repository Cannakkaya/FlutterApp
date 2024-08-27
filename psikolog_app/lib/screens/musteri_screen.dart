import 'package:flutter/material.dart';

class MusteriScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Müşteri Dashboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2, // İki sütunlu bir grid oluşturur
          crossAxisSpacing: 16.0, // Sütunlar arasındaki boşluk
          mainAxisSpacing: 16.0, // Satırlar arasındaki boşluk
          children: [
            // Randevu oluşturma
            _buildGridItem(
              context,
              'Randevu Oluştur',
              Icons.calendar_today,
              '/appointment',
            ),
            // // Mini oyun
            // _buildGridItem(
            //   context,
            //   'Mini Oyun',
            //   Icons.games,
            //   '/oyun',
            // ),
            // İletişim
            _buildGridItem(
              context,
              'İletişim',
              Icons.contact_mail,
              '/contact',
            ),
            // // Psikolog rolü başvurusu
            // _buildGridItem(
            //   context,
            //   'Psikolog Başvurusu',
            //   Icons.person_add,
            //   '/psikolog', // Buraya başvuru ekranı URL'si ekleyebilirsiniz
            // ),
            // // Asistan rolü başvurusu
            // _buildGridItem(
            //   context,
            //   'Asistan Başvurusu',
            //   Icons.person_add_alt,
            //   '/asistan', // Buraya başvuru ekranı URL'si ekleyebilirsiniz
            // ),
          ],
        ),
      ),
    );
  }

  Widget _buildGridItem(
      BuildContext context, String title, IconData icon, String route) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      child: Card(
        elevation: 4.0,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 48.0),
              Text(title, style: TextStyle(fontSize: 18.0)),
            ],
          ),
        ),
      ),
    );
  }
}
