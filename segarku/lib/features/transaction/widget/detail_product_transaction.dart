import 'package:flutter/material.dart';
import 'package:segarku/utils/constants/colors.dart';
import 'package:segarku/utils/constants/image_strings.dart';
import 'package:segarku/utils/constants/sizes.dart';
import 'package:segarku/utils/helpers/helper_functions.dart';
import 'package:segarku/utils/theme/custom_themes/text_theme.dart';

class DetailProductTransaction extends StatelessWidget {
  const DetailProductTransaction({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = SHelperFunctions.isDarkMode(context);

    // Data produk contoh yang telah di-checkout
    final List<Map<String, String>> checkedOutProducts = [
      {
        "name": "Brokoli",
        "size": "300-500 gr/pack",
        "price": "Rp. 40.000",
        "image": SImages.brokoli
      },
      {
        "name": "Semangka",
        "size": "1 kg",
        "price": "Rp. 50.000",
        "image": SImages.semangka
      },
      {
        "name": "Rempah India",
        "size": "1 Ton",
        "price": "Rp. 2.500.000",
        "image": SImages.sayurCategory
      },
      {
        "name": "Rempah India",
        "size": "1 Ton",
        "price": "Rp. 2.500.000",
        "image": SImages.sayurCategory
      },
      {
        "name": "Rempah India",
        "size": "1 Ton",
        "price": "Rp. 2.500.000",
        "image": SImages.sayurCategory
      },
    ];

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: darkMode ? SColors.pureBlack : Colors.white,
            borderRadius: BorderRadius.circular(SSizes.borderRadiusmd2),
          ),
          padding: const EdgeInsets.all(SSizes.defaultMargin), // Tetap gunakan padding
          child: Column(
            children: checkedOutProducts.map((product) {
              final isLast = product == checkedOutProducts.last;
              return Padding(
                padding: EdgeInsets.only(
                  bottom: isLast ? 0 : SSizes.lg,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(SSizes.borderRadiussm),
                      child: Image.asset(
                        product["image"]!,
                        width: 80.0,
                        height: 80.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: SSizes.sm2),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product["name"]!,
                            style: darkMode
                                ? STextTheme.titleBaseBlackDark
                                : STextTheme.titleBaseBlackLight,
                          ),
                          Text(
                            product["size"]!,
                            style: darkMode
                                ? STextTheme.bodySmRegularDark
                                : STextTheme.bodySmRegularLight,
                          ),
                          const SizedBox(height: SSizes.sm),
                          Text(
                            product["price"]!,
                            style: STextTheme.titleBaseBoldLight.copyWith(
                              color: SColors.green500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft, // Posisikan teks di kiri bawah
                      child: Text(
                        "1 Pack",
                        style: darkMode
                            ? STextTheme.bodyCaptionRegularDark
                            : STextTheme.bodyCaptionRegularLight,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
