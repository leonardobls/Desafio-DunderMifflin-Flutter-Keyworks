import 'package:dunder_mifflin/data/models/product_model.dart';

abstract class HomeState {
  final List<Product> products;

  HomeState({required this.products});
}

class HomeInitialState extends HomeState {
  HomeInitialState() : super(products: []);
}

class HomeLoadingState extends HomeState {
  HomeLoadingState() : super(products: []);
}

class HomeLoadedState extends HomeState {
  HomeLoadedState({required super.products});
}

class HomeErrorState extends HomeState {
  final Exception exception;

  HomeErrorState({required this.exception}) : super(products: []);
}
