class Product {
  final String name;
  final String price;
  final List<String>? images;

  Product({
    required this.name,
    required this.price,
    this.images,
  });
}
