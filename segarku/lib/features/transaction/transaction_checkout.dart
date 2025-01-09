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

class TransactionCheckoutScreen extends StatefulWidget {
  const TransactionCheckoutScreen({super.key});

  @override
  State<TransactionCheckoutScreen> createState() =>
      _TransactionCheckoutScreenState();
}

class _TransactionCheckoutScreenState extends State<TransactionCheckoutScreen> {
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
                const SizedBox(height: 52),
                SCustomAppBar(
                  title: STexts.payment,
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Delivery Options dengan Callback
                              DeliveryOptions(
                                isDelivery: isDelivery,
                                onChangeMode: (isTapped) {
                                  if (isTapped) {
                                    _showConfirmationDialog();
                                  }
                                },
                              ),
                              const SizedBox(height: SSizes.md2),

                              // Tampilkan SelectLocation atau PickupOption Berdasarkan Mode
                              if (isDelivery) ...[
                                Text(
                                  STexts.selectLocation,
                                  style: dark
                                      ? STextTheme.titleBaseBoldDark
                                      : STextTheme.titleBaseBoldLight,
                                ),
                                const SizedBox(height: SSizes.md),
                                const SelectLocation(),
                              ] else ...[
                                Text(
                                  STexts.pickUp,
                                  style: dark
                                      ? STextTheme.titleBaseBoldDark
                                      : STextTheme.titleBaseBoldLight,
                                ),
                                const SizedBox(height: SSizes.md),
                                const SeeAddressShop(),
                              ],

                              const SizedBox(height: SSizes.md2),

                              // Product Detail
                              Text(
                                STexts.productDetail,
                                style: dark
                                    ? STextTheme.titleBaseBoldDark
                                    : STextTheme.titleBaseBoldLight,
                              ),
                              const SizedBox(height: SSizes.md),

                              // Wrap DetailProductTransaction with SizedBox to constrain height
                              SizedBox(
                                height: MediaQuery.of(context).size.height * 0.5,
                                child: const DetailProductTransaction(),
                              ),
                            ],
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            STexts.subTotal,
                            style: dark
                                ? STextTheme.bodyCaptionRegularDark
                                : STextTheme.bodyCaptionRegularLight,
                          ),
                          const Spacer(),
                          Text(
                            "Rp 53.000",
                            style: dark
                                ? STextTheme.titleCaptionBoldDark
                                : STextTheme.titleCaptionBoldLight,
                          ),
                        ],
                      ),

                      const SizedBox(height: SSizes.md),

                      // Taxs
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            STexts.tax,
                            style: dark
                                ? STextTheme.bodyCaptionRegularDark
                                : STextTheme.bodyCaptionRegularLight,
                          ),
                          const Spacer(),
                          Text(
                            "Rp 5.000",
                            style: dark
                                ? STextTheme.titleCaptionBoldDark
                                : STextTheme.titleCaptionBoldLight,
                          ),
                        ],
                      ),

                      const SizedBox(height: SSizes.md),

                      // Delivery
                      isDelivery
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  STexts.postage,
                                  style: dark
                                      ? STextTheme.bodyCaptionRegularDark
                                      : STextTheme.bodyCaptionRegularLight,
                                ),
                                const Spacer(),
                                Text(
                                  "Rp 8.000",
                                  style: dark
                                      ? STextTheme.titleCaptionBoldDark
                                      : STextTheme.titleCaptionBoldLight,
                                ),
                              ],
                            )
                          : const SizedBox.shrink(),

                      const SizedBox(height: SSizes.md),

                      // Garis
                      Dash(
                        length: MediaQuery.of(context).size.width -
                            (SSizes.defaultMargin * 2),
                        dashLength: 4.0,
                        dashGap: 4.0,
                        direction: Axis.horizontal,
                        dashColor:
                            dark ? SColors.green50 : SColors.softBlack50,
                        dashBorderRadius: 4.0,
                      ),

                      const SizedBox(height: SSizes.md),

                      // Total
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            STexts.total,
                            style: dark
                                ? STextTheme.titleCaptionBoldDark
                                : STextTheme.titleCaptionBoldLight,
                          ),
                          const Spacer(),
                          Text(
                            "Rp 66.000",
                            style: STextTheme.titleBaseBoldDark.copyWith(
                              color: SColors.green500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: SSizes.md2 + SSizes.md),
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
