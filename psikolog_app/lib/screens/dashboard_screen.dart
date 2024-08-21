import 'package:flutter/material.dart';
import 'package:psikolog_app/services/directus_service.dart';

class DashboardScreen extends StatefulWidget {
  final String userId;

  DashboardScreen({required this.userId});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final DirectusService _directusService = DirectusService();
  late Future<Map<String, dynamic>> _user;

  @override
  void initState() {
    super.initState();
    _user = _directusService.getUser(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _user,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final userData = snapshot.data!;
            final role = userData['role'];
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Welcome, ${userData['name']}'),
                  Text('Role: $role'),
                  if (role == 'musteri')
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          '/role-application',
                          arguments: widget.userId,
                        );
                      },
                      child: Text('Apply for a Role'),
                    ),
                ],
              ),
            );
          } else {
            return Center(child: Text('No user data found'));
          }
        },
      ),
    );
  }
}
