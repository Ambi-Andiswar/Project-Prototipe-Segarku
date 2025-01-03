import 'package:flutter/material.dart';
import 'package:segarku/utils/constants/icons.dart';
import 'package:segarku/utils/constants/image_strings.dart';
import 'package:segarku/utils/constants/sizes.dart';
import 'package:segarku/utils/models/product_horizontal.dart';
import 'package:segarku/utils/theme/custom_themes/text_theme.dart';
import '../../../../utils/constants/colors.dart';
import 'package:segarku/utils/helpers/helper_functions.dart';

class SProductV extends StatelessWidget {
  const SProductV({super.key});

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
      itemCount: 8, // Jumlah produk (dapat diganti dinamis sesuai data)
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount, // Jumlah kolom responsif
        crossAxisSpacing: 16, // Spasi horizontal antar produk
        mainAxisSpacing: 16, // Spasi vertikal antar produk
        childAspectRatio: 0.75, // Perbandingan lebar dan tinggi
      ),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            // Navigasi ke halaman DesProductScreen
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: darkMode ? SColors.green50 : SColors.softBlack50,
              ),
              borderRadius: BorderRadius.circular(SSizes.borderRadiusmd2),
              color: darkMode ? SColors.slateBlack : SColors.pureWhite,
            ),
            child: Padding(
              padding: const EdgeInsets.all(SSizes.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Gambar produk
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(SSizes.borderRadiusmd),
                      child: Image.asset(
                        SImages.brokoli, // Ganti dengan URL gambar produk
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: SSizes.sm2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Nama produk
                        Text(
                          'Brokoli', // Ganti sesuai data
                          style: darkMode
                              ? STextTheme.titleBaseBoldDark
                              : STextTheme.titleBaseBoldLight,
                        ),
                        // Ukuran Produk
                        Row(
                          children: [
                            Text(
                              '300-500', // Ganti sesuai data
                              style: darkMode
                                  ? STextTheme.bodyCaptionRegularDark
                                  : STextTheme.bodyCaptionRegularLight,
                            ),
                            Text(
                              'gr/pack', // Ganti sesuai data
                              style: darkMode
                                  ? STextTheme.bodySmRegularDark
                                  : STextTheme.bodySmRegularLight,
                            ),
                          ],
                        ),
                        const SizedBox(height: SSizes.xs),
                        // Harga Produk
                        Row(
                          children: [
                            Text(
                              'Rp 25.000', // Ganti sesuai data
                              style: darkMode
                                  ? STextTheme.titleBaseBlackDark
                                  : STextTheme.titleBaseBlackLight,
                            ),
                            const Spacer(),
                            Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                color: darkMode
                                    ? SColors.pureBlack
                                    : SColors.green50,
                                borderRadius: BorderRadius.circular(
                                    SSizes.borderRadiussm),
                              ),
                              child: IconButton(
                                onPressed: () {
                                  showModalBottomSheet(
                                    context: context,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(16)),
                                    ),
                                    builder: (context) {
                                      return const AddToCartPopup(
                                          price: 25000);
                                    },
                                  );
                                },
                                icon: const Icon(
                                  SIcons.add,
                                  color: SColors.primary,
                                  size: 16,
                                ),
                                padding: EdgeInsets.zero,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
