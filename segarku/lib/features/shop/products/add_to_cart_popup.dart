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

  const SAddToCartPopup({
    super.key,
    required this.price,
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
    if (quantity <= widget.maxQuantity) {
      final product = SProduct(
        id: widget.name, 
        nama: widget.name,
        harga: widget.price,
        qty: quantity, // Tambahkan sesuai jumlah yang dipilih
        categoryId: "", 
        berat: widget.size,
        deskripsi: "",
        image: widget.image,
        categoryName: "",
        showPhoto: "",
        category: {},
      );

      cartController.addToCart(product);
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Produk ditambahkan ke keranjang!"),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Stok tidak mencukupi. Stok tersedia: ${widget.maxQuantity}'),
          backgroundColor: Colors.red,
        ),
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
