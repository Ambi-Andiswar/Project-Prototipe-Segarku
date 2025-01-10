import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:segarku/navigation_menu.dart';
import 'package:segarku/utils/constants/colors.dart';
import 'package:segarku/utils/constants/sizes.dart';
import 'package:segarku/utils/theme/custom_themes/text_theme.dart';

class ProductHistory extends StatelessWidget {
  final List<Map<String, String>> products;
  final bool darkMode;
  final int totalItems;
  final int totalPrice;

  const ProductHistory({
    Key? key,
    required this.products,
    required this.darkMode,
    required this.totalItems,
    required this.totalPrice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: SSizes.defaultMargin),
      child: Container(
        decoration: BoxDecoration(
          color: darkMode ? SColors.pureBlack : Colors.white,
          borderRadius: BorderRadius.circular(SSizes.borderRadiusmd2),
        ),
        padding: const EdgeInsets.all(SSizes.defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Baris tanggal dan status selesai
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  products.first["date"]!,
                  style: darkMode
                      ? STextTheme.bodySmRegularDark
                      : STextTheme.bodySmRegularLight,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: SSizes.md,
                    vertical: SSizes.sm,
                  ),
                  decoration: BoxDecoration(
                    color: SColors.green50,
                    borderRadius: BorderRadius.circular(SSizes.borderRadiussm),
                  ),
                  child: Text(
                    "Selesai",
                    style: STextTheme.bodySmRegularLight.copyWith(
                      color: SColors.green500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: SSizes.md),

            // Produk yang telah di-checkout
            Column(
              children: products.map((product) {
                final isLast = product == products.last;
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
                        height: 80.0,
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
            const SizedBox(height: SSizes.lg),

            // Baris Total Item, Total Harga, dan Button "Beli Lagi"
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Total $totalItems Item",
                      style: darkMode
                          ? STextTheme.bodySmRegularDark
                          : STextTheme.bodySmRegularLight,
                    ),
                    Row(
                      children: [
                        Text(
                          "Total Harga",
                          style: STextTheme.bodySmRegularLight.copyWith(
                            color: SColors.green500
                          ),
                        ),
                        Text(
                          " Rp. $totalPrice",
                          style: STextTheme.titleBaseBoldLight.copyWith(
                            color: SColors.green500,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () => Get.to(() => const NavigationMenu(initialIndex: 0)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: SColors.green500,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(SSizes.borderRadiussm),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: SSizes.md,
                      vertical: SSizes.sm,
                    ),
                  ),
                  child: Text(
                    "Beli Lagi",
                    style: STextTheme.ctaSm.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
