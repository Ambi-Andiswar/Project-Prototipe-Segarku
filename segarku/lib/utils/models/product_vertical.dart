import 'package:flutter/material.dart';
import 'package:segarku/utils/constants/icons.dart';
import 'package:segarku/utils/constants/image_strings.dart';
import 'package:segarku/utils/constants/sizes.dart';
import 'package:segarku/utils/theme/custom_themes/text_theme.dart';
import '../../../../utils/constants/colors.dart';
import 'package:segarku/utils/helpers/helper_functions.dart';

  class SProductV extends StatelessWidget {
    const SProductV({super.key});

    @override
    Widget build(BuildContext context) {
      final darkMode = SHelperFunctions.isDarkMode(context);

      return GridView.builder(
        shrinkWrap: true, // Agar GridView tidak scroll sendiri
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 8, // Jumlah produk (dapat diganti dinamis sesuai data)
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2 produk per baris
          crossAxisSpacing: 16, // Spasi horizontal antar produk
          mainAxisSpacing: 16, // Spasi vertikal antar produk
          childAspectRatio: 0.75, // Perbandingan lebar dan tinggi
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // Navigasi ke halaman DesProductScreen
              //Navigator.push(
                //context,
                //MaterialPageRoute(
                  //builder: (context) => const DescProductScreen(),
                //),
              //);
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(SSizes.borderRadiusmd2),
                color: darkMode ? SColors.slateBlack : SColors.pureWhite,
              ),
              child: Padding(
                padding: const EdgeInsets.all(SSizes.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Gambar produk
                    Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.asset(
                            SImages.brokoli, // Ganti dengan URL gambar produk
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                      ),
                    
                
                    
                    Padding(
                      padding: const EdgeInsets.only(top: SSizes.sm2),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Nama produk
                          Text(
                            'Brokoli', // Ganti sesuai data
                            style: darkMode
                            ? STextTheme.titleBaseBoldDark
                            : STextTheme.titleBaseBoldLight
                          ),
                
                          // Ukuran Product/gr
                          Row(
                            children: [
                              Text(
                                '300-500', // Ganti sesuai data
                                style: darkMode
                                ? STextTheme.bodyCaptionRegularDark
                                : STextTheme.bodyCaptionRegularLight
                              ),
                              Text(
                                'gr/pack', // Ganti sesuai data
                                style: darkMode
                                ? STextTheme.bodySmRegularDark
                                : STextTheme.bodySmRegularLight
                              ),
                            ],
                          ),
                          const SizedBox(height: SSizes.xs),
                          // Harga Product
                          Row(
                            children: [
                              Text(
                                'Rp 25.000', // Ganti sesuai data
                                style: darkMode
                                ? STextTheme.titleBaseBlackDark
                                : STextTheme.titleBaseBlackLight
                              ),
                
                              // Button add
                              const Spacer(),
                              Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  color: darkMode
                                   ? SColors.pureBlack
                                   : SColors.green50,
                                   borderRadius: BorderRadius.circular(SSizes.borderRadiussm),
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    showModalBottomSheet(
                                      context: context,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                                      ),
                                      builder: (context) {
                                        return const AddToCartPopup(price: 40000);
                                      },
                                    );
                                  },
                                  icon: const Icon(
                                    SIcons.add,
                                    color: SColors.primary,
                                    size: 16),
                                  padding: EdgeInsets.zero, // Menghilangkan padding bawaan IconButton
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
