import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:psikolog_app/main.dart'; // main.dart dosyasının doğru yolunu kontrol edin
import 'package:psikolog_app/providers/user_role_provider.dart';
import 'package:psikolog_app/services/directus_service.dart';
import 'package:psikolog_app/screens/login_screen.dart'; // LoginScreen import edilmelidir

void main() {
  testWidgets('LoginScreen widget test', (WidgetTester tester) async {
    // Kullanıcı rolü sağlayıcıyı oluştur
    final userRoleProvider = UserRoleProvider();

    // Test widget'ını oluştur
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<UserRoleProvider>.value(
              value: userRoleProvider),
          Provider<DirectusService>(
            create: (_) =>
                DirectusService(), // DirectusService'yi sağlayıcı olarak ekle
          ),
        ],
        child: MaterialApp(
          home: LoginScreen(),
          routes: {
            '/register': (context) => Scaffold(body: Text('Register Screen')),
            '/admin': (context) => Scaffold(body: Text('Admin Screen')),
            '/psikolog': (context) => Scaffold(body: Text('Psikolog Screen')),
            '/asistan': (context) => Scaffold(body: Text('Asistan Screen')),
            '/musteri': (context) => Scaffold(body: Text('Müşteri Screen')),
          },
        ),
      ),
    );

    // Test senaryolarını ekleyin
    expect(find.text('E-Mail'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);

    // E-posta ve şifre alanlarını bulun
    final emailField = find.byType(TextField).first;
    final passwordField = find.byType(TextField).last;

    // Test verileri girin
    await tester.enterText(emailField, 'test@example.com');
    await tester.enterText(passwordField, 'password123');

    // Login butonuna tıklayın
    final loginButton = find.text('Login');
    await tester.tap(loginButton);
    await tester.pump();

    // Login ekranının yanıtını kontrol edin
    // Burada beklenen yönlendirmeyi kontrol edin
    expect(find.text('Invalid username or password'), findsOneWidget);
  });
}
