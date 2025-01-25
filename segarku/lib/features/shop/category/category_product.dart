import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:segarku/commons/widget/appbar/appbar.dart';
import 'package:segarku/utils/constants/colors.dart';
import 'package:segarku/utils/constants/sizes.dart';
import 'package:segarku/utils/models/category.dart';
import 'package:segarku/utils/theme/custom_themes/text_theme.dart';
import '../../../../../utils/constants/text_strings.dart';

class CategoryProductScreen extends StatelessWidget {
  const CategoryProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool dark = context.isDarkMode;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // SCustomAppBar dengan Divider di bawah
            Container(
              color: dark 
                ? SColors.pureBlack 
                : SColors.pureWhite, // Ganti dengan warna yang sesuai
              child: Column(
                children: [
                  // Padding di atas AppBar
                  const SizedBox(height: 20),
                  SCustomAppBar(
                    title: STexts.category,
                    darkMode: dark, 
                  ),
                  const SizedBox(height: SSizes.md),
                  Divider(
                    color: dark ? SColors.green50 : SColors.softBlack50,
                    thickness: 1,
                    height: 1, // Pastikan tidak ada ruang tambahan
                  ),
                ],
              ),
            ),
        
            Padding(
              padding: const EdgeInsets.only(
                top: SSizes.lg,
                right: SSizes.defaultMargin,
                left: SSizes.defaultMargin
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // Title ke paling kiri
                children: [
                  Text(
                    STexts.allCategory,
                    style: dark
                        ? STextTheme.titleBaseBoldDark
                        : STextTheme.titleBaseBoldLight,
                  ),
                  const SCategory(),
                ],
              ),
            ),
              
            
          ],
        ),
      ),
    );
  }
}
