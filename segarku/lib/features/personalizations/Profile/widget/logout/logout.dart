import 'package:flutter/material.dart';
import 'package:segarku/utils/constants/sizes.dart';
import 'package:segarku/utils/constants/colors.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';
import 'package:segarku/utils/constants/text_strings.dart';
import 'package:segarku/utils/theme/custom_themes/text_theme.dart';

class LogoutSetting extends StatelessWidget {
  final VoidCallback onPressed;

  const LogoutSetting({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final bool dark = context.isDarkMode;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: SSizes.defaultMargin),
      child: Container(
        padding: const EdgeInsets.all(SSizes.defaultMargin),
        decoration: BoxDecoration(
          color: dark ? SColors.pureBlack : SColors.pureWhite,
          borderRadius: BorderRadius.circular(SSizes.borderRadiusmd),
          border: Border.all(color: SColors.softBlack50),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 40.0,
                  height: 40.0,
                  decoration: BoxDecoration(
                    color: SColors.danger500,
                    borderRadius: BorderRadius.circular(SSizes.borderRadiusmd),
                  ),
                  child: const Center(
                    child: Icon(
                      Iconsax.logout,
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
                        STexts.logout,
                        style: dark
                            ? STextTheme.titleCaptionBoldDark
                            : STextTheme.titleCaptionBoldLight,
                      ),
                      Text(
                        STexts.subLogout,
                        style: dark
                            ? STextTheme.bodyCaptionRegularDark
                            : STextTheme.bodyCaptionRegularLight,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    showLogoutConfirmationDialog(context, onPressed);
                  },
                  icon: Icon(
                    Iconsax.arrow_right_3,
                    color: dark ? SColors.pureWhite : SColors.green500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void showLogoutConfirmationDialog(
    BuildContext context, VoidCallback onConfirm) {
      final bool dark = context.isDarkMode;
      showModalBottomSheet<bool>(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        builder: (context) => Padding(
          padding: const EdgeInsets.all(SSizes.defaultMargin),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                STexts.logoutConfirmationTitle,
                style: dark
                    ? STextTheme.titleBaseBoldDark
                    : STextTheme.titleBaseBoldLight,
              ),
              const SizedBox(height: SSizes.sm2),
              Text(
                STexts.logoutConfirmationMessage,
                style: dark
                    ? STextTheme.bodyBaseRegularDark
                    : STextTheme.bodyBaseRegularLight,
              ),
              const SizedBox(height: SSizes.lg),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(
                        STexts.cancel,
                        style: dark
                            ? STextTheme.titleBaseBoldDark
                            : STextTheme.titleBaseBoldLight,
                      ),
                    ),
                  ),
                  const SizedBox(width: SSizes.md),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        onConfirm();
                      },
                      child: Text(
                        STexts.confirm,
                        style: dark
                            ? STextTheme.titleBaseBoldLight
                            : STextTheme.titleBaseBoldDark,
                      ),
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
