import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:segarku/commons/widget/appbar/appbar.dart';
import 'package:segarku/utils/constants/colors.dart';
import 'package:segarku/utils/constants/sizes.dart';
import 'package:segarku/utils/models/fields_search.dart';
import 'package:segarku/utils/models/product_vertical.dart';
import '../../../../../utils/constants/text_strings.dart';

class ListProductScreen extends StatelessWidget {
  const ListProductScreen({super.key});

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
                    title: STexts.vegetable,
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
              padding: const EdgeInsets.symmetric(
                vertical: SSizes.lg,
                horizontal: SSizes.defaultMargin
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // Title ke paling kiri
                children: [

                  // Search field
                  InputFieldSearch.fieldSearchAll(context, dark),
                  const SizedBox(height: SSizes.md), 
        
                  const SProductV(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
