import 'package:flutter/material.dart';
import 'package:segarku/utils/constants/image_strings.dart';
import 'package:segarku/utils/constants/sizes.dart';
import 'package:segarku/utils/theme/custom_themes/text_theme.dart';
import 'package:segarku/utils/helpers/helper_functions.dart';

  class SHomeCategories extends StatelessWidget {
    const SHomeCategories({super.key});

    @override
    Widget build(BuildContext context) {
      final darkMode = SHelperFunctions.isDarkMode(context);

      return SingleChildScrollView(
        scrollDirection: Axis.horizontal, // Mengatur scroll secara horizontal
        child: Row(
          children: List.generate(
            5, // Jumlah produk
            (index) => Padding(
              padding: const EdgeInsets.only(right: 10), // Spasi antar produk
              child: GestureDetector(
                onTap: () {
                  // Aksi ketika produk ditekan
                },
                child: Container(
                  width: 60, // Atur lebar setiap produk
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(SSizes.borderRadiusmd2),
                    color: Colors.transparent
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: SSizes.sm),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Gambar produk
                        ClipRRect(
                          borderRadius: BorderRadius.circular(SSizes.borderRadiusmd),
                          child: Image.asset(
                            SImages.sayurCategory, // Ganti dengan URL gambar produk
                            fit: BoxFit.cover,
                            height: 48,
                            width: double.infinity,
                          ),
                        ),
                        const SizedBox(height: SSizes.sm2),
                        // Nama produk
                        Text(
                          'Sayuran', // Ganti sesuai data
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
