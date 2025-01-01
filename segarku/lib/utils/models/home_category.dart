import 'package:flutter/material.dart';
import 'package:segarku/utils/constants/image_strings.dart';
import 'package:segarku/utils/constants/sizes.dart';
import 'package:segarku/utils/theme/custom_themes/text_theme.dart';
import '../../../../utils/constants/colors.dart';
import 'package:segarku/utils/helpers/helper_functions.dart';

  class SHomeCategories extends StatelessWidget {
    const SHomeCategories({super.key});

    @override
    Widget build(BuildContext context) {
      final darkMode = SHelperFunctions.isDarkMode(context);

      return SingleChildScrollView(
        scrollDirection: Axis.horizontal, // Mengatur scroll secara horizontal
        child: Row(
          children: List.generate(
            5, // Jumlah produk
            (index) => Padding(
              padding: const EdgeInsets.only(right: 10), // Spasi antar produk
              child: GestureDetector(
                onTap: () {
                  // Aksi ketika produk ditekan
                },
                child: Container(
                  width: 60, // Atur lebar setiap produk
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(SSizes.borderRadiusmd2),
                    color: darkMode ? SColors.slateBlack : SColors.pureWhite,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(right: SSizes.sm, left: SSizes.sm),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Gambar produk
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.asset(
                            SImages.sayurCategory, // Ganti dengan URL gambar produk
                            fit: BoxFit.cover,
                            height: 48,
                            width: double.infinity,
                          ),
                        ),
                        const SizedBox(height: SSizes.sm),
                        // Nama produk
                        Text(
                          'Sayuran', // Ganti sesuai data
                          style: darkMode
                              ? STextTheme.titleCaptionBoldDark
                              : STextTheme.titleCaptionBoldLight,
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
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Golden Melon',
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
                    IconButton(
                      onPressed: quantity > 1
                          ? () => setState(() => quantity--)
                          : null,
                      icon: const Icon(Icons.remove),
                    ),
                    Text('$quantity', style: const TextStyle(fontSize: 16)),
                    IconButton(
                      onPressed: () => setState(() => quantity++),
                      icon: const Icon(Icons.add),
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
