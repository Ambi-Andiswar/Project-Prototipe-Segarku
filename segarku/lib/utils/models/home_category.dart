import 'package:flutter/material.dart';
import 'package:segarku/features/shop/products/list_product.dart';
import 'package:segarku/utils/constants/image_strings.dart';
import 'package:segarku/utils/constants/sizes.dart';
import 'package:segarku/utils/theme/custom_themes/text_theme.dart';
import 'package:segarku/utils/helpers/helper_functions.dart';

class SHomeCategories extends StatelessWidget {
  const SHomeCategories({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = SHelperFunctions.isDarkMode(context);

    // Data kategori contoh
    final List<Map<String, String>> categories = [
      {"name": "Sayuran", "image": SImages.sayurCategory},
      {"name": "Buah", "image": SImages.buahCategory},
      {"name": "Masak", "image": SImages.masakCategory},
      {"name": "Rempah", "image": SImages.herbalCategory},
      {"name": "Dapurku", "image": SImages.dapurCategory},
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal, // Mengatur scroll secara horizontal
      child: Row(
        children: List.generate(
          categories.length, // Jumlah kategori berdasarkan data
          (index) => Padding(
            padding: const EdgeInsets.only(right: 10), // Spasi antar kategori
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ListProductScreen(),
                  ),
                );
              },
              child: Container(
                width: 60, // Atur lebar setiap kategori
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(SSizes.borderRadiusmd2),
                  color: Colors.transparent,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: SSizes.sm),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Gambar kategori
                      ClipRRect(
                        borderRadius: BorderRadius.circular(SSizes.borderRadiusmd),
                        child: Image.asset(
                          categories[index]["image"]!, // Gambar sesuai data
                          fit: BoxFit.cover,
                          height: 48,
                          width: double.infinity,
                        ),
                      ),
                      const SizedBox(height: SSizes.sm2),
                      // Nama kategori
                      Text(
                        categories[index]["name"]!, // Nama sesuai data
                        textAlign: TextAlign.center,
                        style: darkMode
                            ? STextTheme.titleCaptionBoldDark
                            : STextTheme.titleCaptionBoldLight,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
