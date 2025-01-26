import 'package:get/get.dart';
import 'package:segarku/features/shop/products/data/product.dart';
import 'package:segarku/service/api_product.dart';

class SearchControllers extends GetxController {
   var searchQuery = ''.obs;
  var searchResults = <SProduct>[].obs; // Pastikan diinisialisasi sebagai list kosong

  void searchProducts(String query) async {
    searchQuery.value = query;
    if (query.isEmpty) {
      searchResults.clear(); // Kosongkan hasil pencarian jika query kosong
      return;
    }

    try {
      final products = await ApiServiceProduct.fetchProducts();
      searchResults.value = products
          .where((product) =>
              product.nama.toLowerCase().contains(query.toLowerCase()))
          .toList();
    } catch (e) {
      print('Error fetching products: $e');
      searchResults.clear(); // Kosongkan hasil pencarian jika terjadi error
    }
  }
}