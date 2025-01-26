import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import package intl
import 'package:segarku/utils/constants/sizes.dart';
import 'package:segarku/utils/helpers/helper_functions.dart';
import 'package:segarku/utils/theme/custom_themes/text_theme.dart';
import 'package:segarku/utils/constants/colors.dart';

class SAddToCartPopup extends StatefulWidget {
  final int price;
  final String name;
  final int maxQuantity; // Batasan stok dari API

  const SAddToCartPopup({
    super.key,
    required this.price,
    required this.name,
    required this.maxQuantity, // Terima maxQuantity dari parent
  });

  @override
  State<SAddToCartPopup> createState() => _SAddToCartPopupState();
}

class _SAddToCartPopupState extends State<SAddToCartPopup> {
  int quantity = 1;

  // Fungsi untuk menghitung stok tersedia
  int get stokTersedia => widget.maxQuantity - quantity;

  void _addToCart() {
    // Pastikan quantity tidak melebihi stok yang tersedia
    if (quantity <= widget.maxQuantity) {
      // Logika untuk menambahkan item ke keranjang bisa ditambahkan di sini
      Navigator.pop(context); // Menutup BottomSheet setelah item ditambahkan ke keranjang
    } else {
      // Tampilkan pesan error jika quantity melebihi stok
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Stok tidak mencukupi. Stok tersedia: ${widget.maxQuantity}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // Fungsi untuk memformat harga dengan titik sebagai pemisah ribuan
  String _formatPrice(int price) {
    final formatCurrency = NumberFormat.currency(
      locale: 'id_ID', // Lokalisasi Indonesia
      symbol: '', // Menghilangkan simbol mata uang (Rp)
      decimalDigits: 0, // Tidak menampilkan desimal
    );
    return formatCurrency.format(price);
  }

  @override
  Widget build(BuildContext context) {
    final dark = SHelperFunctions.isDarkMode(context);

    return Padding(
      padding: const EdgeInsets.only(
        right : SSizes.defaultMargin,
        left : SSizes.defaultMargin,
        bottom : SSizes.defaultMargin
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.name,
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
                  // Tombol Kurang
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
                          color: dark 
                            ? SColors.green50 
                            : SColors.softBlack50,
                        ),
                        borderRadius: BorderRadius.circular(SSizes.borderRadiussm),
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
                  // Jumlah Item
                  Text(
                    '$quantity',
                    style: dark
                      ? STextTheme.titleBaseBoldDark
                      : STextTheme.titleBaseBoldLight,
                  ),
                  const SizedBox(width: SSizes.md),
                  // Tombol Tambah
                  GestureDetector(
                    onTap: quantity < widget.maxQuantity
                        ? () => setState(() => quantity++)
                        : null,
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: quantity < widget.maxQuantity
                            ? SColors.green100
                            : Colors.transparent, // Nonaktifkan tombol jika stok habis
                        borderRadius: BorderRadius.circular(SSizes.borderRadiussm),
                        border: Border.all(
                          color: quantity < widget.maxQuantity
                            ? Colors.transparent
                            : SColors.softBlack50, // Nonaktifkan tombol jika stok habis
                        )
                      ),
                      child: Icon(
                        Icons.add,
                        size: 16,
                        color: quantity < widget.maxQuantity
                            ? SColors.green500
                            : SColors.softBlack100, // Nonaktifkan tombol jika stok habis
                      ),
                    ),
                  ),
                ],
              ),
              // Harga Total
              Text(
                'Rp ${_formatPrice(widget.price * quantity)}', // Format harga dengan titik
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: SColors.green500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Tombol Tambah ke Keranjang
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _addToCart,
              child: Text(
                "Tambah ke Keranjang",
                style: dark
                  ? STextTheme.titleBaseBoldLight
                  : STextTheme.titleBaseBoldDark,
              ),
            ),
          ),
          // Tampilkan pesan stok tersedia
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              'Stok tersedia: $stokTersedia', // Menampilkan stok yang tersedia
              style: dark
                ? STextTheme.bodyCaptionRegularDark
                : STextTheme.bodyCaptionRegularLight.copyWith(
                color: stokTersedia <= 0 ? Colors.red : Colors.black, // Ubah warna teks menjadi merah jika stok habis
              ),
            ),
          ),
        ],
      ),
    );
  }
}