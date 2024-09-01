import 'package:dunder_mifflin/pages/home.dart';
import 'package:dunder_mifflin/pages/login.dart';
import 'package:dunder_mifflin/pages/menu.dart';
import 'package:dunder_mifflin/pages/notifications.dart';
import 'package:dunder_mifflin/pages/products.dart';
import 'package:dunder_mifflin/pages/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      color: Colors.white,
      routes: {
        '/': (context) => const Login(),
        'home': (context) => const Home(),
        'menu': (context) => const Menu(),
        'profile': (context) => const Profile(),
        'products': (context) => const Products(),
        'notifications': (context) => const Notifications(),
      },
      initialRoute: '/',
    );
  }
}
