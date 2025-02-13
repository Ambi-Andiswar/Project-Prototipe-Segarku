import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:segarku/utils/constants/sizes.dart';
import 'package:segarku/utils/constants/colors.dart';
import 'package:segarku/utils/constants/text_strings.dart';
import 'package:segarku/utils/theme/custom_themes/text_theme.dart';

class ProfileShimmer extends StatelessWidget {
  final bool darkMode;

  const ProfileShimmer({super.key, required this.darkMode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Bagian judul profil TANPA shimmer
          Container(
            padding: const EdgeInsets.only(top: 70, bottom: 24),
            decoration: BoxDecoration(
              color: darkMode ? SColors.pureBlack : SColors.pureWhite,
              border: Border(
                bottom: BorderSide(
                  color: darkMode ? SColors.green50 : SColors.softBlack50,
                  width: 1.0,
                ),
              ),
            ),
            child: Center(
              child: Text(
                STexts.profile,
                style: darkMode
                    ? STextTheme.titleBaseBoldDark
                    : STextTheme.titleBaseBoldLight,
              ),
            ),
          ),
          // Bagian shimmer untuk konten lainnya
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: SSizes.md2),
                  Shimmer.fromColors(
                    baseColor: darkMode ? SColors.softBlack50 : SColors.green50,
                    highlightColor: darkMode ? SColors.green50 : SColors.softBlack50,
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      margin: const EdgeInsets.symmetric(horizontal: SSizes.defaultMargin),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(SSizes.borderRadiusmd),
                      ),
                    ),
                  ),
                  const SizedBox(height: SSizes.md2),
                  Shimmer.fromColors(
                    baseColor: darkMode ? SColors.softBlack50 : SColors.green50,
                    highlightColor: darkMode ? SColors.green50 : SColors.softBlack50,
                    child: Container(
                      width: double.infinity,
                      height: 100,
                      margin: const EdgeInsets.symmetric(horizontal: SSizes.defaultMargin),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(SSizes.borderRadiusmd),
                      ),
                    ),
                  ),
                  const SizedBox(height: SSizes.md2),
                  Shimmer.fromColors(
                    baseColor: darkMode ? SColors.softBlack50 : SColors.green50,
                    highlightColor: darkMode ? SColors.green50 : SColors.softBlack50,
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      margin: const EdgeInsets.symmetric(horizontal: SSizes.defaultMargin),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(SSizes.borderRadiusmd),
                      ),
                    ),
                  ),
                  const SizedBox(height: SSizes.md2),
                  Shimmer.fromColors(
                    baseColor: darkMode ? SColors.softBlack50 : SColors.green50,
                    highlightColor: darkMode ? SColors.green50 : SColors.softBlack50,
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      margin: const EdgeInsets.symmetric(horizontal: SSizes.defaultMargin),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(SSizes.borderRadiusmd),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}