// psikolog_dashboard_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psikolog_app/services/directus_service.dart';
import 'package:psikolog_app/providers/user_role_provider.dart';

class PsikologDashboardScreen extends StatefulWidget {
  @override
  _PsikologDashboardScreenState createState() =>
      _PsikologDashboardScreenState();
}

class _PsikologDashboardScreenState extends State<PsikologDashboardScreen> {
  late Future<Map<String, dynamic>> _appointments;

  @override
  void initState() {
    super.initState();
    final userId =
        Provider.of<UserRoleProvider>(context, listen: false).currentUserId;
    _appointments = DirectusService().getAppointmentsForPsychologist(userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Psikolog Dashboard'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _appointments,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final appointments = snapshot.data!['data'] ??
                []; // API yanıtındaki 'data' alanını kullanın
            return ListView.builder(
              itemCount: appointments.length,
              itemBuilder: (context, index) {
                final appointment = appointments[index];
                return ListTile(
                  title: Text('Patient: ${appointment['patient_name']}'),
                  subtitle: Text('Date: ${appointment['date']}'),
                );
              },
            );
          } else {
            return Center(child: Text('No appointments found'));
          }
        },
      ),
    );
  }
}
