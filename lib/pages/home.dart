import 'package:dunder_mifflin/components/bottom_bar.dart';
import 'package:dunder_mifflin/components/solicitation_bottomsheet.dart';
import 'package:dunder_mifflin/config/app_styles.dart';
import 'package:dunder_mifflin/data/models/product_model.dart';
import 'package:dunder_mifflin/pages/menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_svg/svg.dart';

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
    initialization();
  }

  List<Map<String, dynamic>> mockProdutos = [
    {
      'id': 1,
      'name': "Papel para Sublimação LIVE A4",
      'description': "Descrição do produto 1",
      'additionalDescription': "Descrição adicional do produto 1",
      'situation': true,
      'categoryId': 1,
      'subCategoryId': 1,
      'categoryName': "Categoria 1",
      'subCategoryName': "Subcategoria 1",
      'filesQuantity': 2,
      'currentPrice': 50000, // Representando 500,00 em centavos
      'price': "500,00",
      'images': [
        "assets/images/product-1.png",
        "assets/images/product-2.png",
      ],
    },
    {
      'id': 2,
      'name': "Papel para Sublimação LIVE A4",
      'description': "Descrição do produto 2",
      'additionalDescription': "Descrição adicional do produto 2",
      'situation': true,
      'categoryId': 1,
      'subCategoryId': 2,
      'categoryName': "Categoria 1",
      'subCategoryName': "Subcategoria 2",
      'filesQuantity': 2,
      'currentPrice': 1200, // Representando 12,00 em centavos
      'price': "12,00",
      'images': [
        "assets/images/product-1.png",
        "assets/images/product-2.png",
      ],
    },
    {
      'id': 3,
      'name': "Produto 3",
      'description': "Descrição do produto 3",
      'additionalDescription': "Descrição adicional do produto 3",
      'situation': true,
      'categoryId': 2,
      'subCategoryId': 1,
      'categoryName': "Categoria 2",
      'subCategoryName': "Subcategoria 1",
      'filesQuantity': 2,
      'currentPrice': 50000, // Representando 500,00 em centavos
      'price': "500,00",
      'images': [
        "assets/images/product-1.png",
        "assets/images/product-2.png",
      ],
    },
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
                pageBuilder: (context, animation, secondaryAnimation) => const Menu(),
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  const begin = Offset(-1.0, 0.0); // Início fora da tela à esquerda
                  const end = Offset.zero; // Final na posição original
                  const curve = Curves.easeInOut;

                  var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                  var offsetAnimation = animation.drive(tween);

                  return SlideTransition(
                    position: offsetAnimation,
                    child: child,
                  );
                },
                transitionDuration: const Duration(milliseconds: 300), // Duração da animação
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
                    separatorBuilder: (context, index) => const SizedBox(width: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemBuilder: (BuildContext context, int index) {
                      // Acesso aos dados a partir do mapa
                      final product = mockProdutos[index];
                      final imageUrl = product['images']?.first ?? ''; // Verifica se 'images' não é null e usa o primeiro item
                      final name = product['name'] ?? 'Nome do produto';
                      final price = product['price'] ?? 'Preço não disponível';

                      return SizedBox(
                        width: 160,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Exibe a imagem do produto
                            Image.asset(
                              imageUrl,
                              width: double.infinity,
                              height: 160,
                              fit: BoxFit.cover,
                            ),
                            // Exibe o nome do produto
                            Text(
                              name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontFamily: "Roboto",
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                            // Exibe o preço do produto
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                price,
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
                  )),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 20,
                ),
                child: InkWell(
                  onTap: () {
                    showModalBottomSheet<dynamic>(
                        isScrollControlled: true,
                        context: context,
                        backgroundColor: Colors.white,
                        builder: (BuildContext bc) {
                          return const Wrap(
                            children: <Widget>[SolicitationBottomsheet()],
                          );
                        });
                  },
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

  void initialization() async {
    print('ready in 3...');
    await Future.delayed(const Duration(seconds: 1));
    print('ready in 2...');
    await Future.delayed(const Duration(seconds: 1));
    print('ready in 1...');
    await Future.delayed(const Duration(seconds: 1));
    print('go!');
    FlutterNativeSplash.remove();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
