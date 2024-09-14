import 'dart:async';
import 'package:dunder_mifflin/data/blocs/product_event.dart';
import 'package:dunder_mifflin/data/blocs/product_state.dart';
import 'package:dunder_mifflin/data/models/product_model.dart';
import 'package:dunder_mifflin/data/repositories/product_repository.dart';

class ProductBloc {
  final _repository = ProductRepository();

  final StreamController<ProductEvent> _inputProductController = StreamController<ProductEvent>();

  final StreamController<ProductState> _outputProductController = StreamController<ProductState>();

  Sink<ProductEvent> get inputProduct => _inputProductController.sink;
  Stream<ProductState> get outputProduct => _outputProductController.stream;

  ProductBloc() {
    _inputProductController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(ProductEvent event) async {
    _outputProductController.add(ProductLoadingState());
    List<Product> products = [];

    if (event is GetProducts) {
      try {
        final newProducts = await _repository.getProducts(event.page, event.searchTerm, null);
        products = event.products;
        products.addAll(newProducts);

        final nextPage = event.page + 1;

        if (newProducts.isNotEmpty) {
          _outputProductController.add(ProductLoadedState(products: products, page: nextPage));
        } else {
          _outputProductController.add(ProductLoadedAllState(products: products, page: nextPage));
        }
      } catch (e) {
        final Exception exception;
        exception = Exception('Unknown error occurred: $e');
        _outputProductController.add(ProductErrorState(exception: exception));
      }
    }
  }
}
