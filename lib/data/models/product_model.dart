class ProductResponse {
  final int totalCount;
  final List<Product> items;

  ProductResponse({
    required this.totalCount,
    required this.items,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    var resultJson = json['result'] as Map<String, dynamic>;
    var itemsJson = resultJson['items'] as List;
    List<Product> productsList = itemsJson.map((itemJson) => Product.fromJson(itemJson)).toList();

    return ProductResponse(
      totalCount: resultJson['totalCount'],
      items: productsList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'result': {
        'totalCount': totalCount,
        'items': items.map((item) => item.toJson()).toList(),
      }
    };
  }
}

class Product {
  final String nome;
  final String descricao;
  final String descricaoAdicional;
  final bool situacao;
  final int categoriaId;
  final int subcategoriaId;
  final String categoriaNome;
  final String subcategoriaNome;
  final int filesQuantity;
  final ProductFile file;
  final double precoAtual;
  final int id;

  Product({
    required this.nome,
    required this.descricao,
    required this.descricaoAdicional,
    required this.situacao,
    required this.categoriaId,
    required this.subcategoriaId,
    required this.categoriaNome,
    required this.subcategoriaNome,
    required this.filesQuantity,
    required this.file,
    required this.precoAtual,
    required this.id,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      nome: json['nome'],
      descricao: json['descricao'],
      descricaoAdicional: json['descricaoAdicional'],
      situacao: json['situacao'],
      categoriaId: json['categoriaId'],
      subcategoriaId: json['subcategoriaId'],
      categoriaNome: json['categoriaNome'],
      subcategoriaNome: json['subcategoriaNome'],
      filesQuantity: json['filesQuantity'],
      file: ProductFile.fromJson(json['file']),
      precoAtual: json['precoAtual'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'descricao': descricao,
      'descricaoAdicional': descricaoAdicional,
      'situacao': situacao,
      'categoriaId': categoriaId,
      'subcategoriaId': subcategoriaId,
      'categoriaNome': categoriaNome,
      'subcategoriaNome': subcategoriaNome,
      'filesQuantity': filesQuantity,
      'file': file.toJson(),
      'precoAtual': precoAtual,
      'id': id,
    };
  }
}

class ProductFile {
  final int id;
  final int produtoId;
  final String nome;
  String imagem;

  ProductFile({
    required this.id,
    required this.produtoId,
    required this.nome,
    required this.imagem,
  });

  factory ProductFile.fromJson(Map<String, dynamic> json) {
    return ProductFile(
      id: json['id'],
      produtoId: json['produtoId'],
      nome: json['nome'],
      imagem: json['imagem'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'produtoId': produtoId,
      'nome': nome,
      'imagem': imagem,
    };
  }
}
