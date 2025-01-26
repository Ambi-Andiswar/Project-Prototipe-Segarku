import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:segarku/features/shop/products/add_to_cart_popup.dart';
import 'package:segarku/features/shop/products/desc_product.dart';
import 'package:segarku/utils/constants/drop_shadow.dart';
import 'package:segarku/utils/constants/icons.dart';
import 'package:segarku/utils/constants/sizes.dart';
import 'package:segarku/utils/theme/custom_themes/text_theme.dart';
import '../../../../utils/constants/colors.dart';
import 'package:segarku/utils/helpers/helper_functions.dart';
import '.././../service/api_product.dart';
import 'package:segarku/features/shop/products/data/product.dart'; // Import SProduct

class SProductH extends StatelessWidget {
  const SProductH({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = SHelperFunctions.isDarkMode(context);

    return FutureBuilder<List<SProduct>>(
      future: ApiServiceProduct.fetchProducts(), // Ambil data dari API
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No products available'));
        }

        final products = snapshot.data!;

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: products.map((product) {
              return Padding(
                padding: const EdgeInsets.only(right: SSizes.md),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DescProductScreen(
                          product: SProduct(
                            id: product.id,
                            image: product.image,
                            nama: product.nama,
                            berat: product.berat,
                            harga: product.harga,
                            deskripsi: product.deskripsi,
                            qty: product.qty,
                            categoryId: product.categoryId,
                            categoryName: product.categoryName,
                            showPhoto: product.showPhoto,
                            category: product.category,
                          ),
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: 140,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: darkMode ? SColors.green50 : SColors.softBlack50,
                      ),
                      borderRadius: BorderRadius.circular(SSizes.borderRadiusmd2),
                      color: darkMode ? SColors.pureBlack : SColors.pureWhite,
                      boxShadow: [SShadows.contentShadow],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(SSizes.md),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(SSizes.borderRadiusmd),
                            child: Image.network(
                              product.image,
                              fit: BoxFit.cover,
                              height: 100,
                              width: double.infinity,
                            ),
                          ),
                          const SizedBox(height: SSizes.sm2),
                          Text(
                            product.nama,
                            style: darkMode
                                ? STextTheme.titleBaseBoldDark
                                : STextTheme.titleBaseBoldLight,
                          ),
                          Text(
                            product.berat,
                            style: darkMode
                                ? STextTheme.bodySmRegularDark
                                : STextTheme.bodySmRegularLight,
                          ),
                          const SizedBox(height: SSizes.xs),
                          Row(
                            children: [
                              Text(
                                NumberFormat.currency(
                                  locale: 'id',
                                  symbol: 'Rp. ',
                                  decimalDigits: 0,
                                ).format(int.parse(product.harga.replaceAll('Rp.', '').replaceAll(',', '').trim())),
                                style: darkMode
                                    ? STextTheme.titleCaptionBlackDark
                                    : STextTheme.titleCaptionBlackLight,
                              ),
                              const Spacer(),
                              Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  color: darkMode ? SColors.pureBlack : SColors.green50,
                                  borderRadius: BorderRadius.circular(SSizes.borderRadiussm),
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    showModalBottomSheet(
                                      context: context,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(SSizes.borderRadiusmd2),
                                        ),
                                      ),
                                      builder: (context) {
                                        return SAddToCartPopup(
                                          price: int.parse(product.harga.replaceAll('Rp.', '').replaceAll(',', '').trim()),
                                          name: product.nama,
                                          maxQuantity: int.parse(product.qty),
                                        );
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
                  ),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}