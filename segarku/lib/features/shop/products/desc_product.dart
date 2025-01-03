import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:segarku/commons/style/spacing_style.dart';
import 'package:segarku/utils/constants/colors.dart';
import 'package:segarku/utils/constants/icons.dart';
import 'package:segarku/utils/constants/image_strings.dart';
import 'package:segarku/utils/constants/sizes.dart';
import 'package:segarku/utils/constants/text_strings.dart';
import 'package:segarku/utils/helpers/helper_functions.dart';
import 'package:segarku/utils/models/product_horizontal.dart';
import 'package:segarku/utils/theme/custom_themes/text_theme.dart';
import '../../../../navigation_menu.dart';

class DescProductScreen extends StatelessWidget {
  const DescProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool dark = context.isDarkMode;

    void showAddToCartPopup(BuildContext context) {
      showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        builder: (context) {
          return const AddToCartPopup(price: 25000);
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
                    height: 303,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(SImages.brokoli),
                        fit: BoxFit.cover, // Untuk memastikan gambar menutupi seluruh background
                      ),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: SSpacingStyle.paddingWithAppBarHeight,
                          child: Row(
                            children: [
                              Container(
                                height: 40,
                                width: 40,
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
                                    size: 16,
                                    color: dark ? SColors.pureWhite : SColors.softBlack500,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Stack(
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
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
                                        size: 24,
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
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Brokoli',
                                  style: dark
                                    ? STextTheme.titleLgBolddark
                                    : STextTheme.titleLgBoldLight
                                ),
                                const SizedBox(height: SSizes.xs),
                                Row(
                                  children: [
                                    Text(
                                      '450-500',
                                      style: dark
                                        ? STextTheme.bodyCaptionRegularDark
                                        : STextTheme.bodyCaptionRegularLight,
                                    ),
                                    Text(
                                      'gr/pack', // Ganti sesuai data
                                      style: dark
                                          ? STextTheme.bodySmRegularDark
                                          : STextTheme.bodySmRegularLight,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: SSizes.md),
                                Text(
                                  'Rp 40.000',
                                  style: STextTheme.titleLgBolddark.copyWith(
                                    color: SColors.green500
                                  ),
                                ),
                                const SizedBox(height: SSizes.xs),
                              ],
                            ),
                            const Spacer(),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () => showAddToCartPopup(context),
                                  child: Container(
                                    width: 24,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      color: dark ? SColors.pureBlack : SColors.pureWhite,
                                      borderRadius: BorderRadius.circular(SSizes.borderRadiussm),
                                      border: Border.all(color: SColors.green500),
                                    ),
                                    child: const Icon(Icons.remove, size: 16, color: SColors.green500),
                                  ),
                                ),
                                const SizedBox(width: SSizes.md),
                                Text(
                                  '0',
                                  style: dark
                                    ? STextTheme.titleBaseBoldDark
                                    : STextTheme.titleBaseBoldLight
                                ),
                                const SizedBox(width: SSizes.md),
                                GestureDetector(
                                  onTap: () => showAddToCartPopup(context),
                                  child: Container(
                                    width: 24,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      color: SColors.green500,
                                      borderRadius: BorderRadius.circular(SSizes.borderRadiussm),
                                    ),
                                    child: Icon(Icons.add, size: 16, color: dark ? SColors.pureBlack : SColors.pureWhite),
                                  ),
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
                          STexts.deskription,
                          textAlign: TextAlign.justify,
                          style: dark 
                            ? STextTheme.bodyCaptionRegularDark
                            : STextTheme.bodyCaptionRegularLight
                        ),

                        const SizedBox(height: SSizes.md2),
                        Container(
                          color: dark
                          ? SColors.softBlack300
                          : SColors.green50, // Background color full width
                          padding: const EdgeInsets.only(left: SSizes.md, top: SSizes.lg, bottom: SSizes.lg), // Margin isi konten
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start, // Title ke paling kiri
                            children: [
                              // Title Product Horizontal
                              Text(
                                STexts.specialToday,
                                style: dark
                                    ? STextTheme.titleBaseBoldDark
                                    : STextTheme.titleBaseBoldLight,
                              ),
                              const SizedBox(height: SSizes.md), // Jarak vertikal

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
            color: dark ? SColors.softBlack500 : SColors.pureWhite,
            padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 21.5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Harga',
                      style: TextStyle(
                        fontSize: 14,
                        color: dark ? SColors.softBlack300 : SColors.softBlack400,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Text(
                          'Rp. 25.000',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: SColors.green500,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '/kg',
                          style: TextStyle(
                            fontSize: 14,
                            color: dark ? SColors.softBlack300 : SColors.softBlack400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  width: 160,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: SColors.green500,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () => showAddToCartPopup(context),
                    child: const Text('Tambah'),
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
    final int price;
    

    const AddToCartPopup({super.key, required this.price});

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
                const Text(
                  'Brokoli',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                    Container(
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
                      child: Center( // Tambahkan Center di sini
                        child: GestureDetector( // Gunakan GestureDetector sebagai pengganti IconButton
                          onTap: quantity > 1
                              ? () => setState(() => quantity--)
                              : null,
                          child: Icon(
                            Icons.remove,
                            size: 16,
                            color: darkMode 
                              ? SColors.green50 
                              : SColors.softBlack50,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: SSizes.md),

                    Text('$quantity', 
                      style: darkMode
                        ? STextTheme.titleBaseBoldDark
                        : STextTheme.titleBaseBoldLight,
                    ),
                    const SizedBox(width: SSizes.md),
                    
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: SColors.green100, // Warna latar belakang
                        borderRadius: BorderRadius.circular(SSizes.borderRadiussm),
                      ),
                      child: Center(
                        child: GestureDetector(
                          onTap: () => setState(() => quantity++),
                          child: const Icon(
                            Icons.add,
                            size: 16,
                            color: SColors.green500, // Warna ikon
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
                Text(
                  'Rp. ${widget.price * quantity}',
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
                child: const Text('Tambahkan ke Keranjang',
                  style: STextTheme.titleBaseBoldDark,),
              ),
            ),
          ],
        ),
      );
    }
  }