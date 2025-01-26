import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:segarku/utils/constants/image_strings.dart';
import 'package:segarku/utils/constants/sizes.dart';
import 'package:segarku/utils/constants/text_strings.dart';
import 'package:segarku/utils/theme/custom_themes/text_theme.dart';

class NoResultScreen extends StatelessWidget {
  const NoResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool dark = context.isDarkMode;

    return Center(
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
            STexts.noResult,
            style: dark
                ? STextTheme.titleMdBoldDark
                : STextTheme.titleMdBoldLight,
            textAlign: TextAlign.center, // Pusatkan teks judul
          ),
          const SizedBox(height: SSizes.xs),
          // Subtitle
          Text(
            STexts.subNoResult,
            style: dark
                ? STextTheme.bodyCaptionRegularDark
                : STextTheme.bodyCaptionRegularLight,
            textAlign: TextAlign.center, // Pusatkan teks subtitle
          ),
        ],
      ),
    );
  }
}