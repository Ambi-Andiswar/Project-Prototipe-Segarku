import 'package:flutter/material.dart';
import 'package:segarku/features/transaction/widget/dialog_select_location.dart';
import 'package:segarku/utils/constants/colors.dart';
import 'package:segarku/utils/constants/icons.dart';
import 'package:segarku/utils/constants/sizes.dart';
import 'package:segarku/utils/constants/text_strings.dart';
import 'package:segarku/utils/theme/custom_themes/text_theme.dart';
import 'package:get/get.dart';

class SelectLocation extends StatelessWidget {
  const SelectLocation({super.key});

  @override
  Widget build(BuildContext context) {
    final bool dark = context.isDarkMode;

    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: dark ? SColors.softBlack50 : SColors.pureWhite,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          builder: (BuildContext context) {
            return const AddressPopup();
          },
        );
      },
      child: Container(
        padding: const EdgeInsets.all(SSizes.defaultMargin),
        decoration: BoxDecoration(
          color: dark ? SColors.pureBlack : SColors.pureWhite,
          borderRadius: BorderRadius.circular(SSizes.borderRadiusmd2),
          border: Border.all(color: SColors.green500),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  SIcons.location,
                  color: SColors.green500,
                  size: SSizes.defaultIconsm,
                ),
                const SizedBox(width: SSizes.sm2),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        STexts.address,
                        style: dark
                            ? STextTheme.bodyCaptionRegularDark
                            : STextTheme.bodyCaptionRegularLight,
                      ),
                      const SizedBox(height: SSizes.sm2),
                      Text(
                        STexts.exAddress,
                        style: (dark
                                ? STextTheme.bodyCaptionRegularDark
                                : STextTheme.bodyCaptionRegularLight)
                            .copyWith(
                          color: dark ? SColors.pureWhite : SColors.pureBlack,
                        ),
                      ),
                      const SizedBox(height: SSizes.md),
                      Row(
                        children: [
                          Text(
                            STexts.exUser,
                            style: dark
                                ? STextTheme.titleCaptionBoldDark
                                : STextTheme.titleCaptionBoldLight,
                          ),
                          const SizedBox(width: SSizes.sm2),
                          Text(
                            '•',
                            style: dark
                                ? STextTheme.bodyCaptionRegularDark
                                : STextTheme.bodyCaptionRegularLight,
                          ),
                          const SizedBox(width: SSizes.sm2),
                          Text(
                            STexts.exNumberphone,
                            style: dark
                                ? STextTheme.bodyCaptionRegularDark
                                : STextTheme.bodyCaptionRegularLight,
                          ),
                          const Spacer(),
                          const Icon(
                            SIcons.arrowRight,
                            color: SColors.green500,
                            size: SSizes.md2,
                          ),
                        ],
                      ),
                    ],
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
