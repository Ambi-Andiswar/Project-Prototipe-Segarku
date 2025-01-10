import 'package:flutter/material.dart';
import 'package:segarku/utils/constants/colors.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';
import 'package:segarku/utils/constants/image_strings.dart';
import 'package:segarku/utils/constants/sizes.dart';
import 'package:segarku/utils/constants/text_strings.dart';
import 'package:segarku/utils/theme/custom_themes/text_theme.dart';

class SUserProfileTitle extends StatelessWidget {
  final VoidCallback onPressed;

  const SUserProfileTitle({super.key, required this.onPressed});

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
        child: Row(
          children: [
            // Profile Image
            LayoutBuilder(
              builder: (context, constraints) {
                final size = constraints.maxWidth * 0.12; // Responsif berdasarkan lebar kontainer
                return ClipRRect(
                  borderRadius: BorderRadius.circular(SSizes.borderRadiusmd),
                  child: Image.asset(
                    SImages.profile,
                    width: size.clamp(38.0, 48.0), // Ukuran minimum 40 dan maksimum 60
                    height: size.clamp(38.0, 48.0),
                  ),
                );
              },
            ),

            const SizedBox(width: SSizes.defaultMargin),

            // Name & Email
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    STexts.exUser,
                    style: dark
                      ? STextTheme.titleBaseBoldDark
                      : STextTheme.titleBaseBoldLight
                  ),
                  Text(
                    STexts.exEmail,
                    style: dark
                      ? STextTheme.bodyCaptionRegularDark
                      : STextTheme.bodyCaptionRegularLight
                  ),
                ],
              ),
            ),

            IconButton(
              onPressed: onPressed,
              icon: const Icon(
                Iconsax.edit,
                color: SColors.green500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
