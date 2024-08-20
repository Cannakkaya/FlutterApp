import 'package:flutter/material.dart';
import '../models/appointment.dart';

class AppointmentTile extends StatelessWidget {
  final Appointment appointment;

  AppointmentTile(this.appointment);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(appointment.title),
      subtitle: Text(appointment.date.toString()),
    );
  }
}
