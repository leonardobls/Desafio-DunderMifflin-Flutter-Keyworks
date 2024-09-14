import 'package:dunder_mifflin/config/app_styles.dart';
import 'package:dunder_mifflin/pages/home.dart';
import 'package:dunder_mifflin/pages/notifications.dart';
import 'package:dunder_mifflin/pages/products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({
    super.key,
  });

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 87,
        width: double.infinity,
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.black26),
          ),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      settings: const RouteSettings(name: "home"),
                      pageBuilder: (context, animation1, animation2) => const Home(),
                      transitionDuration: Duration.zero,
                      reverseTransitionDuration: Duration.zero,
                    ),
                  );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                      decoration: BoxDecoration(
                        color: ModalRoute.of(context)!.settings.name == "home" ? AppStyles.primaryColor : const Color.fromRGBO(0, 0, 0, 0),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(200),
                        ),
                      ),
                      child: SvgPicture.asset(
                        ModalRoute.of(context)!.settings.name == "home" ? "assets/icons/home-active.svg" : "assets/icons/home.svg",
                      ),
                    ),
                    const Text(
                      "Tela Inicial",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      settings: const RouteSettings(name: "products"),
                      pageBuilder: (context, animation1, animation2) => const Products(),
                      transitionDuration: Duration.zero,
                      reverseTransitionDuration: Duration.zero,
                    ),
                  );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                      decoration: BoxDecoration(
                        color: ModalRoute.of(context)!.settings.name == "products" ? AppStyles.primaryColor : const Color.fromRGBO(0, 0, 0, 0),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(200),
                        ),
                      ),
                      child: SvgPicture.asset(ModalRoute.of(context)?.settings.name == "products" ? "assets/icons/products-active.svg" : "assets/icons/products.svg"),
                    ),
                    const Text(
                      "Produtos",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      settings: const RouteSettings(name: "notifications"),
                      pageBuilder: (context, animation1, animation2) => const Notifications(),
                      transitionDuration: Duration.zero,
                      reverseTransitionDuration: Duration.zero,
                    ),
                  );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                      decoration: BoxDecoration(
                        color: ModalRoute.of(context)!.settings.name == "notifications" ? AppStyles.primaryColor : const Color.fromRGBO(0, 0, 0, 0),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(200),
                        ),
                      ),
                      child: SvgPicture.asset(
                        ModalRoute.of(context)?.settings.name == "notifications" ? "assets/icons/notifications-active.svg" : "assets/icons/notifications.svg",
                      ),
                    ),
                    const Text(
                      "Notificações",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
