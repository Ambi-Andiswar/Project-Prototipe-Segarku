import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:segarku/features/carts/controllers/cart_provider.dart';
import 'package:segarku/features/shop/products/data/product.dart';
import 'package:segarku/utils/constants/sizes.dart';
import 'package:segarku/utils/helpers/helper_functions.dart';
import 'package:segarku/utils/theme/custom_themes/text_theme.dart';
import 'package:segarku/utils/constants/colors.dart';

class SAddToCartPopup extends StatefulWidget {
  final int price;
  final String name;
  final int maxQuantity;
  final String image;
  final String size;
  final String id;

  const SAddToCartPopup({
    super.key,
    required this.price,
    required this.id,
    required this.name,
    required this.maxQuantity,
    required this.image,
    required this.size,
  });

  @override
  State<SAddToCartPopup> createState() => _SAddToCartPopupState();
}

class _SAddToCartPopupState extends State<SAddToCartPopup> {
  int quantity = 1;
  final CartController cartController = Get.find<CartController>();

  void _addToCart() {
    // Hitung total qty yang akan ditambahkan
    int totalQty = quantity;

    // Cari produk yang sudah ada di keranjang
    int index = cartController.cartItems.indexWhere((item) => item.id == widget.id);

    if (index != -1) {
      // Jika produk sudah ada, tambahkan qty yang sudah ada di keranjang
      totalQty += cartController.cartItems[index].qty;
    }

    // Periksa apakah total qty melebihi stok yang tersedia
    if (totalQty <= widget.maxQuantity) {
      // Jika tidak melebihi, tambahkan produk ke keranjang
      if (index != -1) {
        cartController.updateQuantity(index, quantity);
      } else {
        final product = SProduct(
          id: widget.id,
          nama: widget.name,
          harga: widget.price,
          qty: quantity,
          categoryId: "",
          berat: widget.size,
          deskripsi: "",
          image: widget.image,
          categoryName: "",
          showPhoto: "",
          category: {},
        );
        cartController.addToCart(product);
      }

      Navigator.pop(context);
      Get.snackbar(
        "Produk ditambahkan ke keranjang!", // Judul snackbar
        "Anda bisa langsung melakukan pembayaran sekarang", // Subtitle (bisa dikosongkan jika tidak diperlukan)
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        borderRadius: 12,
        margin: const EdgeInsets.all(16),
        icon: const Icon(Icons.shopping_cart, color: Colors.white), // Icon yang sesuai
        duration: const Duration(seconds: 5),
      );
    } else {
      // Jika melebihi, tampilkan pesan error
      Get.snackbar(
        "Stok produk tidak mencukupi!", // Judul snackbar
        "Anda sudah menambahkan semua jumlah produk pada keranjang", // Subtitle (bisa dikosongkan jika tidak diperlukan)
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        borderRadius: 12,
        margin: const EdgeInsets.all(16),
        icon: const Icon(Icons.error, color: Colors.white), // Icon yang sesuai
        duration: const Duration(seconds: 5),
      );
    }
  }

  String _formatPrice(int price) {
    final formatCurrency = NumberFormat.currency(
      locale: 'id_ID',
      symbol: '',
      decimalDigits: 0,
    );
    return formatCurrency.format(price);
  }

  @override
  Widget build(BuildContext context) {
    final dark = SHelperFunctions.isDarkMode(context);

    return Padding(
      padding: const EdgeInsets.only(
        right: SSizes.defaultMargin,
        left: SSizes.defaultMargin,
        bottom: SSizes.defaultMargin,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close)),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: quantity > 1 ? () => setState(() => quantity--) : null,
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(color: dark ? SColors.green50 : SColors.softBlack50),
                        borderRadius: BorderRadius.circular(SSizes.borderRadiussm),
                      ),
                      child: Icon(Icons.remove, size: 16, color: dark ? SColors.green100 : SColors.softBlack100),
                    ),
                  ),
                  const SizedBox(width: SSizes.md),
                  Text('$quantity', style: dark ? STextTheme.titleBaseBoldDark : STextTheme.titleBaseBoldLight),
                  const SizedBox(width: SSizes.md),
                  GestureDetector(
                    onTap: quantity < widget.maxQuantity ? () => setState(() => quantity++) : null,
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: quantity < widget.maxQuantity ? SColors.green100 : Colors.transparent,
                        borderRadius: BorderRadius.circular(SSizes.borderRadiussm),
                        border: Border.all(color: quantity < widget.maxQuantity ? Colors.transparent : SColors.softBlack50),
                      ),
                      child: Icon(Icons.add, size: 16, color: quantity < widget.maxQuantity ? SColors.green500 : SColors.softBlack100),
                    ),
                  ),
                ],
              ),
              Text(
                'Rp ${_formatPrice(widget.price * quantity)}',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: SColors.green500),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _addToCart,
              child: Text(
                "Tambah ke Keranjang",
                style: dark ? STextTheme.titleBaseBoldLight : STextTheme.titleBaseBoldDark,
              ),
            ),
          ),
        ],
      ),
    );
  }
}