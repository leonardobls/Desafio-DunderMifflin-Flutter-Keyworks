import 'dart:convert';
import 'dart:io';
import 'package:dunder_mifflin/config/app_config.dart';
import 'package:dunder_mifflin/data/models/product_model.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductRepository {
  Future<List<Product>> getProducts(int? page, String? searchTerm, int? limit) async {
    Uri url;
    if (limit != null) {
      url = Uri.parse("${AppConfig.url}api/services/app/Produto/GetAll?MaxResultCount=$limit");
    } else {
      int skip = (page! - 1) * 6;

      if (searchTerm != null && searchTerm.isNotEmpty) {
        url = Uri.parse("${AppConfig.url}api/services/app/Produto/GetAll?SearchText=$searchTerm&SkipCount=$skip&MaxResultCount=6");
      } else {
        url = Uri.parse("${AppConfig.url}api/services/app/Produto/GetAll?SkipCount=$skip&MaxResultCount=6");
      }
    }

    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('auth_token') ?? "";

    try {
      var response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        ProductResponse productResponse = ProductResponse.fromJson(body);

        for (var product in productResponse.items) {
          if (product.file.imagem.isNotEmpty) {
            product.file.imagem = await _saveImage(product.file.imagem, product.file.nome);
          }
        }

        return productResponse.items;
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      return Future.error('Error: $e');
    }
  }

  Future<String> _saveImage(String base64Image, String fileName) async {
    final decodedBytes = base64Decode(base64Image);
    final directory = await getApplicationDocumentsDirectory();
    final filePath = join(directory.path, fileName);
    final file = File(filePath);
    await file.writeAsBytes(decodedBytes);
    return filePath;
  }
}
