import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dunder_mifflin/components/bottom_bar.dart';
import 'package:dunder_mifflin/config/app_styles.dart';
import 'package:dunder_mifflin/data/models/product_model.dart';
import 'package:dunder_mifflin/pages/menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:path/path.dart';

class Home extends StatefulWidget {
  const Home({
    super.key,
  });
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
  }

  List<Product> mockProdutos = [
    Product(
      name: "Papel para Sublimação LIVE A4",
      price: "500,00",
      images: [
        "assets/images/product-1.png",
        "assets/images/product-2.png",
      ],
    ),
    Product(
      name: "Papel para Sublimação LIVE A4",
      price: "12,00",
      images: [
        "assets/images/product-1.png",
        "assets/images/product-2.png",
      ],
    ),
    Product(
      name: "Produto 3",
      price: "500,00",
      images: [
        "assets/images/product-1.png",
        "assets/images/product-2.png",
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    print("Route: ${ModalRoute.of(context)!.settings.name}");
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
        toolbarHeight: 70,
        backgroundColor: Colors.white,
        title: const Padding(
          padding: EdgeInsets.only(right: 65),
          child: Center(
            child: Text("Tela Inicial"),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: const BottomBar(),
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(
                  left: 10,
                  bottom: 20,
                ),
                child: Text(
                  "Produtos",
                  style: TextStyle(
                    fontFamily: "Roboto",
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppStyles.secondaryColor,
                  ),
                ),
              ),
              SizedBox(
                height: 250,
                child: ListView.separated(
                  itemCount: mockProdutos.length,
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      width: 160,
                      child: Column(
                        children: [
                          Image.asset(
                            mockProdutos[index].images!.first,
                            width: double.infinity,
                            height: 160,
                            fit: BoxFit.cover,
                          ),
                          Text(
                            mockProdutos[index].name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontFamily: "Roboto",
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              mockProdutos[index].price,
                              style: const TextStyle(
                                fontFamily: "Roboto",
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                                color: AppStyles.secondaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 20,
                ),
                child: InkWell(
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: AppStyles.primaryColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(200),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset("assets/icons/headphone.svg"),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text(
                              "Nova Solicitação de Atendimento",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
