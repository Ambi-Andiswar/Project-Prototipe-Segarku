import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:segarku/features/shop/products/models/product.dart';
import 'package:segarku/utils/constants/colors.dart';
import 'package:segarku/utils/constants/drop_shadow.dart';
import 'package:segarku/utils/constants/icons.dart';
import 'package:segarku/utils/constants/sizes.dart';
import 'package:segarku/utils/constants/text_strings.dart';
import 'package:segarku/utils/helpers/helper_functions.dart';
import 'package:segarku/utils/models/product_horizontal.dart';
import 'package:segarku/utils/theme/custom_themes/text_theme.dart';
import '../../../../navigation_menu.dart';

class DescProductScreen extends StatelessWidget {
  final Product product;

  const DescProductScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final bool dark = context.isDarkMode;

    void showAddToCartPopup(BuildContext context, int productPrice, String productName) {
      showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(SSizes.borderRadiusmd2)),
        ),
        builder: (context) {
          return AddToCartPopup(price: productPrice, name: productName,);
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

                      // Image produk
                      image: DecorationImage(
                        image: AssetImage(
                          product.image,
                        ),
                        fit: BoxFit.cover, // Untuk memastikan gambar menutupi seluruh background
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
                              product.name,
                              style: dark
                                  ? STextTheme.titleLgBolddark
                                  : STextTheme.titleLgBoldLight,
                            ),
                            const SizedBox(height: SSizes.xs),

                            // Size Produk
                            Text(
                              product.size,
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
                                  ).format(product.price),
                                  style: STextTheme.titleLgBolddark.copyWith(
                                    color: SColors.green500,
                                  ),
                                ),
                                const SizedBox(width: SSizes.md),

                                // Row Tambah/Kurang
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () => showAddToCartPopup(context, product.price, product.name),
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
                                      onTap: () => showAddToCartPopup(context, product.price, product.name),
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
                          product.description,
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

 class AddToCartPopup extends StatefulWidget {
  final int price; // Harga produk
  final String name;

  const AddToCartPopup({super.key, required this.price, required this.name});

  @override
  State<AddToCartPopup> createState() => _AddToCartPopupState();
}

class _AddToCartPopupState extends State<AddToCartPopup> {
  int quantity = 1;

  void _addToCart() {
    // Logika untuk menambahkan item ke keranjang bisa ditambahkan di sini
    Navigator.pop(context); // Menutup BottomSheet setelah item ditambahkan ke keranjang
  }

  @override
  Widget build(BuildContext context) {
    final darkMode = SHelperFunctions.isDarkMode(context);

    return Padding(
      padding: const EdgeInsets.all(SSizes.defaultMargin),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.name, // Ubah sesuai nama produk jika dinamis
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: quantity > 1
                        ? () => setState(() => quantity--)
                        : null,
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(
                          color: darkMode 
                            ? SColors.green50 
                            : SColors.softBlack50,
                        ),
                        borderRadius: BorderRadius.circular(SSizes.borderRadiussm),
                      ),
                      child: Icon(
                        Icons.remove,
                        size: 16,
                        color: darkMode 
                          ? SColors.green100 
                          : SColors.softBlack100,
                      ),
                    ),
                  ),
                  const SizedBox(width: SSizes.md),
                  Text(
                    '$quantity',
                    style: darkMode
                      ? STextTheme.titleBaseBoldDark
                      : STextTheme.titleBaseBoldLight,
                  ),
                  const SizedBox(width: SSizes.md),
                  GestureDetector(
                    onTap: () => setState(() => quantity++),
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: SColors.green100,
                        borderRadius: BorderRadius.circular(SSizes.borderRadiussm),
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
              Text(
                'Rp. ${widget.price * quantity}', // Hitung total harga
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: SColors.green500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _addToCart,
              child: Text(
                STexts.addToCart,
                style:  darkMode
                 ? STextTheme.titleBaseBoldLight
                 : STextTheme.titleBaseBoldDark),
            ),
          ),
        ],
      ),
    );
  }
}
