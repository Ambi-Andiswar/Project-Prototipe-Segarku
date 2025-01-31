import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:segarku/features/shop/products/data/product.dart';

class ApiServiceProduct {
  static const String apiUrl = 'https://www.admin-segarku.online/api/products';

  static Future<List<SProduct>> fetchProducts() async {
  final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return (data['data'] as List)
          .map((json) => SProduct.fromJson(json))
          .toList();
    } else {
      print('Error fetching products: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to load products');
    }
  }
}
