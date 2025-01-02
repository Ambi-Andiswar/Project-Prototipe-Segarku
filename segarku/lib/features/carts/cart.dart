import 'package:flutter/material.dart';
import 'package:segarku/commons/widget/cart/no_carts.dart';

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
              child: NoTransactionScreen(), // Ganti dengan widget yang relevan
            ),
          ),
        ],
      ),
    );
  }
}
