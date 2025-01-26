import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:segarku/utils/constants/image_strings.dart';
import 'package:segarku/utils/constants/sizes.dart';
import 'package:segarku/utils/constants/text_strings.dart';
import 'package:segarku/utils/theme/custom_themes/text_theme.dart';

class NoHistoryScreen extends StatelessWidget {
  const NoHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool dark = context.isDarkMode;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: SSizes.defaultMargin),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Pusatkan secara vertikal
          crossAxisAlignment: CrossAxisAlignment.center, // Pusatkan secara horizontal
          children: [
            Image.asset(
              SImages.noResultFoundCollorfull,
              width: 254, // Lebar gambar sesuai permintaan
            ),
            const SizedBox(height: SSizes.xl),
            // Title
            Text(
              STexts.noHistoryCart,
              style: dark
                  ? STextTheme.titleMdBoldDark
                  : STextTheme.titleMdBoldLight,
            ),
            const SizedBox(height: SSizes.xs),
            Text(
              STexts.subnoHistoryCart,
              style: dark
                  ? STextTheme.bodyCaptionRegularDark
                  : STextTheme.bodyCaptionRegularLight,
            ),
          ],
        ),
      ),
    );
  }
}
