import 'package:flutter/material.dart';
import 'package:segarku/utils/constants/sizes.dart';
import 'package:segarku/utils/helpers/helper_functions.dart';
import 'package:segarku/utils/theme/custom_themes/text_theme.dart';

class AddToCartPopup extends StatelessWidget {
  final int price;
  final String name;

  const AddToCartPopup({
    super.key,
    required this.price,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    final dark = SHelperFunctions.isDarkMode(context);
    return Padding(
      padding: const EdgeInsets.all(SSizes.md),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Tambah ke Keranjang",
            style: dark
              ? STextTheme.titleBaseBoldDark
              : STextTheme.titleBaseBoldLight
          ),
          const SizedBox(height: SSizes.sm),
          Text(
            name, // Tampilkan nama produk
            style: STextTheme.titleBaseBoldDark,
          ),
          const SizedBox(height: SSizes.sm),
          Text(
            "Harga: Rp ${price.toString()}",
            style: STextTheme.bodyBaseRegularDark,
          ),
          const SizedBox(height: SSizes.md),
          ElevatedButton(
            onPressed: () {
              // Tambahkan logika untuk menambah ke keranjang
              Navigator.pop(context); // Tutup popup setelah menambah ke keranjang
            },
            child: const Text("Tambah"),
          ),
        ],
      ),
    );
  }
}
