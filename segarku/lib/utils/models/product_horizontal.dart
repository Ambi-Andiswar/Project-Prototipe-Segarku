import 'package:flutter/material.dart';
import 'package:segarku/utils/constants/icons.dart';
import 'package:segarku/utils/constants/image_strings.dart';
import 'package:segarku/utils/constants/sizes.dart';
import 'package:segarku/utils/theme/custom_themes/text_theme.dart';
import '../../../../utils/constants/colors.dart';
import 'package:segarku/utils/helpers/helper_functions.dart';

  class SProductH extends StatelessWidget {
    const SProductH({super.key});

    @override
    Widget build(BuildContext context) {
      final darkMode = SHelperFunctions.isDarkMode(context);

      return SingleChildScrollView(
        scrollDirection: Axis.horizontal, // Mengatur scroll secara horizontal
        child: Row(
          children: List.generate(
            8, // Jumlah produk
            (index) => Padding(
              padding: const EdgeInsets.only(right: SSizes.md), // Spasi antar produk
              child: GestureDetector(
                onTap: () {
                  // Aksi ketika produk ditekan
                },
                child: Container(
                  width: 140, // Atur lebar setiap produk
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: darkMode
                      ? SColors.green50
                      : SColors.softBlack50
                    ),
                    borderRadius: BorderRadius.circular(SSizes.borderRadiusmd2),
                    color: darkMode ? SColors.slateBlack : SColors.pureWhite,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(SSizes.md),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Gambar produk
                        ClipRRect(
                          borderRadius: BorderRadius.circular(SSizes.borderRadiusmd),
                          child: Image.asset(
                            SImages.semangka, // Ganti dengan URL gambar produk
                            fit: BoxFit.cover,
                            height: 100,
                            width: double.infinity,
                          ),
                        ),
                        const SizedBox(height: SSizes.sm2),
                        // Nama produk
                        Text(
                          'Semangka', // Ganti sesuai data
                          style: darkMode
                              ? STextTheme.titleBaseBoldDark
                              : STextTheme.titleBaseBoldLight,
                        ),
                        // Ukuran produk
                        Text(
                          '300-500 gr/pack', // Ganti sesuai data
                          style: darkMode
                              ? STextTheme.bodySmRegularDark
                              : STextTheme.bodySmRegularLight,
                        ),
                        const SizedBox(height: SSizes.xs),
                        // Harga produk dan tombol
                        Row(
                          children: [
                            Text(
                              'Rp 25.000', // Ganti sesuai data
                              style: darkMode
                                  ? STextTheme.titleCaptionBlackDark
                                  : STextTheme.titleCaptionBlackLight,
                            ),
                            const Spacer(),
                            Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                color: darkMode
                                    ? SColors.pureBlack
                                    : SColors.green50,
                                borderRadius:
                                    BorderRadius.circular(SSizes.borderRadiussm),
                              ),
                              child: IconButton(
                                onPressed: () {
                                  showModalBottomSheet(
                                    context: context,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(SSizes.borderRadiusmd2)),
                                    ),
                                    builder: (context) {
                                      return const AddToCartPopup(price: 25000);
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
            ),
          ),
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
                  'Semangka',
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
                child: const Text('Tambahkan ke Keranjang'),
              ),
            ),
          ],
        ),
      );
    }
  }
