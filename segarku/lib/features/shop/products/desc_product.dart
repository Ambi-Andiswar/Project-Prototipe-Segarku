import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:segarku/commons/style/spacing_style.dart';
import 'package:segarku/utils/constants/colors.dart';
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
                    color: dark ? SColors.pureBlack : SColors.green200,
                    width: double.infinity,
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
                                  color: dark ? SColors.pureBlack : SColors.green200,
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                    color: dark ? SColors.softBlack300 : SColors.softBlack400,
                                    width: 1,
                                  ),
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  icon: Icon(
                                    Icons.arrow_back,
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
                                      color: dark ? SColors.pureBlack : SColors.green200,
                                      borderRadius: BorderRadius.circular(50),
                                      border: Border.all(
                                        color: dark ? SColors.softBlack300 : SColors.softBlack400,
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
                                        Iconsax.shopping_cart4,
                                        color: dark ? SColors.pureWhite : SColors.softBlack500,
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
                                        color: SColors.danger100,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Center(
                          child: Image.asset(
                            'assets/logos/melon.png',
                            width: 323,
                            height: 247,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Buah segar',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: dark ? SColors.softBlack300 : SColors.softBlack400,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Golden Melon',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: dark ? SColors.pureWhite : SColors.softBlack500,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: List.generate(5, (index) {
                                    return const Icon(
                                      Icons.star,
                                      color: SColors.warning500,
                                      size: 20,
                                    );
                                  }),
                                ),
                              ],
                            ),

                            // button tambah dan kurangi product
                            const Spacer(),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () => showAddToCartPopup(context),
                                  child: Container(
                                    width: 36,
                                    height: 36,
                                    decoration: BoxDecoration(
                                      color: dark ? SColors.pureBlack : SColors.pureWhite,
                                      borderRadius: BorderRadius.circular(100),
                                      border: Border.all(color: SColors.green500),
                                    ),
                                    child: const Icon(Icons.remove, size: 16, color: SColors.green500),
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Text(
                                  '0',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: dark ? SColors.pureWhite : SColors.softBlack500,
                                  ),
                                ),
                                const SizedBox(width: 20),
                                GestureDetector(
                                  onTap: () => showAddToCartPopup(context),
                                  child: Container(
                                    width: 36,
                                    height: 36,
                                    decoration: BoxDecoration(
                                      color: SColors.green500,
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: Icon(Icons.add, size: 16, color: dark ? SColors.pureBlack : SColors.pureWhite),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 22),
                        Text(
                          'Deskripsi Produk',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: dark ? SColors.pureWhite : SColors.softBlack500,
                          ),
                        ),
                        //sub deskripsi 
                        const SizedBox(height: 8),
                        Text(
                          'Golden Melon adalah buah segar pilihan dengan rasa manis alami dan tekstur lembut yang menggugah selera. Dikemas secara higienis dan dipotong rapi, buah ini siap dikonsumsi kapan saja. Pilihan sempurna untuk camilan sehat, salad segar, atau diolah menjadi jus menyegarkan.',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: dark? SColors.softBlack300 : SColors.softBlack400,
                          ),
                        ),

                        const SizedBox(height: 12),
                        Text(
                          'Mengandung Vitamin',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: dark ? SColors.pureWhite : SColors.softBlack500,
                          ),
                        ),
                        //sub deskripsi 
                        const SizedBox(height: 8),
                        Text(
                          'Vitamin C \n Vitamin A \n Antioksidan',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: dark? SColors.softBlack300 : SColors.softBlack400,
                          ),
                        ),

                        const SizedBox(height: 12),
                        Text(
                          'Golden Melon cocok untuk:',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: dark ? SColors.pureWhite : SColors.softBlack500,
                          ),
                        ),
                        //sub deskripsi 
                        const SizedBox(height: 8),
                        Text(
                          'Anak-anak, Remaja dan dewasa, Ibu hamil dan Lansia',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: dark? SColors.softBlack300 : SColors.softBlack400,
                          ),
                        ),
                        const SizedBox(height: 8),
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
                style
                : TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
