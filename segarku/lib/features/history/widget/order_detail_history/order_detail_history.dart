import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:segarku/commons/widget/appbar/appbar.dart';
import 'package:segarku/features/history/widget/order_detail_history/widget/address_history.dart';
import 'package:segarku/features/history/widget/order_detail_history/widget/detail_product_history.dart';
import 'package:segarku/navigation_menu.dart';
import 'package:segarku/utils/constants/colors.dart';
import 'package:segarku/utils/constants/sizes.dart';
import 'package:segarku/utils/theme/custom_themes/text_theme.dart';
import '../../../../../../utils/constants/text_strings.dart';

class OrderDetailHistoryScreen extends StatefulWidget {
  const OrderDetailHistoryScreen({super.key});

  @override
  State<OrderDetailHistoryScreen> createState() =>
      _OrderDetailHistoryScreenState();
}

class _OrderDetailHistoryScreenState extends State<OrderDetailHistoryScreen> {
  bool isDelivery = true;

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

          // Main Content
          const Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AddressHistory(),
                  DetailProducthistory(),
                ],
              ),
            ),
          ),

          // Footer (Beli Lagi)
          Container(
            color: dark ? SColors.pureBlack : SColors.pureWhite,
            padding: const EdgeInsets.symmetric(horizontal: SSizes.defaultMargin),
            child: Column(
              mainAxisSize: MainAxisSize.min, // Membatasi tinggi minimum
              children: [
                const SizedBox(height: SSizes.md2),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigasi langsung ke halaman lain tanpa popup
                      Get.to(() => const NavigationMenu(initialIndex: 1));
                    },
                    child: const Text(
                      STexts.buyMore,
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
    );
  }
}