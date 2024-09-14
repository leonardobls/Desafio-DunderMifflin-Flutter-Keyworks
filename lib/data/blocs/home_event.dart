import 'package:dunder_mifflin/data/models/product_model.dart';

abstract class HomeEvent {}

class GetHome extends HomeEvent {
  final List<Product> products;

  GetHome({required this.products});
}
