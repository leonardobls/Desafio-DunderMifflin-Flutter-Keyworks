import 'dart:io';

import 'package:dunder_mifflin/components/bottom_bar.dart';
import 'package:dunder_mifflin/components/loading_global.dart';
import 'package:dunder_mifflin/components/solicitation_bottomsheet.dart';
import 'package:dunder_mifflin/config/app_styles.dart';
import 'package:dunder_mifflin/data/blocs/home_bloc.dart';
import 'package:dunder_mifflin/data/blocs/home_event.dart';
import 'package:dunder_mifflin/data/blocs/home_state.dart';
import 'package:dunder_mifflin/data/models/product_model.dart';
import 'package:dunder_mifflin/pages/menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  const Home({
    super.key,
  });
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late final HomeBloc _homeBloc;

  @override
  void initState() {
    super.initState();
    _homeBloc = HomeBloc();
    _homeBloc.inputHome.add(GetHome(products: []));
    initialization();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<HomeState>(
        stream: _homeBloc.outputHome,
        builder: (context, state) {
          List<Product>? products;
          if (state.data != null) {
            final productState = state.data;
            products = productState!.products;
          }

          if (state.data is HomeLoadingState) {
            return const LoadingGlobal();
          } else if (state.data is HomeLoadedState) {
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
                          const begin = Offset(-1.0, 0.0);
                          const end = Offset.zero;
                          const curve = Curves.easeInOut;

                          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                          var offsetAnimation = animation.drive(tween);

                          return SlideTransition(
                            position: offsetAnimation,
                            child: child,
                          );
                        },
                        transitionDuration: const Duration(milliseconds: 300),
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
                          height: 200,
                          child: ListView.separated(
                            itemCount: products?.length ?? 0,
                            scrollDirection: Axis.horizontal,
                            separatorBuilder: (context, index) => const SizedBox(width: 10),
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            itemBuilder: (BuildContext context, int index) {
                              final product = products?[index];

                              return Container(
                                width: 160,
                                color: const Color(0xFFFEFBFF),
                                child: IntrinsicHeight(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Stack(
                                          children: [
                                            Image.file(
                                              File(product!.file.imagem),
                                              width: double.infinity,
                                              height: 120,
                                              fit: BoxFit.fill,
                                            ),
                                            Positioned(
                                              bottom: 5,
                                              right: 5,
                                              child: Opacity(
                                                opacity: product.filesQuantity > 2 ? 1 : 0,
                                                child: Container(
                                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 5),
                                                  decoration: const BoxDecoration(
                                                    color: Color(0xFFABABAF),
                                                    borderRadius: BorderRadius.all(
                                                      Radius.circular(200),
                                                    ),
                                                  ),
                                                  child: Text(
                                                    "+${product.filesQuantity.toString()} imagens",
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      height: 1.2,
                                                    ),
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                        child: Text(
                                          product.nome,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          padding: const EdgeInsets.all(8),
                                          width: double.infinity,
                                          child: Align(
                                            alignment: Alignment.bottomRight,
                                            child: Text(
                                              NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$').format(product.precoAtual),
                                              style: const TextStyle(
                                                fontSize: 22,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: "Roboto",
                                                color: AppStyles.secondaryColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          )),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 20,
                          right: 20,
                          top: 40,
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
          } else {
            return const Center(
              child: Text("Error"),
            );
          }
        });
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
