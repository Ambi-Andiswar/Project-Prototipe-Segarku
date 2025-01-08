import 'package:flutter/material.dart';
import 'package:segarku/features/shop/products/desc_product.dart' as descProduct;
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

    // Daftar produk dinamis
    final List<Map<String, dynamic>> products = [
      {
        "name": "Brokoli",
        "size": "300-500 gr/pack",
        "price": "Rp 25.000",
        "image": SImages.brokoli,
      },
      {
        "name": "Wortel",
        "size": "500 gr/pack",
        "price": "Rp 12.000",
        "image": SImages.wortel,
      },
      {
        "name": "Tomat",
        "size": "300-500 gr/pack",
        "price": "Rp 5.000",
        "image": SImages.tomat,
      },
      {
        "name": "Terong",
        "size": "500 gr/pack",
        "price": "Rp 10.000",
        "image": SImages.terong,
      },
      {
        "name": "Lobak Putih",
        "size": "500 gr/pack",
        "price": "Rp 13.000",
        "image": SImages.lobak,
      },
      {
        "name": "Paprika Kuning",
        "size": "400 gr/pack",
        "price": "Rp 30.000",
        "image": SImages.paprika,
      },
      {
        "name": "Bayam",
        "size": "500 gr/pack",
        "price": "Rp 8.000",
        "image": SImages.bayam,
      },
      {
        "name": "Semangka",
        "size": "800gr-1kg /pack",
        "price": "Rp 15.000",
        "image": SImages.semangka,
      },
    ];

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

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const descProduct.DescProductScreen(),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: darkMode ? SColors.green50 : SColors.softBlack50,
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
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(SSizes.borderRadiusmd),
                      child: Image.asset(
                        product["image"],
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
                          product["name"],
                          style: darkMode
                              ? STextTheme.titleBaseBoldDark
                              : STextTheme.titleBaseBoldLight,
                        ),
                        // Ukuran Produk
                        Row(
                          children: [
                            Text(
                              product["size"],
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
                              product["price"],
                              style: darkMode
                                  ? STextTheme.titleBaseBlackDark
                                  : STextTheme.titleBaseBlackLight,
                            ),
                            const Spacer(),
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
                                    return AddToCartPopup(
                                      price: int.parse(product["price"]!.replaceAll(RegExp(r'[^0-9]'), '')),
                                      name: product["name"]!, // Kirimkan nama produk ke dialog
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
  }
}


class AddToCartPopup extends StatefulWidget {
  final int price;
  final String name;

  const AddToCartPopup({super.key, required this.price, required this.name});

  @override
  State<AddToCartPopup> createState() => _AddToCartPopupState();
}

class _AddToCartPopupState extends State<AddToCartPopup> {
  int quantity = 1;

  void _addToCart() {
    Navigator.pop(context);
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
                widget.name, // Menampilkan nama produk
                style: darkMode
                    ? STextTheme.titleBaseBoldDark
                    : STextTheme.titleBaseBoldLight,
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
                    child: Icon(
                      Icons.remove,
                      color: darkMode
                          ? SColors.green50
                          : SColors.softBlack50,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text('$quantity',
                        style: darkMode
                            ? STextTheme.titleBaseBoldDark
                            : STextTheme.titleBaseBoldLight),
                  ),
                  GestureDetector(
                    onTap: () => setState(() => quantity++),
                    child: const Icon(
                      Icons.add,
                      color: SColors.green500,
                    ),
                  ),
                ],
              ),
              Text(
                'Rp ${widget.price * quantity}',
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

