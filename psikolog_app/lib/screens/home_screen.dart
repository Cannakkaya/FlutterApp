import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psikolog_app/models/appointment.dart';
import 'package:psikolog_app/providers/user_role_provider.dart';
import '../providers/appointment_provider.dart';
import 'appointment_screen.dart';
import 'game_screen.dart';
import 'contact_screen.dart'; // İletişim sayfası import edilmelidir

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appointmentProvider = Provider.of<AppointmentProvider>(context);
    final role = Provider.of<UserRole>(
        context); // Kullanıcının rolünü almak için bir provider

    // Randevuları role göre filtrele
    List<Appointment> filteredAppointments;
    if (role == UserRole.admin) {
      filteredAppointments = appointmentProvider.appointments;
    } else if (role == UserRole.psychologist) {
      filteredAppointments = appointmentProvider.appointments
          .where((appointment) =>
              appointment.isPsikologAppointment) // Psikolog için filtreleme
          .toList();
    } else if (role == UserRole.assistant) {
      filteredAppointments = appointmentProvider.appointments
          .where((appointment) =>
              appointment.isAsistanAppointment) // Asistan için filtreleme
          .toList();
    } else {
      filteredAppointments = [];
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Ana Sayfa'),
        actions: [
          if (role == UserRole.admin ||
              role == UserRole.psychologist ||
              role ==
                  UserRole
                      .assistant) // Randevu ekleme sadece belirli roller için
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AppointmentScreen(),
                  ),
                );
              },
            ),
          IconButton(
            icon: Icon(Icons.contact_mail),
            onPressed: () {
              Navigator.of(context).pushNamed(
                  '/contact'); // İletişime geçme ekranına yönlendirme
            },
          ),
          IconButton(
            icon: Icon(Icons.gamepad),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => GameScreen(),
                ),
              );
            },
          )
        ],
      ),
      body: ListView.builder(
        itemCount: filteredAppointments.length,
        itemBuilder: (context, index) {
          final appointment = filteredAppointments[index];
          return ListTile(
            title: Text(appointment.title),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Tarih: ${appointment.date.toString()}'),
                Text('Müşteri: ${appointment.name}'),
                Text('Notlar: ${appointment.notes}'),
              ],
            ),
            trailing: role == UserRole.admin
                ? IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      appointmentProvider.removeAppointment(appointment.id);
                    },
                  )
                : null, // Admin dışında silme butonu gösterilmez
            onTap: () {
              // Randevu detaylarına gitmek için
            },
          );
        },
      ),
    );
  }
}
