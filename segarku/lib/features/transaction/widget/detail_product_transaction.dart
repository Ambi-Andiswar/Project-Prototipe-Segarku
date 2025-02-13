import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:segarku/features/shop/products/data/product.dart';
import 'package:segarku/utils/constants/colors.dart';
import 'package:segarku/utils/constants/sizes.dart';
import 'package:segarku/utils/helpers/helper_functions.dart';
import 'package:segarku/utils/theme/custom_themes/text_theme.dart';

class DetailProductTransaction extends StatelessWidget {
  final List<SProduct> products;

  const DetailProductTransaction({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    final darkMode = SHelperFunctions.isDarkMode(context);

    return Container(
      decoration: BoxDecoration(
        color: darkMode ? SColors.pureBlack : Colors.white,
        borderRadius: BorderRadius.circular(SSizes.borderRadiusmd2),
      ),
      padding: const EdgeInsets.all(SSizes.defaultMargin),
      child: Column(
        children: products.map((product) {
          final isLast = product == products.last;
          return Padding(
            padding: EdgeInsets.only(
              bottom: isLast ? 0 : SSizes.lg,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(SSizes.borderRadiussm),
                  child: Image.network(
                    product.image,
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
                        product.nama,
                        style: darkMode
                            ? STextTheme.titleBaseBlackDark
                            : STextTheme.titleBaseBlackLight,
                      ),
                      Text(
                        product.berat,
                        style: darkMode
                            ? STextTheme.bodySmRegularDark
                            : STextTheme.bodySmRegularLight,
                      ),
                      const SizedBox(height: SSizes.sm),
                      Text(
                        'Rp. ${NumberFormat.decimalPattern('id').format(product.harga)}',
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
                    "${product.qty} Qty",
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
    );
  }
}