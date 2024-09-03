import 'package:dunder_mifflin/data/models/product_model.dart';

abstract class ProductState {
  final List<Product> products;
  final int page;

  ProductState({required this.products, required this.page});
}

class ProductInitialState extends ProductState {
  ProductInitialState() : super(products: [], page: 1);
}

class ProductLoadingState extends ProductState {
  ProductLoadingState() : super(products: [], page: 0);
}

class ProductLoadedState extends ProductState {
  ProductLoadedState({required super.products, required super.page});
}

class ProductLoadedAllState extends ProductState {
  ProductLoadedAllState({required super.products, required super.page});
}

class ProductErrorState extends ProductState {
  final Exception exception;

  ProductErrorState({required this.exception}) : super(products: [], page: 0);
}
