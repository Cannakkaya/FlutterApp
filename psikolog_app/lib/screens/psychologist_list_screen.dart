import 'package:flutter/material.dart';
import '/models/psychologist.dart';
import '/services/directus_service.dart';
import 'appointment_request_screen.dart';

class PsychologistListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Psikologlar")),
      body: FutureBuilder(
        future: DirectusService().getPsychologists(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            var psychologists = snapshot.data as List<Psychologist>;
            return ListView.builder(
              itemCount: psychologists.length,
              itemBuilder: (context, index) {
                var psychologist = psychologists[index];
                return Card(
                  child: ListTile(
                    title: Text(psychologist.name),
                    subtitle: Text(psychologist.specialty),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AppointmentRequestScreen(
                              psychologist: psychologist),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          } else {
            return Center(child: Text("Veri bulunamadı"));
          }
        },
      ),
    );
  }
}
