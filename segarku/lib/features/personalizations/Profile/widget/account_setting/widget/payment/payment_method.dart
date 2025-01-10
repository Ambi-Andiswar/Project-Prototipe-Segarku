import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:segarku/commons/widget/appbar/appbar.dart';
import 'package:segarku/features/personalizations/Profile/widget/account_setting/widget/payment/no_payment.dart';
import 'package:segarku/utils/constants/colors.dart';
import 'package:segarku/utils/constants/sizes.dart';
import '../../../../../../../utils/constants/text_strings.dart';

class MyPaymentScreen extends StatelessWidget {
  const MyPaymentScreen({super.key});

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
                  title: STexts.metodePembayaran,
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

          const Padding(
            padding: EdgeInsets.all(SSizes.defaultMargin),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  NoPaymentMethodScreen(),
                ],
              ),
            ),
          )

        ]
      ),
    );
  }
}