import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:segarku/commons/widget/appbar/appbar.dart';
import 'package:segarku/features/transaction/widget/delivery_options.dart';
import 'package:segarku/features/transaction/widget/detail_product_transaction.dart';
import 'package:segarku/features/transaction/widget/see_address_shop.dart';
import 'package:segarku/features/transaction/widget/select_location.dart';
import 'package:segarku/features/transaction/widget/transaction_success.dart';
import 'package:segarku/utils/constants/colors.dart';
import 'package:segarku/utils/constants/icons.dart';
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
  bool isDelivery = true; // State untuk menentukan mode pengiriman

  // Fungsi untuk menampilkan dialog konfirmasi
  void _showConfirmationDialog({required bool isDelivery}) {
    final bool dark = context.isDarkMode;
    String selectedPaymentMethod = isDelivery ? 'delivery' : 'pickup'; // Pastikan sesuai status awal

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      backgroundColor: dark ? SColors.pureBlack : SColors.pureWhite,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                vertical: SSizes.md,
                horizontal: SSizes.defaultMargin,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    STexts.changepurchaseType,
                    style: dark
                        ? STextTheme.titleBaseBoldDark
                        : STextTheme.titleBaseBoldLight,
                  ),
                  const SizedBox(height: SSizes.md),

                  // Row for Options
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Option Delivery
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setModalState(() {
                              selectedPaymentMethod = 'delivery';
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(SSizes.md),
                            decoration: BoxDecoration(
                              color: selectedPaymentMethod == 'delivery'
                                  ? SColors.green100
                                  : null,
                              border: Border.all(
                                color: selectedPaymentMethod == 'delivery'
                                    ? SColors.green500
                                    : SColors.softBlack50,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                const CircleAvatar(
                                  radius: 20,
                                  backgroundColor: SColors.green500,
                                  child: Icon(
                                    SIcons.delivery,
                                    color: SColors.pureWhite,
                                    size: SSizes.defaultIcon,
                                  ),
                                ),
                                const SizedBox(width: SSizes.md),
                                Text(
                                  STexts.delivery,
                                  style: dark
                                      ? STextTheme.titleBaseBoldDark
                                      : STextTheme.titleBaseBoldLight,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: SSizes.md),

                      // Option Pick-Up
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setModalState(() {
                              selectedPaymentMethod = 'pickup';
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(SSizes.md),
                            decoration: BoxDecoration(
                              color: selectedPaymentMethod == 'pickup'
                                  ? SColors.green100
                                  : null,
                              border: Border.all(
                                color: selectedPaymentMethod == 'pickup'
                                    ? SColors.green500
                                    : SColors.softBlack50,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                const CircleAvatar(
                                  radius: 20,
                                  backgroundColor: SColors.green500,
                                  child: Icon(
                                    SIcons.pickUp,
                                    color: SColors.pureWhite,
                                    size: SSizes.defaultIcon,
                                  ),
                                ),
                                const SizedBox(width: SSizes.md),
                                Text(
                                  STexts.pickUp,
                                  style: dark
                                      ? STextTheme.titleBaseBoldDark
                                      : STextTheme.titleBaseBoldLight,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: SSizes.md),

                  // Button Save
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: SColors.green500,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          // Perbarui status global berdasarkan pilihan terakhir
                          this.isDelivery = selectedPaymentMethod == 'delivery';
                        });
                        Navigator.of(context).pop(); // Tutup popup
                      },
                      child: Text(
                        STexts.save,
                        style: dark
                            ? STextTheme.titleBaseBoldLight
                            : STextTheme.titleBaseBoldDark,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
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
                                    _showConfirmationDialog(isDelivery: isDelivery);
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
                      Row(
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
                      ),

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
                          onPressed: () =>
                              Get.to(() => const TransactionSuccess()),
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
