import 'package:flutter/material.dart';
import 'package:segarku/features/shop/products/list_product.dart';
import 'package:segarku/utils/constants/image_strings.dart';
import 'package:segarku/utils/constants/sizes.dart';
import 'package:segarku/utils/theme/custom_themes/text_theme.dart';
import '../../../../utils/constants/colors.dart';
import 'package:segarku/utils/helpers/helper_functions.dart';

class SCategory extends StatelessWidget {
  const SCategory({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = SHelperFunctions.isDarkMode(context);

    
    // Mendapatkan lebar layar
    final screenWidth = MediaQuery.of(context).size.width;

    // Menentukan jumlah kolom secara responsif
    int crossAxisCount = 2; // Default jumlah kolom
    if (screenWidth >= 600) {
      crossAxisCount = 3; // Jika lebar >= 600, gunakan 3 kolom
    }
    if (screenWidth >= 900) {
      crossAxisCount = 4; // Jika lebar >= 900, gunakan 4 kolom
    }

    return GridView.builder(
      shrinkWrap: true, // Agar GridView tidak scroll sendiri
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 5, // Jumlah kategori (dapat diganti dinamis sesuai data)
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount, // 2 kategori per baris
        crossAxisSpacing: 15, // Spasi horizontal antar kategori
        mainAxisSpacing: 15, // Spasi vertikal antar kategori
        childAspectRatio: 2.5, // Perbandingan lebar dan tinggi container kategori
      ),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () { // Navigasi ke halaman DesProductScreen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ListProductScreen(),
                ),
              );
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(SSizes.borderRadiusmd2),
              color: darkMode ? SColors.slateBlack : SColors.pureWhite,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Nama kategori
                        Text(
                          'Sayuran', // Nama kategori
                          style: darkMode
                              ? STextTheme.titleCaptionBoldDark
                              : STextTheme.titleCaptionBoldLight,
                        ),

                        // Jumlah produk dalam kategori
                        Text(
                          '7 products', // Jumlah produk
                          style: darkMode
                              ? STextTheme.bodyCaptionRegularDark
                              : STextTheme.bodyCaptionRegularLight,
                        ),
                      ],
                    ),
                  ),
                ),
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(100),
                    bottomLeft: Radius.circular(100),
                    topRight: Radius.circular(SSizes.borderRadiusmd2),
                    bottomRight: Radius.circular(SSizes.borderRadiusmd2),
                  ),
                  child: Image.asset(
                    SImages.sayurCategory, // Gambar kategori
                    fit: BoxFit.cover,
                    width: 72, // Ukuran gambar
                    height: double.infinity,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
