import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:segarku/commons/widget/appbar/appbar.dart';
import 'package:segarku/features/personalizations/Profile/widget/account_setting/widget/Voucher/widget/voucher.dart';
import 'package:segarku/utils/constants/colors.dart';
import 'package:segarku/utils/constants/sizes.dart';
import '../../../../../../../utils/constants/text_strings.dart';

class MyVoucherScreen extends StatelessWidget {
  const MyVoucherScreen({super.key});

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
                    title: STexts.voucher,
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

            // Body
            const Expanded( // Pastikan menggunakan Expanded di sini
              child: Padding(
                padding: EdgeInsets.all(SSizes.defaultMargin),
                child: VoucherScreen(), // VoucherScreen tidak perlu dibungkus SingleChildScrollView
              ),
            ),
          ],
        ),
      );
    }
}
