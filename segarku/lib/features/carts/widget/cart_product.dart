import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:segarku/commons/widget/cart/no_carts.dart';
import 'package:segarku/features/carts/controllers/cart_provider.dart';
import 'package:segarku/features/shop/products/desc_product.dart';
import 'package:segarku/features/transaction/transaction_checkout.dart';
import 'package:segarku/utils/constants/colors.dart';
import 'package:segarku/utils/constants/icons.dart';
import 'package:segarku/utils/constants/sizes.dart';
import 'package:segarku/utils/constants/text_strings.dart';
import 'package:segarku/utils/models/product_horizontal.dart';
import 'package:segarku/utils/theme/custom_themes/text_theme.dart';
import 'package:segarku/utils/helpers/helper_functions.dart';

class CartsProductScreen extends StatelessWidget {
  final CartController cartController = Get.put(CartController());

  CartsProductScreen({super.key});

  bool _isWithinOperationalHours() {
    final now = TimeOfDay.now();
    final currentHour = now.hour;
    final currentMinute = now.minute;
    
    // Konversi waktu ke menit untuk m emudahkan perbandingan
    final currentTimeInMinutes = currentHour * 60 + currentMinute;
    final openingTimeInMinutes = 6 * 60;  // 06:00
    final closingTimeInMinutes = 21 * 60; // 21:00
    
    return currentTimeInMinutes >= openingTimeInMinutes && 
          currentTimeInMinutes <= closingTimeInMinutes;
  }

  @override
  Widget build(BuildContext context) {
    final darkMode = SHelperFunctions.isDarkMode(context);

    return Scaffold(
      body: Obx(() {
        if (cartController.cartItems.isEmpty) {
          return const NoItemCartScreen();
        }

        return Column(
          children: [
            // Baris atas: Select All dan Delete
            Padding(
              padding: const EdgeInsets.only(
                  left: SSizes.defaultMargin, right: SSizes.defaultMargin, top: SSizes.md),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Transform.scale(
                        scale: 1.3,
                        child: Checkbox(
                          value: cartController.selectAll.value,
                          onChanged: (value) => cartController.toggleSelectAll(value),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(SSizes.borderRadiussm),
                          ),
                          side: BorderSide(
                            color: darkMode ? SColors.green50 : SColors.softBlack50,
                            width: 1,
                          ),
                          visualDensity: VisualDensity.compact,
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                      ),
                      Text(
                        "Select All",
                        style: STextTheme.bodyCaptionRegularDark.copyWith(
                          color: darkMode ? SColors.pureWhite : SColors.softBlack500,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      cartController.deleteSelectedItems();
                    },
                    icon: const Icon(
                      SIcons.delet,
                      color: SColors.danger500,
                    ),
                  ),
                ],
              ),
            ),

            // Konten produk
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: SSizes.defaultMargin, vertical: SSizes.sm2),
                  child: Column(
                    children: [
                      // Container untuk daftar produk
                      Container(
                        padding: const EdgeInsets.only(
                          top: SSizes.defaultMargin,
                          right: SSizes.defaultMargin,
                          bottom: SSizes.defaultMargin,
                        ),
                        decoration: BoxDecoration(
                          color: darkMode ? SColors.pureBlack : Colors.white,
                          borderRadius: BorderRadius.circular(SSizes.borderRadiusmd2),
                          border: Border.all(
                            color: darkMode ? SColors.green50 : SColors.softBlack50,
                          ),
                        ),
                        child: Column(
                          children: List.generate(cartController.cartItems.length, (index) {
                            final product = cartController.cartItems[index];
                            return Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DescProductScreen(product: product),
                                      ),
                                   );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.only(left: SSizes.sm2),
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(SSizes.borderRadiussm),
                                    ),
                                    child: Row(
                                      children: [
                                        Transform.scale(
                                          scale: 1.3,
                                          child: Checkbox(
                                            value: cartController.selectedItems[index],
                                            onChanged: (value) => cartController.toggleItemSelection(index, value),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(SSizes.borderRadiussm),
                                            ),
                                            side: BorderSide(
                                              color: darkMode ? SColors.green50 : SColors.softBlack50,
                                              width: 1,
                                            ),
                                            visualDensity: VisualDensity.compact,
                                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                          ),
                                        ),
                                        const SizedBox(width: SSizes.sm),
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
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              // Teks nama dan ukuran
                                              Text(
                                                product.nama,
                                                style: darkMode
                                                    ? STextTheme.titleBaseBlackDark
                                                    : STextTheme.titleBaseBlackLight,
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                product.berat, // Ganti dengan ukuran produk jika ada
                                                style: darkMode
                                                    ? STextTheme.bodySmRegularDark
                                                    : STextTheme.bodySmRegularLight,
                                              ),
                                              const SizedBox(height: 8),
                                              // Harga dan kontrol kuantitas dalam 1 Row
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  // Teks harga
                                                  Text(
                                                    'Rp. ${NumberFormat.decimalPattern('id').format(product.harga)}',
                                                    style: STextTheme.titleBaseBoldLight.copyWith(
                                                      color: SColors.green500,
                                                    ),
                                                  ),
                                                  // Kontrol kuantitas
                                                  Row(
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () => cartController.updateQuantity(index, -1),
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
                                                            borderRadius: BorderRadius.circular(
                                                                SSizes.borderRadiussm),
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
                                                      Obx(() => Text(
                                                        '${cartController.itemQuantities[index]}',
                                                        style: darkMode
                                                            ? STextTheme.titleBaseBoldDark
                                                            : STextTheme.titleBaseBoldLight,
                                                      )),
                                                      const SizedBox(width: SSizes.md),
                                                      // Pada bagian kontrol kuantitas
                                                      GestureDetector(
                                                        onTap: () {
                                                          int maxQuantity = cartController.cartItems[index].maxQuantity;
                                                          if (cartController.cartItems[index].qty + 1 <= maxQuantity) {
                                                            cartController.updateQuantity(index, 1);
                                                          } else {
                                                            Get.snackbar(
                                                              "Stok produk tidak mencukupi!", // Judul snackbar
                                                              "Anda sudah menambahkan semua jumlah produk pada keranjang", // Subtitle (bisa dikosongkan jika tidak diperlukan)
                                                              backgroundColor: Colors.red,
                                                              colorText: Colors.white,
                                                              snackPosition: SnackPosition.TOP,
                                                              borderRadius: 12,
                                                              margin: const EdgeInsets.all(16),
                                                              icon: const Icon(Icons.error, color: Colors.white), // Icon yang sesuai
                                                              duration: const Duration(seconds: 2),
                                                            );
                                                          }
                                                        },
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
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                if (index != cartController.cartItems.length - 1)
                                  const SizedBox(height: 20), // Jarak antar produk
                              ],
                            );
                          }),
                        ),
                      ),

                      const SizedBox(height: SSizes.lg2),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            STexts.youLink,
                            style: darkMode
                              ? STextTheme.titleBaseBoldDark
                              : STextTheme.titleBaseBoldLight,
                          ),

                          const SizedBox(height: SSizes.md),
                          const SProductH(),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Bagian Fixed untuk tombol bayar
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 5),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Total and Pay Button Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Text Section
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Total",
                            style: darkMode
                                ? STextTheme.bodyCaptionRegularDark
                                : STextTheme.bodyCaptionRegularLight,
                          ),
                          const SizedBox(height: SSizes.xs - 2),
                          Obx(() => Text(
                            "Rp ${NumberFormat.decimalPattern('id').format(cartController.calculateTotalPrice())}",
                            style: darkMode
                                ? STextTheme.titleMdBoldDark
                                : STextTheme.titleMdBoldLight,
                          )),
                        ],
                      ),
                      // Button Section
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _isWithinOperationalHours() 
                            ? SColors.green500 
                            : SColors.softBlack100, // Warna tombol abu-abu ketika di luar jam operasional
                          minimumSize: const Size(165, 40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(SSizes.borderRadiusmd),
                          ),
                        ),
                        onPressed: () {
                          if (!_isWithinOperationalHours()) {
                            Get.snackbar(
                              "Di Luar Jam Operasional",
                              "Maaf, pemesanan hanya dapat dilakukan dari jam 06:00 sampai 21:00",
                              snackPosition: SnackPosition.TOP,
                              backgroundColor: SColors.danger500,
                              colorText: SColors.pureWhite,
                              duration: const Duration(seconds: 3),
                              icon: const Icon(Icons.access_time, color: Colors.white),
                            );
                            return;
                          }

                          final selectedProducts = cartController.getSelectedProducts();
                          if (selectedProducts.isEmpty) {
                            Get.snackbar(
                              "Peringatan",
                              "Pilih setidaknya satu produk untuk Bayar.",
                              snackPosition: SnackPosition.TOP,
                              backgroundColor: SColors.danger500,
                              colorText: SColors.pureWhite,
                            );
                          } else {
                            Get.to(() => const TransactionCheckoutScreen());
                          }
                        },
                        child: Text(
                          "Bayar",
                          style: STextTheme.titleBaseBoldDark.copyWith(
                            color: _isWithinOperationalHours() 
                              ? SColors.pureWhite 
                              : SColors.softBlack500, 
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}