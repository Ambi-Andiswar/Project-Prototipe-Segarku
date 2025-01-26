import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:segarku/commons/widget/search_page/search_page.dart';
import 'package:segarku/utils/constants/colors.dart';
import 'package:segarku/utils/constants/icons.dart';
import 'package:segarku/utils/constants/image_strings.dart';
import 'package:segarku/utils/constants/sizes.dart';
import 'package:segarku/utils/constants/text_strings.dart';
import 'package:segarku/utils/theme/custom_themes/text_theme.dart';

class InputFieldSearch {
  //-------------------- Field Search Home --------------------//
  static Widget fieldSearchHome(BuildContext context, bool dark) {
    return GestureDetector(
      onTap: () {
        // Navigasi ke halaman pencarian baru
        Get.to(() => const SearchPage());
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: SSizes.md2, vertical: SSizes.md),
        decoration: BoxDecoration(
          border: Border.all(
            color: dark ? SColors.green50 : SColors.softBlack50,
          ),
          borderRadius: BorderRadius.circular(99999),
        ),
        child: Row(
          children: [
            const Icon(
              SIcons.search,
              color: SColors.green500,
            ),
            const SizedBox(width: SSizes.sm),
            Text(
              STexts.fieldSearchHome,
              style: (dark
                  ? STextTheme.bodyBaseRegularLight
                  : STextTheme.bodyBaseRegularDark).copyWith(
                color: SColors.softBlack100,
              ),
            ),
          ],
        ),
      ),
    );
  }

  //-------------------- Field Search All --------------------//
  static Widget fieldSearchPage(
    BuildContext context,
    bool dark, {
    required FocusNode focusNode, // Terima FocusNode dari parent
    required bool isFocused, // Terima state fokus dari parent
    required Function(String) onChanged, // Terima fungsi onChanged
    required TextEditingController controller, 
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text & Icons Form Field search
        TextFormField(
          controller: controller,
          focusNode: focusNode, // Gunakan FocusNode dari parent
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: SSizes.md2, vertical: SSizes.md),
            // Menambahkan Icon di dalam field
            suffixIcon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: SSizes.md2, vertical: SSizes.md + 1),
              child: Icon(
                SIcons.search,
                color: isFocused
                    ? (dark ? SColors.green500 : SColors.green500)
                    : (dark ? SColors.softBlack50 : SColors.softBlack300),
              ),
            ),
            // Text search field
            labelText: STexts.fieldSearchHomeAll,
            labelStyle: dark
                ? STextTheme.bodyBaseRegularLight
                : STextTheme.bodyBaseRegularDark,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            hintText: STexts.fieldSearchHomeAll,
            hintStyle: dark
                ? STextTheme.bodyBaseRegularLight
                : STextTheme.bodyBaseRegularDark,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100),
              borderSide: const BorderSide(color: SColors.softBlack50),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100),
              borderSide: const BorderSide(color: SColors.green500),
            ),
          ),
          onChanged: onChanged, // Teruskan onChanged
        ),
      ],
    );
  }

  //-------------------- Field Search All --------------------//
  static Widget fieldSearchAll(BuildContext context, bool dark) {
    // FocusNode untuk mendeteksi fokus
    final FocusNode focusNode = FocusNode();
    bool isFocused = false;

    return StatefulBuilder(
      builder: (context, setState) {
        // Listener untuk fokus
        focusNode.addListener(() {
          setState(() {
            isFocused = focusNode.hasFocus;
          });
        });

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text & Icons Form Field search
            TextFormField(
              focusNode: focusNode,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: SSizes.md2, vertical: SSizes.md),
                // Menambahkan Icon di dalam field
                suffixIcon: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: SSizes.md2, vertical: SSizes.md+1),
                  child: Icon(
                    SIcons.search,
                    color: isFocused
                        ? (dark ? SColors.green500 : SColors.green500)
                        : (dark ? SColors.softBlack50 : SColors.softBlack300),
                  ),
                ),
                // Text search field
                labelText: STexts.fieldSearchHomeAll,
                labelStyle: dark
                    ? STextTheme.bodyBaseRegularLight
                    : STextTheme.bodyBaseRegularDark,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                hintText: STexts.fieldSearchHomeAll,
                hintStyle: dark
                    ? STextTheme.bodyBaseRegularLight 
                    : STextTheme.bodyBaseRegularDark,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100),
                  borderSide: const BorderSide(color: SColors.softBlack50),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100),
                  borderSide: const BorderSide(color: SColors.green500),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

    //-------------------- Field Search Address --------------------//
  static Widget fieldSearchAddress(BuildContext context, bool dark) {
  // FocusNode untuk mendeteksi fokus
  final FocusNode focusNode = FocusNode();

  return StatefulBuilder(
    builder: (context, setState) {
      // Listener untuk fokus
      focusNode.addListener(() {
        setState(() {
        });
      });

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text & Icons Form Field search
          TextFormField(
            focusNode: focusNode,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: SSizes.md2, vertical: SSizes.md),
              // Menambahkan gambar di bagian kiri field
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: SSizes.md2, vertical: SSizes.md + 1),
                child: Image.asset(
                  SImages.iconMaps, // Path dari gambar
                  fit: BoxFit.contain,
                ),
              ),
              // Text search field
              labelText: STexts.fieldAddress,
              labelStyle: dark
                  ? STextTheme.bodyBaseRegularLight
                  : STextTheme.bodyBaseRegularDark,
              floatingLabelBehavior: FloatingLabelBehavior.never,
              hintText: STexts.fieldSearchAddress,
              hintStyle: dark
                  ? STextTheme.bodyBaseRegularLight
                  : STextTheme.bodyBaseRegularDark,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(100),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(100),
                borderSide: const BorderSide(color: SColors.softBlack50),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(100),
                borderSide: const BorderSide(color: SColors.green500),
              ),
            ),
          ),
        ],
      );
    },
  );
}

}