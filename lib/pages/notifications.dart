import 'package:dunder_mifflin/components/bottom_bar.dart';
import 'package:dunder_mifflin/pages/menu.dart';
import 'package:dunder_mifflin/pages/profile.dart';
import 'package:flutter/material.dart';

class Notifications extends StatefulWidget {
  const Notifications({
    super.key,
  });
  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                settings: const RouteSettings(name: "menu"),
                pageBuilder: (context, animation, secondaryAnimation) =>
                    const Menu(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  const begin =
                      Offset(-1.0, 0.0); // Início fora da tela à esquerda
                  const end = Offset.zero; // Final na posição original
                  const curve = Curves.easeInOut;

                  var tween = Tween(begin: begin, end: end)
                      .chain(CurveTween(curve: curve));
                  var offsetAnimation = animation.drive(tween);

                  return SlideTransition(
                    position: offsetAnimation,
                    child: child,
                  );
                },
                transitionDuration:
                    const Duration(milliseconds: 300), // Duração da animação
              ),
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  settings: const RouteSettings(name: "profile"),
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      const Profile(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    const begin =
                        Offset(-1.0, 0.0); // Início fora da tela à esquerda
                    const end = Offset.zero; // Final na posição original
                    const curve = Curves.easeInOut;

                    var tween = Tween(begin: begin, end: end)
                        .chain(CurveTween(curve: curve));
                    var offsetAnimation = animation.drive(tween);

                    return SlideTransition(
                      position: offsetAnimation,
                      child: child,
                    );
                  },
                  transitionDuration:
                      const Duration(milliseconds: 300), // Duração da animação
                ),
              );
            },
          ),
        ],
        toolbarHeight: 70,
        backgroundColor: Colors.white,
        title: const Padding(
          padding: EdgeInsets.only(right: 10),
          child: Center(
            child: Text("Notificações"),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: const BottomBar(),
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: const Center(
            child: Text("Notifications Page"),
          ),
        ),
      ),
    );
  }
}
