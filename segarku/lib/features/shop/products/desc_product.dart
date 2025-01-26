import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:segarku/features/shop/products/add_to_cart_popup.dart';
import 'package:segarku/features/shop/products/data/product.dart';
import 'package:segarku/utils/constants/colors.dart';
import 'package:segarku/utils/constants/drop_shadow.dart';
import 'package:segarku/utils/constants/icons.dart';
import 'package:segarku/utils/constants/sizes.dart';
import 'package:segarku/utils/constants/text_strings.dart';
import 'package:segarku/utils/models/product_horizontal.dart';
import 'package:segarku/utils/theme/custom_themes/text_theme.dart';
import '../../../../navigation_menu.dart';

class DescProductScreen extends StatelessWidget {
  final SProduct product; // Ganti Product dengan SProduct

  const DescProductScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final bool dark = context.isDarkMode;

    void showAddToCartPopup(BuildContext context, int productPrice, String productName, String productImage) {
      showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(SSizes.borderRadiusmd2)),
        ),
        builder: (context) {
          return SAddToCartPopup(
            price: productPrice,
            name: productName,
            maxQuantity: int.parse(product.qty), // Gunakan qty dari SProduct
          );
        },
      );
    }

    return Scaffold(
      body: Column(
        children: [
          // Bagian yang dapat di-scroll
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // AppBar Section
                  Container(
                    height: 375,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(product.image), // Gunakan NetworkImage untuk URL
                        fit: BoxFit.cover, // Pastikan gambar menutupi area yang tersedia
                      ),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: SSizes.defaultMargin,
                            top: 69,
                            right: SSizes.defaultMargin
                          ),
                          child: Row(
                            children: [
                              Container(
                                height: SSizes.defaultContainerIcon,
                                width: SSizes.defaultContainerIcon,
                                decoration: BoxDecoration(
                                  color: dark ? SColors.pureBlack : SColors.pureWhite,
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                    color: dark ? SColors.green50 : SColors.softBlack50,
                                    width: 1,
                                  ),
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  icon: Icon(
                                    SIcons.left,
                                    size: SSizes.defaultIcon,
                                    color: dark ? SColors.green50 : SColors.softBlack500,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Stack(
                                children: [
                                  Container(
                                    width: SSizes.defaultContainerIcon,
                                    height: SSizes.defaultContainerIcon,
                                    decoration: BoxDecoration(
                                     color: dark ? SColors.pureBlack : SColors.pureWhite,
                                      borderRadius: BorderRadius.circular(50),
                                      border: Border.all(
                                        color: dark ? SColors.green50 : SColors.softBlack50,
                                        width: 1,
                                      ),
                                    ),
                                    child: IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const NavigationMenu(initialIndex: 1),
                                          ),
                                        );
                                      },
                                      icon: Icon(
                                        SIcons.cart,
                                        color: dark ? SColors.pureWhite : SColors.green500,
                                        size: SSizes.defaultIcon,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 8,
                                    right: 8,
                                    child: Container(
                                      width: 8,
                                      height: 8,
                                      decoration: const BoxDecoration(
                                        color: SColors.danger500,
                                        shape: BoxShape.circle,
                                      ),
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

                  const SizedBox(height: SSizes.md),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: SSizes.defaultMargin),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Nama Produk
                            Text(
                              product.nama, // Ganti product.name dengan product.nama
                              style: dark
                                  ? STextTheme.titleLgBolddark
                                  : STextTheme.titleLgBoldLight,
                            ),
                            const SizedBox(height: SSizes.xs),

                            // Size Produk
                            Text(
                              product.berat, // Ganti product.size dengan product.berat
                              style: dark
                                  ? STextTheme.bodyCaptionRegularDark
                                  : STextTheme.bodyCaptionRegularLight,
                            ),
                            const SizedBox(height: SSizes.md),

                            // Harga dan Tombol Tambah/Kurang
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Harga Produk
                                Text(
                                  NumberFormat.currency(
                                    locale: 'id',
                                    symbol: 'Rp. ',
                                    decimalDigits: 0,
                                  ).format(int.parse(product.harga.replaceAll(RegExp(r'[^0-9]'), ''))), // Konversi harga ke int
                                  style: STextTheme.titleLgBolddark.copyWith(
                                    color: SColors.green500,
                                  ),
                                ),
                                const SizedBox(width: SSizes.md),

                                // Row Tambah/Kurang
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () => showAddToCartPopup(context, int.parse(product.harga.replaceAll(RegExp(r'[^0-9]'), '')), product.nama, product.image),
                                      child: Container(
                                        width: 24,
                                        height: 24,
                                        decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          border: Border.all(
                                            color: dark ? SColors.green50 : SColors.softBlack50,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(SSizes.borderRadiussm),
                                        ),
                                        child: Icon(
                                          Icons.remove,
                                          size: 16,
                                          color: dark
                                              ? SColors.green100
                                              : SColors.softBlack100,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: SSizes.md),
                                    Text(
                                      '0',
                                      style: dark
                                          ? STextTheme.titleBaseBoldDark
                                          : STextTheme.titleBaseBoldLight,
                                    ),
                                    const SizedBox(width: SSizes.md),
                                    GestureDetector(
                                      onTap: () => showAddToCartPopup(context, int.parse(product.harga.replaceAll(RegExp(r'[^0-9]'), '')), product.nama, product.image),
                                      child: Container(
                                        width: 24,
                                        height: 24,
                                        decoration: BoxDecoration(
                                          color: SColors.green100,
                                          borderRadius:
                                              BorderRadius.circular(SSizes.borderRadiussm),
                                        ),
                                        child: const Icon(
                                          Icons.add,
                                          size: 16,
                                          color: SColors.green500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),

                        const SizedBox(height: SSizes.md2),
                        Text(
                          'Deskripsi Produk',
                          style: dark 
                            ? STextTheme.titleBaseBoldDark
                            : STextTheme.titleBaseBoldLight
                        ),
                        //sub deskripsi 
                        const SizedBox(height: SSizes.sm2),
                        Text(
                          product.deskripsi, // Ganti product.description dengan product.deskripsi
                          textAlign: TextAlign.justify,
                          style: dark 
                            ? STextTheme.bodyCaptionRegularDark
                            : STextTheme.bodyCaptionRegularLight
                        ),

                        const SizedBox(height: SSizes.md2),
                        Container(
                          color: Colors.transparent, // Background color full width
                          padding: const EdgeInsets.only(top: SSizes.lg, bottom: SSizes.lg), // Margin isi konten
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start, // Title ke paling kiri
                            children: [
                              // Title Product Horizontal
                              Text(
                                STexts.similarProducts,
                                style: dark
                                    ? STextTheme.titleBaseBoldDark
                                    : STextTheme.titleBaseBoldLight,
                              ),
                              const SizedBox(height: SSizes.sm2), // Jarak vertikal
                              Divider(
                                thickness: 1.0,
                                color: dark
                                  ? SColors.green50
                                  : SColors.softBlack50,
                              ),
                              // Product Horizontal
                              const SProductH(), // Widget produk
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Footer Tetap
          Container(
            decoration: BoxDecoration(
              color: dark ? SColors.softBlack500 : SColors.pureWhite,
              boxShadow: [SShadows.contentShadow],
              borderRadius: BorderRadius.circular(SSizes.borderRadiusmd), // Tambahkan jika border radius dibutuhkan
            ),
            padding: const EdgeInsets.only(
                left: SSizes.defaultMargin,
                top: SSizes.md,
                right: SSizes.defaultMargin,
                bottom: SSizes.xl),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: SColors.green500,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(SSizes.borderRadiusmd),
                      ),
                    ),
                    onPressed: () => Get.to(() => const NavigationMenu(initialIndex: 1)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(SIcons.addToCart,
                            color: dark
                            ? SColors.pureBlack
                            : SColors.pureWhite, size: SSizes.defaultIconxs),
                        const SizedBox(width: SSizes.sm2),
                        Text(
                          STexts.addToCart,
                          style: dark
                            ? STextTheme.titleBaseBoldLight
                            : STextTheme.titleBaseBoldDark,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}