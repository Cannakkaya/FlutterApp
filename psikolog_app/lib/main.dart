import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/appointment_provider.dart';
import 'providers/user_role_provider.dart'; // UserRoleProvider import edilmelidir
import 'screens/home_screen.dart';
import 'screens/appointment_screen.dart';
import 'screens/contact_screen.dart'; // İletişim sayfası
import 'screens/login_screen.dart'; // Giriş sayfası
import 'screens/register_screen.dart'; // Kayıt sayfası
import 'screens/admin_screen.dart'; // Admin ekranı
import 'screens/psikolog_screen.dart'; // Psikolog ekranı
import 'screens/asistan_screen.dart'; // Asistan ekranı
import 'screens/musteri_screen.dart'; // Müşteri ekranı
import 'screens/manage_users_screen.dart'; // Kullanıcı yönetimi
import 'screens/game_screen.dart'; // Mini oyun ekranı
import 'screens/unknown_screen.dart'; // Bilinmeyen rotalar için ekran
import 'screens/admin_randevu_manage_screen.dart'; // Admin randevu yönetim ekranı

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
          '/admin_randevu_manage': (context) =>
              AdminRandevuManageScreen(), // Yeni rota
        },
        onGenerateRoute: (settings) {
          return null; // Bilinmeyen rotalar için null döner
        },
        onUnknownRoute: (settings) {
          return MaterialPageRoute(builder: (context) => UnknownScreen());
        },
      ),
    );
  }
}
