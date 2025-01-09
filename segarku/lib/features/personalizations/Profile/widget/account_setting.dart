import 'package:flutter/material.dart';
import 'package:segarku/utils/constants/sizes.dart';
import 'package:segarku/utils/constants/colors.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';
import 'package:segarku/utils/constants/text_strings.dart';
import 'package:segarku/utils/theme/custom_themes/text_theme.dart';

class AccountSetting extends StatelessWidget {
  final VoidCallback onPressed;

  const AccountSetting({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final bool dark = context.isDarkMode;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: SSizes.defaultMargin),
      child: Container(
        padding: const EdgeInsets.all(SSizes.defaultMargin),
        decoration: BoxDecoration(
          color: dark ? SColors.pureBlack : SColors.pureWhite,
          borderRadius: BorderRadius.circular(SSizes.md),
          border: Border.all(color: SColors.softBlack50),
        ),
        child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              STexts.accountSettings,
              style: dark
                ? STextTheme.titleBaseBoldDark
                : STextTheme.titleBaseBoldLight
            ),

            const SizedBox(height: SSizes.lg),
            // Payment Method
            Row(
              children: [
                // Logo with background
                Container(
                  width: 40.0,
                  height: 40.0,
                  decoration: BoxDecoration(
                    color: SColors.green500,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child:const Center(
                    child: Icon(
                      Iconsax.empty_wallet,
                      size: 24.0,
                      color: SColors.pureWhite,
                    ),
                  ),
                ),

                const SizedBox(width: SSizes.md2),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        STexts.metodePembayaran,
                        style: dark
                          ? STextTheme.titleCaptionBoldDark
                          : STextTheme.titleCaptionBoldLight
                      ),
                      Text(
                        STexts.subMetodePembayaran,
                        style: dark
                          ? STextTheme.bodyCaptionRegularDark
                          : STextTheme.bodyCaptionRegularLight
                      ),
                    ],
                  ),
                ),

                IconButton(
                  onPressed: onPressed,
                  icon: Icon(
                    Iconsax.arrow_right_3,
                    color: dark ? SColors.pureWhite :  SColors.green700,
                  ),
                ),
              ],
            ),

            const SizedBox(height: SSizes.lg2),

            // Voucher
            Row(
              children: [
                // Logo with background
                Container(
                  width: 40.0,
                  height: 40.0,
                  decoration: BoxDecoration(
                    color: SColors.green500,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: const Center(
                    child: Icon(
                      Iconsax.ticket_discount4,
                      size: 24.0,
                      color: SColors.pureWhite,
                    ),
                  ),
                ),

                const SizedBox(width: SSizes.md2),

                // Name & Description
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        STexts.voucher,
                        style: dark
                          ? STextTheme.titleCaptionBoldDark
                          : STextTheme.titleCaptionBoldLight
                      ),
                      Text(
                        STexts.subVoucher,
                        style: dark
                          ? STextTheme.bodyCaptionRegularDark
                          : STextTheme.bodyCaptionRegularLight
                      ),
                    ],
                  ),
                ),

                IconButton(
                  onPressed: onPressed,
                  icon: Icon(
                    Iconsax.arrow_right_3,
                    color: dark ? SColors.pureWhite :  SColors.green700,
                  ),
                ),
              ],
            ),

            const SizedBox(height: SSizes.lg2),

            // Alamat Saya
            Row(
              children: [
                // Logo with background
                Container(
                  width: 40.0,
                  height: 40.0,
                  decoration: BoxDecoration(
                    color: SColors.green500,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: const Center(
                    child: Icon(
                      Iconsax.location,
                      size: 24.0,
                      color: SColors.pureWhite,
                    ),
                  ),
                ),

                const SizedBox(width: SSizes.md2),


                // Name & Description
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        STexts.myAddress,
                        style: dark
                          ? STextTheme.titleCaptionBoldDark
                          : STextTheme.titleCaptionBoldLight
                      ),
                      Text(
                        STexts.subMyAddress,
                        style: dark
                          ? STextTheme.bodyCaptionRegularDark
                          : STextTheme.bodyCaptionRegularLight
                      ),
                    ],
                  ),
                ),

                IconButton(
                  onPressed: onPressed,
                  icon: Icon(
                    Iconsax.arrow_right_3,
                    color: dark ? SColors.pureWhite :  SColors.green700,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}