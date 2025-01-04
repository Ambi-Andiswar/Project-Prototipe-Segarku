import 'package:flutter/material.dart';
import 'package:segarku/features/carts/widget/cart_product.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return const Scaffold(
      body: Column(
        children: [
          // Konten di tengah-tengah layar
          Expanded(
            child: Center(
              child: CartsProductScreen(), // Widget keranjang produk
            ),
          ),
          
        ],
      ),
    );
  }
}
