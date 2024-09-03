import 'dart:async';
import 'dart:io';

import 'package:dunder_mifflin/components/bottom_bar.dart';
import 'package:dunder_mifflin/components/loading_global.dart';
import 'package:dunder_mifflin/config/app_styles.dart';
import 'package:dunder_mifflin/data/blocs/product_bloc.dart';
import 'package:dunder_mifflin/data/blocs/product_event.dart';
import 'package:dunder_mifflin/data/blocs/product_state.dart';
import 'package:dunder_mifflin/data/models/product_model.dart';
import 'package:dunder_mifflin/pages/menu.dart';
import 'package:dunder_mifflin/pages/profile.dart';
import 'package:flutter/material.dart';

class Products extends StatefulWidget {
  const Products({
    super.key,
  });
  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  late final ProductBloc _productBloc;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _productBloc = ProductBloc();
    _productBloc.inputProduct.add(GetProducts(page: 1, products: [], searchTerm: ""));
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
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  settings: const RouteSettings(name: "profile"),
                  pageBuilder: (context, animation, secondaryAnimation) => const Profile(),
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
      body: StreamBuilder<ProductState>(
        stream: _productBloc.outputProduct,
        builder: (context, state) {
          List<Product>? products;
          if (state.data != null) {
            final productState = state.data;
            products = productState!.products;
          }
          return SafeArea(
            child: SingleChildScrollView(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Form(
                        key: _formKey,
                        child: TextFormField(
                          controller: _searchController,
                          onChanged: _onSearchChanged,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xFFFEFBFF),
                            hintText: 'Pesquisar',
                            prefixIcon: const Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(200.0),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      if (state.data is ProductLoadingState) ...[
                        GridView.count(
                          physics: const ScrollPhysics(),
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 0.7,
                          shrinkWrap: true,
                          children: [
                            IntrinsicHeight(
                              child: Container(
                                color: const Color(0xFFE3E2E6),
                                width: double.infinity,
                                height: double.infinity,
                              ),
                            ),
                            IntrinsicHeight(
                              child: Container(
                                color: const Color(0xFFE3E2E6),
                                width: double.infinity,
                                height: double.infinity,
                              ),
                            ),
                            IntrinsicHeight(
                              child: Container(
                                color: const Color(0xFFE3E2E6),
                                width: double.infinity,
                                height: double.infinity,
                              ),
                            ),
                            IntrinsicHeight(
                              child: Container(
                                color: const Color(0xFFE3E2E6),
                                width: double.infinity,
                                height: double.infinity,
                              ),
                            ),
                            IntrinsicHeight(
                              child: Container(
                                color: const Color(0xFFE3E2E6),
                                width: double.infinity,
                                height: double.infinity,
                              ),
                            ),
                            IntrinsicHeight(
                              child: Container(
                                color: const Color(0xFFE3E2E6),
                                width: double.infinity,
                                height: double.infinity,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                      if (state.data is ProductLoadedState || state.data is ProductLoadedAllState) ...[
                        GridView.count(
                          physics: const ScrollPhysics(),
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 0.7,
                          shrinkWrap: true,
                          children: products!.asMap().entries.map((product) {
                            return IntrinsicHeight(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Image.file(
                                      File(product.value.file.imagem),
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      product.value.nome,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Text(
                                      product.value.precoAtual.toString(),
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 50),
                        if (state.data is! ProductLoadedAllState) ...[
                          InkWell(
                            onTap: () {
                              if (state.data != null) {
                                _productBloc.inputProduct.add(GetProducts(page: state.data!.page, products: products!, searchTerm: _searchController.text));
                              }
                            },
                            child: Container(
                              decoration: const BoxDecoration(
                                color: AppStyles.primaryColor,
                                borderRadius: BorderRadius.all(Radius.circular(200.0)),
                              ),
                              child: const Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 15),
                                  child: Text(
                                    "Load More",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 50),
                        ],
                      ],
                    ],
                  ),
                ),
              ),
            ),
          );
          // else {
          //   return const Center(
          //     child: Text("Error"),
          //   );
          // }
        },
      ),
    );
  }

  void _onSearchChanged(String query) {
    // Cancela o temporizador anterior, se houver
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    // Cria um novo temporizador
    _debounce = Timer(const Duration(seconds: 3), () {
      // Submete o formulário após 3 segundos sem digitar
      if (_formKey.currentState?.validate() ?? false) {
        _formKey.currentState?.save();
        _productBloc.inputProduct.add(GetProducts(products: [], page: 1, searchTerm: _searchController.text));
      }
    });
  }

  void _submitForm() {
    // Ação de submissão do formulário
    print('Formulário submetido');
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }
}
