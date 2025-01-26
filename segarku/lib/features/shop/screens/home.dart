import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:segarku/commons/style/spacing_style.dart';
import 'package:segarku/features/shop/category/category_product.dart';
import 'package:segarku/features/shop/screens/widgets/home_appbar.dart';
import 'package:segarku/features/shop/screens/widgets/home_sliders.dart';
import 'package:segarku/utils/constants/colors.dart';
import 'package:segarku/utils/constants/icons.dart';
import 'package:segarku/utils/constants/sizes.dart';
import 'package:segarku/utils/constants/text_strings.dart';
import 'package:segarku/utils/helpers/helper_functions.dart';
import 'package:segarku/utils/models/fields_search.dart';
import 'package:segarku/utils/models/home_category.dart';
import 'package:segarku/utils/models/product_horizontal.dart';
import 'package:segarku/utils/models/product_vertical.dart';
import 'package:segarku/utils/theme/custom_themes/text_theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = SHelperFunctions.isDarkMode(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Bagian dengan padding
              Padding(
                padding: SSpacingStyle.paddingWithAppBarHeight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Appbar title & Notification
                    HomeAppBar(dark: dark),
                    const SizedBox(height: SSizes.md + SSizes.sm2),

                    // Search field
                    InputFieldSearch.fieldSearchHome(context, dark),

                    const SizedBox(height: SSizes.md),

                    // slider widget
                    const SliderWidget(),
                    const SizedBox(height: SSizes.lg),

                    // Text Kategori & SeeAllProduct
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          STexts.category,
                          style: dark
                              ? STextTheme.titleBaseBoldDark
                              : STextTheme.titleBaseBoldLight,
                        ),
                        GestureDetector(
                          onTap: () => Get.to(() => const CategoryProductScreen()),
                          child: const Row(
                            children: [
                              Text(
                                STexts.seeAllProduct,
                                style: STextTheme.ctaSm,
                              ),
                              SizedBox(width: SSizes.xs),
                              Icon(
                                SIcons.arrowRight,
                                color: SColors.green500,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: SSizes.md),

                    // Kategori Product
                    const SHomeCategories(),
                    const SizedBox(height: SSizes.md),
                  ],
                ),
              ),

              // Bagian dengan background color full width
              Container(
                color: dark ? SColors.softBlack300 : SColors.green50,
                padding: const EdgeInsets.only(left: SSizes.md, top: SSizes.lg, bottom: SSizes.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title Product Horizontal
                    Text(
                      STexts.specialToday,
                      style: dark
                          ? STextTheme.titleBaseBoldDark
                          : STextTheme.titleBaseBoldLight,
                    ),
                    // Product Horizontal
                    const SProductH(),
                  ],
                ),
              ),
              const SizedBox(height: SSizes.md2),

              // Bagian berikutnya
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: SSizes.defaultMargin),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title Product Vertical
                    Text(
                      STexts.allProduct,
                      style: dark
                          ? STextTheme.titleBaseBoldDark
                          : STextTheme.titleBaseBoldLight,
                    ),
                    const SizedBox(height: SSizes.md),

                    // Product Vertical
                    const SProductV(),
                    const SizedBox(height: SSizes.md),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
