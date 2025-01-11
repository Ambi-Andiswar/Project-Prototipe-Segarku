import 'package:flutter/material.dart';
import 'package:segarku/utils/constants/colors.dart';
import 'package:segarku/utils/constants/image_strings.dart';
import 'package:segarku/utils/constants/sizes.dart';
import 'package:segarku/utils/constants/text_strings.dart';
import 'package:segarku/utils/helpers/helper_functions.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:segarku/utils/theme/custom_themes/text_theme.dart';

class DetailProducthistory extends StatelessWidget {
  const DetailProducthistory({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = SHelperFunctions.isDarkMode(context);

    // Data produk contoh yang telah di-checkout
    final List<Map<String, String>> checkedOutProducts = [
      {
        "name": "Tomat",
        "size": "300-500 gr/pack",
        "price": "Rp. 5.000",
        "image": SImages.tomat
      },
      {
        "name": "Wortel",
        "size": "1kg/pack",
        "price": "Rp. 12.000",
        "image": SImages.wortel
      },
    ];

    return Container(
      margin: const EdgeInsets.only(
        left: SSizes.defaultMargin,
        top: SSizes.defaultMargin,
        right: SSizes.defaultMargin,
      ), // Padding luar kontainer
      padding: const EdgeInsets.all(SSizes.defaultMargin), // Padding dalam kontainer
      decoration: BoxDecoration(
        color: darkMode ? SColors.pureBlack : Colors.white, // Warna latar
        borderRadius: BorderRadius.circular(SSizes.borderRadiussm), // Sudut melengkung
        border: Border.all(color: darkMode
        ? SColors.green50
        : SColors.softBlack50)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Detail Produk
          Padding(
            padding: const EdgeInsets.only(bottom: SSizes.defaultMargin),
            child: Text(
              "Detail Produk",
              style: darkMode
                  ? STextTheme.titleBaseBoldDark
                  : STextTheme.titleBaseBoldLight,
            ),
          ),

          // List Produk
          Column(
            children: checkedOutProducts.map((product) {
              final isLast = product == checkedOutProducts.last;
              return Padding(
                padding: EdgeInsets.only(bottom: isLast ? 0 : SSizes.lg),
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

          const SizedBox(height: SSizes.md,),
          // Garis pembatas
          const Divider(color: SColors.softBlack50, thickness: 1),

          // Informasi Subtotal, PPN, Ongkir
          Padding(
            padding: const EdgeInsets.symmetric(vertical: SSizes.md),
            child: Column(
              children: [
                _buildPriceRow("Subtotal", "Rp. 17.000"),
                const SizedBox(height: SSizes.sm),
                _buildPriceRow("PPN", "Rp. 5.000"),
                const SizedBox(height: SSizes.sm),
                _buildPriceRow("Ongkir", "Rp. 4.000"),
              ],
            ),
          ),

          const SizedBox(height: SSizes.md),

          Dash(
            length: MediaQuery.of(context).size.width -
              (SSizes.defaultMargin * 4.3),
              dashLength: 4.0,
              dashGap: 4.0,
              direction: Axis.horizontal,
              dashColor:
                darkMode ? SColors.green50 : SColors.softBlack50,
              dashBorderRadius: 4.0,
          ),

          const SizedBox(height: SSizes.md),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  STexts.total,
                    style: darkMode
                        ? STextTheme.titleCaptionBoldDark
                        : STextTheme.titleCaptionBoldLight,
                ),
                const Spacer(),
                Text(
                  "Rp 66.000",
                    style: STextTheme.titleBaseBoldDark.copyWith(
                    color: SColors.green500,
                    ),
                ),
              ],
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRow(String label, String price) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: STextTheme.bodySmRegularLight,
        ),
        Text(
          price,
          style: STextTheme.titleBaseBoldLight,
        ),
      ],
    );
  }
}
