import 'package:flutter/material.dart';

class AppointmentDetailScreen extends StatelessWidget {
  final Map<String, dynamic> appointment;

  AppointmentDetailScreen({required this.appointment});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Randevu Detayı'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hasta: ${appointment['patient_name']}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(height: 8),
            Text('Tarih: ${appointment['date']}'),
            Text('Saat: ${appointment['time']}'),
            SizedBox(height: 16),
            Text('Detaylar:', style: Theme.of(context).textTheme.titleMedium),
            SizedBox(height: 8),
            Text(appointment['details'] ?? 'Detay bulunmuyor'),
          ],
        ),
      ),
    );
  }
}
