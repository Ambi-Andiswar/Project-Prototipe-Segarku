import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:segarku/features/carts/controllers/cart_provider.dart';
import 'package:segarku/features/orders/widget/order_detail_history/order_detail_history.dart';
import 'package:segarku/features/shop/products/data/product.dart';
import 'package:segarku/navigation_menu.dart';
import 'package:segarku/utils/constants/colors.dart';
import 'package:segarku/utils/constants/image_strings.dart';
import 'package:segarku/utils/constants/sizes.dart';
import 'package:segarku/utils/theme/custom_themes/text_theme.dart';
import '../models/loading_product_history.dart';

class ProductHistory extends StatelessWidget {
  final dynamic transaction;
  final bool darkMode;
  final Map<String, dynamic> products; // Data produk
  final bool isLoading; // Tambahkan parameter isLoading

  const ProductHistory({
    super.key,
    required this.transaction,
    required this.darkMode,
    required this.products,
    this.isLoading = false, // Default false
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return ProductShimmer(darkMode: darkMode);
    }

    final productsList = transaction['products'];
    final totalItems = productsList.fold(0, (sum, product) => sum + product['quantity']);
    final totalPrice = transaction['total_amount'];

    // Pisahkan produk dari biaya tambahan (pajak dan biaya pengiriman)
    final List<dynamic> productItems = productsList.where((product) => product['id'] != "TAX" && product['id'] != "DELIVERY").toList();
    final dynamic taxItem = productsList.firstWhere((product) => product['id'] == "TAX", orElse: () => null);
    final dynamic deliveryItem = productsList.firstWhere((product) => product['id'] == "DELIVERY", orElse: () => null);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: SSizes.defaultMargin),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Get.to(() => OrderDetailHistoryScreen(transaction: transaction));
            },
            child: Container(
              decoration: BoxDecoration(
                color: darkMode ? SColors.pureBlack : Colors.white,
                borderRadius: BorderRadius.circular(SSizes.borderRadiusmd2),
                border: Border.all(
                  color: darkMode ? SColors.green50 : SColors.softBlack50,
                ),
              ),
              padding: const EdgeInsets.all(SSizes.defaultMargin),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        transaction['created_at'],
                        style: darkMode
                            ? STextTheme.bodyCaptionRegularDark
                            : STextTheme.bodyCaptionRegularLight,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: SSizes.md,
                          vertical: SSizes.sm,
                        ),
                        decoration: BoxDecoration(
                          color: transaction['status'] == 'proses' ? SColors.softBlack50 : SColors.green50,
                          borderRadius: BorderRadius.circular(SSizes.borderRadiussm),
                        ),
                        child: Text(
                          transaction['status'],
                          style: STextTheme.bodyCaptionRegularLight.copyWith(
                            color: transaction['status'] == 'proses' ? SColors.softBlack400 : SColors.green500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: SSizes.md),
                  // Hanya tampilkan produk (bukan pajak atau biaya pengiriman)
                  Column(
                    children: productItems.map<Widget>((product) {
                      final isLast = product == productItems.last;
                      // Cari data produk berdasarkan id
                      final productData = products[product['id']];
                      final imageUrl = productData != null ? productData['image'] : SImages.appLogo; // Gambar default jika tidak ditemukan
                      final berat = productData != null ? productData['berat'] : '0 Kg/pack'; // Berat default jika tidak ditemukan
                      final harga = productData != null ? productData['harga'] : product['price']; // Harga dari produk jika tidak ditemukan

                      return Padding(
                        padding: EdgeInsets.only(bottom: isLast ? 0 : SSizes.lg),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(SSizes.borderRadiussm),
                              child: Image.network(
                                imageUrl,
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
                                    product['name'],
                                    style: darkMode
                                        ? STextTheme.titleBaseBlackDark
                                        : STextTheme.titleBaseBlackLight,
                                  ),
                                  Text(
                                    berat,
                                    style: darkMode
                                        ? STextTheme.bodySmRegularDark
                                        : STextTheme.bodySmRegularLight,
                                  ),
                                  const SizedBox(height: SSizes.sm),
                                  Text(
                                    NumberFormat.currency(
                                      locale: 'id',
                                      symbol: 'Rp. ',
                                      decimalDigits: 0,
                                    ).format(int.tryParse(harga.toString()) ?? 0),
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
                                "${product['quantity']} item",
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
                  const SizedBox(height: SSizes.md),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Total $totalItems Item",
                            style: darkMode
                                ? STextTheme.bodyCaptionRegularDark
                                : STextTheme.bodyCaptionRegularLight,
                          ),
                          // Tampilkan pajak jika ada
                          if (taxItem != null)
                            Text(
                              "Pajak (5%): ${NumberFormat.currency(locale: 'id', symbol: 'Rp. ', decimalDigits: 0).format(taxItem['price'])}",
                              style: darkMode
                                  ? STextTheme.bodyCaptionRegularDark
                                  : STextTheme.bodyCaptionRegularLight,
                            ),
                          // Tampilkan biaya pengiriman jika ada
                          if (deliveryItem != null)
                            Text(
                              "Biaya Pengiriman: ${NumberFormat.currency(locale: 'id', symbol: 'Rp. ', decimalDigits: 0).format(deliveryItem['price'])}",
                              style: darkMode
                                  ? STextTheme.bodyCaptionRegularDark
                                  : STextTheme.bodyCaptionRegularLight,
                            ),
                          Row(
                            children: [
                              Text(
                                "Total Harga ",
                                style: STextTheme.bodyCaptionRegularLight.copyWith(
                                  color: SColors.green500,
                                ),
                              ),
                              Text(
                                NumberFormat.currency(
                                  locale: 'id',
                                  symbol: 'Rp. ',
                                  decimalDigits: 0,
                                ).format(totalPrice),
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
                        onPressed: () {
                          final cartController = Get.find<CartController>();

                          // Loop melalui produk yang ada dalam transaksi
                          for (var product in productItems) {
                            final productData = products[product['id']];
                            if (productData != null) {
                              // Buat objek SProduct dari data produk
                              final sProduct = SProduct(
                                id: product['id'], // ID produk
                                nama: product['name'], // Nama produk
                                harga: int.tryParse(productData['harga'].toString()) ?? 0, // Harga produk
                                qty: product['quantity'], // Jumlah produk
                                maxQuantity: product['quantity'], // Sesuaikan dengan nilai yang sesuai
                                categoryId: productData['category_id'], // ID kategori
                                berat: productData['berat'], // Berat produk
                                deskripsi: productData['deskripsi'], // Deskripsi produk
                                image: productData['image'], // URL gambar produk
                                categoryName: productData['category_name'], // Nama kategori
                                showPhoto: productData['show_photo'], // Tampilan foto
                                category: productData['category'], // Data kategori
                              );

                              // Tambahkan produk ke keranjang
                              cartController.addToCart(sProduct);
                            }
                          }
                          // Navigasi ke halaman NavigationMenu(initialIndex: 1)
                          Get.to(() => const NavigationMenu(initialIndex: 1));

                          // Tampilkan feedback ke pengguna
                          Get.snackbar(
                            "Berhasil",
                            "Produk telah ditambahkan ke keranjang",
                            snackPosition: SnackPosition.TOP,
                            backgroundColor: SColors.green500,
                            colorText: SColors.pureWhite,
                            duration: const Duration(seconds: 2),
                          );

                          
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: SColors.green500,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(SSizes.borderRadiussm),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: SSizes.md2,
                            vertical: SSizes.xs,
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
          ),
          const SizedBox(height: 12), // Jarak antara kontainer
        ],
      ),
    );
  }
}