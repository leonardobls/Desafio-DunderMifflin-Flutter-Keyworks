import 'dart:async';
import 'package:dunder_mifflin/data/blocs/home_event.dart';
import 'package:dunder_mifflin/data/blocs/home_state.dart';
import 'package:dunder_mifflin/data/models/product_model.dart';
import 'package:dunder_mifflin/data/repositories/product_repository.dart';

class HomeBloc {
  final _productRepository = ProductRepository();

  final StreamController<HomeEvent> _inputHomeController = StreamController<HomeEvent>();

  final StreamController<HomeState> _outputHomeController = StreamController<HomeState>();

  Sink<HomeEvent> get inputHome => _inputHomeController.sink;
  Stream<HomeState> get outputHome => _outputHomeController.stream;

  HomeBloc() {
    _inputHomeController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(HomeEvent event) async {
    _outputHomeController.add(HomeLoadingState());
    List<Product> products = [];

    if (event is GetHome) {
      try {
        products = await _productRepository.getProducts(null, null, 5);
        _outputHomeController.add(HomeLoadedState(products: products));
      } catch (e) {
        final Exception exception;
        exception = Exception('Unknown error occurred: $e');
        _outputHomeController.add(HomeErrorState(exception: exception));
      }
    }
  }
}
