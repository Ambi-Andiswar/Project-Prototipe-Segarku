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
                    color: dark ? SColors.pureWhite : SColors.green700,
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
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: dark ? SColors.pureBlack : SColors.pureWhite,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(SSizes.borderRadiusmd),
          ),
          title: Text(
            STexts.logoutConfirmationTitle,
            style: dark
                ? STextTheme.titleCaptionBoldDark
                : STextTheme.titleCaptionBoldLight,
          ),
          content: Text(
            STexts.logoutConfirmationMessage,
            style: dark
                ? STextTheme.bodyCaptionRegularDark
                : STextTheme.bodyCaptionRegularLight,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                STexts.cancel,
                style: dark
                    ? STextTheme.bodyCaptionRegularDark
                    : STextTheme.bodyCaptionRegularLight,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                onConfirm();
              },
              child: const Text(
                STexts.confirm,
                style: TextStyle(color: SColors.danger500),
              ),
            ),
          ],
        );
      },
    );
  }
}
