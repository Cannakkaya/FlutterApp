import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psikolog_app/providers/appointment_provider.dart';
// import 'providers/appointment_provider.dart';

class AdminRandevuManageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appointmentProvider = Provider.of<AppointmentProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Admin - Randevu Yönetimi')),
      body: appointmentProvider.appointments.isEmpty
          ? Center(child: Text('Randevu bulunmuyor'))
          : ListView.builder(
              itemCount: appointmentProvider.appointments.length,
              itemBuilder: (context, index) {
                final appointment = appointmentProvider.appointments[index];
                return ListTile(
                  title: Text('Randevu ${appointment.id}'),
                  subtitle: Text('Tarih: ${appointment.date}'),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      appointmentProvider.removeAppointment(appointment.id);
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(
              context, '/addAppointment'); // Randevu ekleme ekranı
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
