import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart'; // Import package shimmer
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

class SProductV extends StatelessWidget {
  const SProductV({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = SHelperFunctions.isDarkMode(context);

    return FutureBuilder<List<SProduct>>(
      future: ApiServiceProduct.fetchProducts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return buildShimmerEffect(context); // Tampilkan shimmer effect saat loading
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No products available'));
        }

        final products = snapshot.data!;

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
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: products.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.75,
          ),
          itemBuilder: (context, index) {
            final product = products[index];
            final isOutOfStock = product.qty == 0; // Cek apakah stok habis

            return GestureDetector(
              onTap: () {
                if (!isOutOfStock) { // Hanya navigasi jika stok tersedia
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
                }
              },
              child: Container(
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
                      // Gambar produk dengan overlay jika stok habis
                      Expanded(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(SSizes.borderRadiusmd),
                              child: Image.network(
                                product.image,
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            ),
                            if (isOutOfStock) // Tampilkan overlay jika stok habis
                              Container(
                                width: double.infinity,
                                height: double.infinity,
                                decoration: BoxDecoration(
                                  // ignore: deprecated_member_use
                                  color: Colors.black.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(
                                      SSizes.borderRadiusmd),
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
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: SSizes.sm2),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Nama produk
                            Text(
                              product.nama,
                              style: darkMode
                                  ? STextTheme.titleBaseBoldDark
                                  : STextTheme.titleBaseBoldLight,
                            ),
                            // Ukuran Produk
                            Row(
                              children: [
                                Text(
                                  product.berat,
                                  style: darkMode
                                      ? STextTheme.bodyCaptionRegularDark
                                      : STextTheme.bodyCaptionRegularLight,
                                ),
                              ],
                            ),
                            const SizedBox(height: SSizes.xs),
                            // Harga Produk
                            Row(
                              children: [
                                Text(
                                  NumberFormat.currency(
                                    locale: 'id',
                                    symbol: 'Rp. ',
                                    decimalDigits: 0,
                                  ).format(product.harga),
                                  style: darkMode
                                      ? STextTheme.titleBaseBlackDark
                                      : STextTheme.titleBaseBlackLight,
                                ),
                                const Spacer(),
                                if (!isOutOfStock) // Hanya tampilkan tombol tambah jika stok tersedia
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
                                            return SAddToCartPopup(
                                              price: (product.harga),
                                              name: product.nama,
                                              id: product.id,
                                              maxQuantity:(product.qty),
                                              image: product.image,
                                              size: product.berat,
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
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  // Fungsi untuk membuat efek shimmer
  Widget buildShimmerEffect(BuildContext context) {
    final darkMode = SHelperFunctions.isDarkMode(context);
    final screenWidth = MediaQuery.of(context).size.width;

    int crossAxisCount = 2;
    if (screenWidth >= 600) {
      crossAxisCount = 3;
    }
    if (screenWidth >= 900) {
      crossAxisCount = 4;
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 6, // Jumlah item shimmer yang ditampilkan
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.75,
      ),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: darkMode ? Colors.grey[800]! : Colors.grey[300]!,
          highlightColor: darkMode ? Colors.grey[700]! : Colors.grey[100]!,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: darkMode ? SColors.green50 : SColors.softBlack50,
              ),
              borderRadius: BorderRadius.circular(SSizes.borderRadiusmd2),
              color: darkMode ? SColors.pureBlack : SColors.pureWhite,
            ),
            child: Padding(
              padding: const EdgeInsets.all(SSizes.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Shimmer untuk gambar produk
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(SSizes.borderRadiusmd),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: SSizes.sm2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Shimmer untuk nama produk
                        Container(
                          width: double.infinity,
                          height: 16,
                          color: Colors.white,
                        ),
                        const SizedBox(height: SSizes.xs),
                        // Shimmer untuk ukuran produk
                        Container(
                          width: 100,
                          height: 12,
                          color: Colors.white,
                        ),
                        const SizedBox(height: SSizes.xs),
                          // Shimmer untuk harga produk
                        Container( 
                          width: 80,
                          height: 14,
                          color: Colors.white,
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