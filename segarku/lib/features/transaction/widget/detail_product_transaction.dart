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
        "name": "Bayam",
        "size": "500 gr/pack",
        "price": "Rp. 8.000",
        "image": SImages.bayam
      },
      {
        "name": "Semangka",
        "size": "800gr-1kg/pack",
        "price": "Rp. 15.000",
        "image": SImages.semangka
      },
      {
        "name": "Tomat",
        "size": "300-500 gr/pack",
        "price": "Rp. 5.000",
        "image": SImages.tomat
      },
      {
        "name": "Brokoli",
        "size": "300-500 gr/pack",
        "price": "Rp. 25.000",
        "image": SImages.brokoli
      },
    ];

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: darkMode ? SColors.pureBlack : Colors.white,
            borderRadius: BorderRadius.circular(SSizes.borderRadiusmd2),
          ),
          padding: const EdgeInsets.all(SSizes.defaultMargin),
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
                    Container(
                      height: 80.0, // Tinggi yang sama dengan gambar
                      alignment: Alignment.bottomRight,
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
