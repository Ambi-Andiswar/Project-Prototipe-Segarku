import 'package:flutter/material.dart';
import 'package:segarku/features/authentification/screens/forgetPass/forget_password.dart';
import 'package:segarku/features/orders/widget/history_profile/history_order_profile.dart';
import 'package:segarku/features/personalizations/Profile/widget/account_setting/widget/address/my_address.dart';
import 'package:segarku/utils/constants/icons.dart';
import 'package:segarku/utils/constants/sizes.dart';
import 'package:segarku/utils/constants/colors.dart';
import 'package:url_launcher/url_launcher.dart';
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
            // // Nottifikasi
            // InkWell(
            //   onTap: () => Get.to(() => const NotificationScreen()),
            //   child: Row(
            //     children: [
            //       // Logo with background
            //       Container(
            //         width: 40.0,
            //         height: 40.0,
            //         decoration: BoxDecoration(
            //           color: SColors.green500,
            //           borderRadius: BorderRadius.circular(SSizes.borderRadiusmd),
            //         ),
            //         child: const Center(
            //           child: Icon(
            //             SIcons.notification,
            //             size: SSizes.defaultIcon,
            //             color: SColors.pureWhite,
            //           ),
            //         ),
            //       ),

            //       const SizedBox(width: SSizes.md2),

            //       Expanded(
            //         child: Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: [
            //             Text(
            //               STexts.notification,
            //               style: dark
            //                   ? STextTheme.titleCaptionBoldDark
            //                   : STextTheme.titleCaptionBoldLight,
            //             ),
            //             Text(
            //               STexts.subNoNotificationProfile,
            //               style: dark
            //                   ? STextTheme.bodyCaptionRegularDark
            //                   : STextTheme.bodyCaptionRegularLight,
            //             ),
            //           ],
            //         ),
            //       ),

            //       Icon(
            //         Iconsax.arrow_right_3,
            //         color: dark ? SColors.pureWhite : SColors.green500,
            //       ),
            //     ],
            //   ),
            // ),

            // const SizedBox(height: SSizes.lg),

            // Chat Admin
            InkWell(
              onTap: () {
                // Membuka tautan WhatsApp dengan pesan default
                const phoneNumber = "6281379153318";
                const message = "Halo, saya ingin bertanya sesuatu Min..."; 
                final url = "https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}";

                launchUrl(
                  Uri.parse(url),
                  mode: LaunchMode.externalApplication,
                );
              },
              child: Row(
                children: [

                  Container(
                    width: 40.0,
                    height: 40.0,
                    decoration: BoxDecoration(
                      color: SColors.green500,
                      borderRadius: BorderRadius.circular(SSizes.borderRadiusmd),
                    ),
                    child: const Center(
                      child: Icon(
                        SIcons.chat,
                        size: SSizes.defaultIcon,
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
                          STexts.chat,
                          style: dark
                              ? STextTheme.titleCaptionBoldDark
                              : STextTheme.titleCaptionBoldLight,
                        ),
                        Text(
                          STexts.subChat,
                          style: dark
                              ? STextTheme.bodyCaptionRegularDark
                              : STextTheme.bodyCaptionRegularLight,
                        ),
                      ],
                    ),
                  ),

                  // Arrow Icon
                  Icon(
                    Iconsax.arrow_right_3,
                    color: dark ? SColors.pureWhite : SColors.green500,
                  ),
                ],
              ),
            ),

            const SizedBox(height: SSizes.lg),

            // Alamat Saya
            InkWell(
              onTap: () => Get.to(() => const MyAddressScreen()),
              child: Row(
                children: [
                  // Logo with background
                  Container(
                    width: 40.0,
                    height: 40.0,
                    decoration: BoxDecoration(
                      color: SColors.green500,
                      borderRadius: BorderRadius.circular(SSizes.borderRadiusmd),
                    ),
                    child: const Center(
                      child: Icon(
                        Iconsax.location,
                        size: SSizes.defaultIcon,
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
                              : STextTheme.titleCaptionBoldLight,
                        ),
                        Text(
                          STexts.subMyAddress,
                          style: dark
                              ? STextTheme.bodyCaptionRegularDark
                              : STextTheme.bodyCaptionRegularLight,
                        ),
                      ],
                    ),
                  ),

                  Icon(
                    Iconsax.arrow_right_3,
                    color: dark ? SColors.pureWhite : SColors.green500,
                  ),
                ],
              ),
            ),

            const SizedBox(height: SSizes.lg),

            // history
            InkWell(
              onTap: () => Get.to(() => const HistoryOrderProfile()),
              child: Row(
                children: [
                  // Logo with background
                  Container(
                    width: 40.0,
                    height: 40.0,
                    decoration: BoxDecoration(
                      color: SColors.green500,
                      borderRadius: BorderRadius.circular(SSizes.borderRadiusmd),
                    ),
                    child: const Center(
                      child: Icon(
                        SIcons.history,
                        size: SSizes.defaultIcon,
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
                          STexts.order,
                          style: dark
                              ? STextTheme.titleCaptionBoldDark
                              : STextTheme.titleCaptionBoldLight,
                        ),
                        Text(
                          STexts.subOrder,
                          style: dark
                              ? STextTheme.bodyCaptionRegularDark
                              : STextTheme.bodyCaptionRegularLight,
                        ),
                      ],
                    ),
                  ),

                  Icon(
                    Iconsax.arrow_right_3,
                    color: dark ? SColors.pureWhite : SColors.green500,
                  ),
                ],
              ),
            ),

            const SizedBox(height: SSizes.lg),

            // Reset Password
            InkWell(
              onTap: () => Get.to(() => const ResetPasswordScreen()),
              child: Row(
                children: [
                  // Logo with background
                  Container(
                    width: 40.0,
                    height: 40.0,
                    decoration: BoxDecoration(
                      color: SColors.green500,
                      borderRadius: BorderRadius.circular(SSizes.borderRadiusmd),
                    ),
                    child: const Center(
                      child: Icon(
                        SIcons.forgetPassword,
                        size: SSizes.defaultIcon,
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
                          STexts.resetPasswordProfile,
                          style: dark
                              ? STextTheme.titleCaptionBoldDark
                              : STextTheme.titleCaptionBoldLight,
                        ),
                        Text(
                          STexts.subresetPasswordProfile,
                          style: dark
                              ? STextTheme.bodyCaptionRegularDark
                              : STextTheme.bodyCaptionRegularLight,
                        ),
                      ],
                    ),
                  ),

                  Icon(
                    Iconsax.arrow_right_3,
                    color: dark ? SColors.pureWhite : SColors.green500,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}