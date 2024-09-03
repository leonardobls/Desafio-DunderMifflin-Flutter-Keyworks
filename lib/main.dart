import 'package:dunder_mifflin/data/blocs/login_bloc.dart';
import 'package:dunder_mifflin/pages/home.dart';
import 'package:dunder_mifflin/pages/login.dart';
import 'package:dunder_mifflin/pages/menu.dart';
import 'package:dunder_mifflin/pages/notifications.dart';
import 'package:dunder_mifflin/pages/products.dart';
import 'package:dunder_mifflin/pages/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  final bool loggedIn = await isUserLoggedIn();
  runApp(MainApp(
    loggedIn: loggedIn,
  ));
}

Future<bool> isUserLoggedIn() async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('auth_token');
  return token != null;
}

class MainApp extends StatelessWidget {
  final bool loggedIn;
  const MainApp({super.key, required this.loggedIn});

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
      initialRoute: loggedIn ? 'home' : '/',
    );
  }
}
