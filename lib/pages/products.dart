import 'package:dunder_mifflin/components/bottom_bar.dart';
import 'package:dunder_mifflin/config/app_styles.dart';
import 'package:dunder_mifflin/data/models/product_model.dart';
import 'package:dunder_mifflin/pages/menu.dart';
import 'package:dunder_mifflin/pages/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Products extends StatefulWidget {
  const Products({
    super.key,
  });
  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
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
            child: Text("Produtos"),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: const BottomBar(),
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: const Center(
            child: Text("Products Page"),
          ),
        ),
      ),
    );
  }
}
