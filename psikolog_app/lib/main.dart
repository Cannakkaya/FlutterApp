import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/appointment_provider.dart';
import 'providers/user_role_provider.dart';
import 'screens/home_screen.dart';
import 'screens/appointment_screen.dart';
import 'screens/contact_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/admin_screen.dart';
import 'screens/psikolog_screen.dart';
import 'screens/asistan_screen.dart';
import 'screens/musteri_screen.dart';
import 'screens/manage_users_screen.dart';
import 'screens/game_screen.dart';
import 'screens/unknown_screen.dart';
import 'screens/admin_randevu_manage_screen.dart';
import 'screens/role_application_screen.dart'; // Role Application ekranı
import 'screens/dashboard_screen.dart'; // Dashboard ekranı
import 'services/directus_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppointmentProvider()),
        ChangeNotifierProvider(create: (context) => UserRoleProvider()),
        Provider(create: (context) => DirectusService()),
      ],
      child: MaterialApp(
        title: 'Psikolog Randevu Sistemi',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => LoginScreen(),
          '/login': (context) => LoginScreen(),
          '/register': (context) => RegisterScreen(),
          '/appointment': (context) => AppointmentScreen(),
          '/contact': (context) => ContactScreen(),
          '/home': (context) => HomeScreen(),
          '/admin': (context) => AdminScreen(),
          '/psikolog': (context) => PsikologScreen(),
          '/asistan': (context) => AsistanScreen(),
          '/musteri': (context) => MusteriScreen(),
          '/oyun': (context) => GameScreen(),
          '/manageUsers': (context) => ManageUsersScreen(),
          '/admin_randevu_manage': (context) => AdminRandevuManageScreen(),
          '/role-application': (context) => RoleApplicationScreen(
              userId:
                  ''), // User ID'nin doğru bir şekilde yönlendirilmesi gerekecek
          '/dashboard': (context) =>
              DashboardScreen(userId: ''), // User ID burada da yönlendirilecek
        },
        onUnknownRoute: (settings) {
          return MaterialPageRoute(builder: (context) => UnknownScreen());
        },
      ),
    );
  }
}
