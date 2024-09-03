import 'package:dunder_mifflin/data/models/product_model.dart';

abstract class ProductEvent {}

class GetProducts extends ProductEvent {
  List<Product> products;
  int page;
  String searchTerm;

  GetProducts({required this.products, required this.page, required this.searchTerm});
}
