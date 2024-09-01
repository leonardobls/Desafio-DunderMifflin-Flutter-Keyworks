import 'package:dunder_mifflin/config/app_styles.dart';
import 'package:dunder_mifflin/pages/profile.dart';
import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  const Menu({
    super.key,
  });

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("Route: ${ModalRoute.of(context)!.settings.name}");

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 70,
        backgroundColor: Colors.white,
        title: const SizedBox(
          width: double.infinity,
          child: Text(
            "Menu",
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 8,
                      ),
                      decoration: const BoxDecoration(
                        color: Color(0xFFD8E2FF),
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(500),
                            ),
                            child: SizedBox(
                              width: 62,
                              height: 62,
                              child: Image.asset(
                                "assets/images/profile.png",
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Dwight Schrute",
                                style: TextStyle(
                                  fontFamily: "Roboto",
                                  color: AppStyles.secondaryColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 22,
                                  letterSpacing: -1,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "dwight.schrute@gmail.com",
                                style: TextStyle(
                                  fontFamily: "Roboto",
                                  color: AppStyles.secondaryColor,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  letterSpacing: -1,
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      settings:
                                          const RouteSettings(name: "profile"),
                                      pageBuilder:
                                          (context, animation1, animation2) =>
                                              const Profile(),
                                      transitionDuration: Duration.zero,
                                      reverseTransitionDuration: Duration.zero,
                                    ),
                                  );
                                },
                                child: const Icon(
                                  Icons.edit,
                                  color: AppStyles.secondaryColor,
                                  size: 32,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    const InkWell(
                      child: Row(
                        children: [
                          Icon(
                            Icons.settings,
                            color: AppStyles.primaryGrayColor,
                            size: 24,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Configurações",
                                style: TextStyle(
                                  letterSpacing: -0.6,
                                  color: AppStyles.primaryGrayColor,
                                  fontFamily: 'Roboto',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Configurações do aplicativo',
                                style: TextStyle(
                                  letterSpacing: -0.6,
                                  color: AppStyles.primaryGrayColor,
                                  fontFamily: 'Roboto',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    const InkWell(
                      child: Row(
                        children: [
                          Icon(
                            Icons.credit_card,
                            color: AppStyles.primaryGrayColor,
                            size: 24,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Formas de pagamento",
                                style: TextStyle(
                                  letterSpacing: -0.6,
                                  color: AppStyles.primaryGrayColor,
                                  fontFamily: 'Roboto',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Minhas formas de pagamento',
                                style: TextStyle(
                                  letterSpacing: -0.6,
                                  color: AppStyles.primaryGrayColor,
                                  fontFamily: 'Roboto',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    const InkWell(
                      child: Row(
                        children: [
                          Icon(
                            Icons.confirmation_number,
                            color: AppStyles.primaryGrayColor,
                            size: 24,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Cupons",
                                style: TextStyle(
                                  letterSpacing: -0.6,
                                  color: AppStyles.primaryGrayColor,
                                  fontFamily: 'Roboto',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Meus cupons de desconto',
                                style: TextStyle(
                                  letterSpacing: -0.6,
                                  color: AppStyles.primaryGrayColor,
                                  fontFamily: 'Roboto',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    const InkWell(
                      child: Row(
                        children: [
                          Icon(
                            Icons.favorite,
                            color: AppStyles.primaryGrayColor,
                            size: 24,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Favoritos",
                                style: TextStyle(
                                  letterSpacing: -0.6,
                                  color: AppStyles.primaryGrayColor,
                                  fontFamily: 'Roboto',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Meus produtos favoritos',
                                style: TextStyle(
                                  letterSpacing: -0.6,
                                  color: AppStyles.primaryGrayColor,
                                  fontFamily: 'Roboto',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    const InkWell(
                      child: Row(
                        children: [
                          Icon(
                            Icons.logout,
                            color: AppStyles.primaryGrayColor,
                            size: 24,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Sair da conta",
                                style: TextStyle(
                                  letterSpacing: -0.6,
                                  color: AppStyles.primaryGrayColor,
                                  fontFamily: 'Roboto',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Sair da minha conta',
                                style: TextStyle(
                                  letterSpacing: -0.6,
                                  color: AppStyles.primaryGrayColor,
                                  fontFamily: 'Roboto',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Positioned(
              bottom: 0,
              left: 15,
              child: Text(
                "Versão 1.1.0",
                style: TextStyle(
                  fontSize: 14,
                  color: AppStyles.primaryGrayColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
