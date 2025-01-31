import 'package:flutter/material.dart';
import 'package:segarku/features/carts/widget/cart_product.dart';
import 'package:segarku/utils/constants/colors.dart';
import 'package:segarku/utils/helpers/helper_functions.dart';
import 'package:segarku/utils/theme/custom_themes/text_theme.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = SHelperFunctions.isDarkMode(context);
    return Scaffold(
      body: Column(
        children: [
          // Kontainer di bagian atas
          Container(
            padding: const EdgeInsets.only(top: 70, bottom: 24),
            decoration: BoxDecoration(
              color: darkMode
                ? SColors.pureBlack
                : SColors.pureWhite,
              border: Border(
                bottom: BorderSide(
                  color: darkMode 
                    ? SColors.green50
                    : SColors.softBlack50,
                  width: 1.0,
                ),
              ),
            ),
            child: Center(
              child: Text(
                'Keranjang Saya',
                style: darkMode
                  ? STextTheme.titleBaseBoldDark
                  : STextTheme.titleBaseBoldLight
              ),
            ),
          ),

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
