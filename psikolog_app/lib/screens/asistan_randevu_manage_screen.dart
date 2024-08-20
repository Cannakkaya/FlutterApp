import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psikolog_app/providers/appointment_provider.dart';
// import 'providers/appointment_provider.dart';

class AsistanRandevuManageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appointmentProvider = Provider.of<AppointmentProvider>(context);

    // Asistan için filtrelenmiş randevular (örneğin, sadece kendi randevuları)
    final asistanRandevular = appointmentProvider.appointments
        .where(
            (appointment) => appointment.isAsistanAppointment) // Örnek filtre
        .toList();

    return Scaffold(
      appBar: AppBar(title: Text('Asistan - Randevu Yönetimi')),
      body: asistanRandevular.isEmpty
          ? Center(child: Text('Randevu bulunmuyor'))
          : ListView.builder(
              itemCount: asistanRandevular.length,
              itemBuilder: (context, index) {
                final appointment = asistanRandevular[index];
                return ListTile(
                  title: Text('Randevu ${appointment.id}'),
                  subtitle: Text('Tarih: ${appointment.date}'),
                );
              },
            ),
    );
  }
}
