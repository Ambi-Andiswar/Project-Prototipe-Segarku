import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:segarku/features/shop/products/add_to_cart_popup.dart';
import 'package:segarku/features/shop/products/desc_product.dart';
import 'package:segarku/utils/constants/drop_shadow.dart';
import 'package:segarku/utils/constants/icons.dart';
import 'package:segarku/utils/constants/sizes.dart';
import 'package:segarku/utils/theme/custom_themes/text_theme.dart';
import '../../../../utils/constants/colors.dart';
import 'package:segarku/utils/helpers/helper_functions.dart';
import '../../service/api_product.dart';
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
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(5, (index) => _buildShimmerProduct()),
            ),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No products available'));
        }

        // Filter produk berdasarkan kategori "Spesial Hari Ini"
        final filteredProducts = snapshot.data!
            .where((product) => product.categoryName == "Spesial Hari Ini")
            .toList();

        // Sort products by quantity in descending order (stok terbanyak ke terkecil)
        final products = filteredProducts..sort((a, b) => b.qty.compareTo(a.qty));

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: products.map((product) {
              final isOutOfStock = product.qty == 0; // Cek apakah stok habis

              return Padding(
                padding: const EdgeInsets.only(right: SSizes.md),
                child: GestureDetector(
                  onTap: () {
                    if (!isOutOfStock) { // Hanya navigasi jika stok tersedia
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DescProductScreen(product: product),
                        ),
                      );
                    }
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
                          Stack(
                            alignment: Alignment.center,
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
                              if (isOutOfStock) // Tampilkan overlay jika stok habis
                                Container(
                                  width: double.infinity,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    // ignore: deprecated_member_use
                                    color: Colors.black.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(SSizes.borderRadiusmd),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'Stok Habis!',
                                      style: STextTheme.titleCaptionBoldDark,
                                    ),
                                  ),
                                ),
                            ],
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
                                ).format(product.harga),
                                style: darkMode
                                    ? STextTheme.titleCaptionBlackDark
                                    : STextTheme.titleCaptionBlackLight,
                              ),
                              const Spacer(),

                              // Tombol tambah ke keranjang
                              if (!isOutOfStock) // Hanya tampilkan tombol tambah jika stok tersedia
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
                                            price:(product.harga),
                                            name: product.nama,
                                            id: product.id,
                                            maxQuantity: (product.qty),
                                            image: product.image,
                                            size: product.berat,
                                            deskripsi: product.deskripsi,

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

  /// Widget untuk efek shimmer loading produk
  Widget _buildShimmerProduct() {
    return Padding(
      padding: const EdgeInsets.only(right: SSizes.md),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          width: 140,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(SSizes.borderRadiusmd2),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(SSizes.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(SSizes.borderRadiusmd),
                  child: Container(
                    height: 100,
                    width: double.infinity,
                    color: Colors.grey[300],
                  ),
                ),
                const SizedBox(height: SSizes.sm2),
                Container(
                  height: 12,
                  width: 100,
                  color: Colors.grey[300],
                ),
                const SizedBox(height: SSizes.xs),
                Container(
                  height: 12,
                  width: 50,
                  color: Colors.grey[300],
                ),
                const SizedBox(height: SSizes.xs),
                Container(
                  height: 12,
                  width: 80,
                  color: Colors.grey[300],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}