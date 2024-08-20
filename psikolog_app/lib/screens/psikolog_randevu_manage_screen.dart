import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psikolog_app/providers/appointment_provider.dart';
// import 'providers/appointment_provider.dart';

class PsikologRandevuManageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appointmentProvider = Provider.of<AppointmentProvider>(context);

    // Psikolog için filtrelenmiş randevular (örneğin, sadece kendi randevuları)
    final psikologRandevular = appointmentProvider.appointments
        .where(
            (appointment) => appointment.isPsikologAppointment) // Örnek filtre
        .toList();

    return Scaffold(
      appBar: AppBar(title: Text('Psikolog - Randevu Yönetimi')),
      body: psikologRandevular.isEmpty
          ? Center(child: Text('Randevu bulunmuyor'))
          : ListView.builder(
              itemCount: psikologRandevular.length,
              itemBuilder: (context, index) {
                final appointment = psikologRandevular[index];
                return ListTile(
                  title: Text('Randevu ${appointment.id}'),
                  subtitle: Text('Tarih: ${appointment.date}'),
                );
              },
            ),
    );
  }
}
