import 'package:get/get.dart';
import 'package:segarku/features/shop/products/models/product.dart';

class CartController extends GetxController {
  // List produk dalam keranjang
  var cartProducts = <Product>[].obs;

  // Tambahkan produk ke keranjang
  void addToCart(Product product) {
    cartProducts.add(product);
  }

  // Hapus produk dari keranjang
  void removeFromCart(Product product) {
    cartProducts.remove(product);
  }
}
