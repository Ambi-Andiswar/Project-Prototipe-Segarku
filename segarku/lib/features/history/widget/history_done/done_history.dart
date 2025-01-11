import 'package:flutter/material.dart';
import 'package:segarku/features/history/widget/no_history.dart';
import 'package:segarku/features/history/widget/product_history.dart';
import 'package:segarku/utils/constants/image_strings.dart';
import 'package:segarku/utils/constants/sizes.dart';
import 'package:segarku/utils/constants/text_strings.dart';
import 'package:segarku/utils/helpers/helper_functions.dart';
import 'package:segarku/utils/models/product_horizontal.dart';
import 'package:segarku/utils/theme/custom_themes/text_theme.dart';

class DoneHistory extends StatelessWidget {
  const DoneHistory({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = SHelperFunctions.isDarkMode(context);

    // Data untuk kontainer produk pertama
    final List<Map<String, String>> firstContainerProducts = [

    ];

    // Data untuk kontainer produk kedua
    final List<Map<String, String>> secondContainerProducts = [
      {
        "name": "Tomat",
        "size": "1kg/pack",
        "price": "Rp. 10.000",
        "image": SImages.tomat,
        "date": "8 Jan 2025",
      },
      {
        "name": "Wortel",
        "size": "1kg/pack",
        "price": "Rp. 12.000",
        "image": SImages.wortel,
        "date": "7 Jan 2025",
      },
    ];

    // Hitung total item dan harga untuk setiap kontainer
    final int firstTotalItems = firstContainerProducts.length;
    const int firstTotalPrice = 8000 + 15000; // Contoh hitung manual
    final int secondTotalItems = secondContainerProducts.length;
    const int secondTotalPrice = 10000 + 12000; // Contoh hitung manual

    // Logika untuk memeriksa apakah semua data produk kosong
    final bool allProductsEmpty =
        firstContainerProducts.isEmpty && secondContainerProducts.isEmpty;

    return Scaffold(
      body: allProductsEmpty
          ? const NoHistoryScreen() // Jika semua produk kosong
          : SingleChildScrollView(
              child: Column(
                children: [
                  // Kontainer Produk Pertama
                  if (firstContainerProducts.isNotEmpty)
                    ProductHistory(
                      products: firstContainerProducts,
                      darkMode: darkMode,
                      totalItems: firstTotalItems,
                      totalPrice: firstTotalPrice,
                    ),

                  const SizedBox(height: 16), // Jarak antar kontainer

                  // Kontainer Produk Kedua
                  if (secondContainerProducts.isNotEmpty)
                    ProductHistory(
                      products: secondContainerProducts,
                      darkMode: darkMode,
                      totalItems: secondTotalItems,
                      totalPrice: secondTotalPrice,
                    ),

                  // Konten tambahan di bawah kontainer produk
                  const SizedBox(height: SSizes.lg2),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: SSizes.defaultMargin,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          STexts.youLink,
                          style: darkMode
                              ? STextTheme.titleBaseBoldDark
                              : STextTheme.titleBaseBoldLight,
                        ),
                        const SizedBox(height: SSizes.md),
                        const SProductH(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
