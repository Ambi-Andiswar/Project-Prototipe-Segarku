import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:segarku/commons/widget/appbar/appbar.dart';
import 'package:segarku/features/transaction/widget/delivery_options.dart';
import 'package:segarku/features/transaction/widget/detail_product_transaction.dart';
import 'package:segarku/features/transaction/widget/dialog_purchase_method.dart';
import 'package:segarku/features/transaction/widget/see_address_shop.dart';
import 'package:segarku/features/transaction/widget/select_location.dart';
import 'package:segarku/features/transaction/widget/transaction_success.dart';
import 'package:segarku/utils/constants/colors.dart';
import 'package:segarku/utils/constants/sizes.dart';
import 'package:segarku/utils/theme/custom_themes/text_theme.dart';
import '../../../../../utils/constants/text_strings.dart';

class OrderDetailHistoryScreen extends StatefulWidget {
  const OrderDetailHistoryScreen({super.key});

  @override
  State<OrderDetailHistoryScreen> createState() =>
      _OrderDetailHistoryScreenState();
}

class _OrderDetailHistoryScreenState extends State<OrderDetailHistoryScreen> {
  bool isDelivery = true;

  void _showConfirmationDialog() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => ConfirmationDialog(
        isDelivery: isDelivery,
        onSave: (selectedDelivery) {
          setState(() {
            isDelivery = selectedDelivery;
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool dark = context.isDarkMode;

    return Scaffold(
      body: Column(
        children: [
          // AppBar
          Container(
            color: dark ? SColors.pureBlack : SColors.pureWhite,
            child: Column(
              children: [
                const SizedBox(height: 20),
                SCustomAppBar(
                  title: STexts.orderDetail,
                  darkMode: dark,
                ),
                const SizedBox(height: SSizes.md),
                Divider(
                  color: dark ? SColors.green50 : SColors.softBlack50,
                  thickness: 1,
                  height: 1,
                ),
              ],
            ),
          ),

          // Konten Utama
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: SSizes.defaultMargin,
                            vertical: SSizes.defaultMargin,
                          ),
                          
                        ),
                      ],
                    ),
                  ),
                ),

                // Bagian Bawah (Subtotal, Tax, Delivery, Total)
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: SSizes.defaultMargin),
                  child: Column(
                    children: [
                      const SizedBox(height: SSizes.md2),
                      // SubTotal
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            // Menampilkan dialog konfirmasi
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Konfirmasi Pembelian'),
                                  content: const Text('Apakah produk yang Anda beli sudah sesuai?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        // Tutup dialog jika pengguna membatalkan
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Batal'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        // Tutup dialog dan navigasi ke halaman TransactionSuccess
                                        Navigator.of(context).pop();
                                        Get.to(() => const TransactionSuccess());
                                      },
                                      child: const Text('Lanjutkan'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: const Text(
                            STexts.buyNow,
                            style: STextTheme.titleBaseBoldDark,
                          ),
                        ),
                      ),

                      const SizedBox(height: SSizes.xl),
                    ],
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
