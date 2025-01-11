import 'package:flutter/material.dart';
import 'package:segarku/utils/constants/colors.dart';
import 'package:segarku/utils/constants/icons.dart';
import 'package:segarku/utils/constants/sizes.dart';
import 'package:segarku/utils/constants/text_strings.dart';
import 'package:segarku/utils/theme/custom_themes/text_theme.dart';
import 'package:get/get.dart';

class AddressHistory extends StatelessWidget {
  const AddressHistory({super.key,});

  @override
  Widget build(BuildContext context) {
    final bool dark = context.isDarkMode;

    return Container(
      margin: const EdgeInsets.only(
        left: SSizes.defaultMargin,
        top: SSizes.defaultMargin,
        right: SSizes.defaultMargin,
      ), // Padding luar kontainer
      decoration: BoxDecoration(
        color: SColors.green100,
        borderRadius: BorderRadius.circular(SSizes.borderRadiussm),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Teks Delivery Title
          Padding(
            padding: const EdgeInsets.only(
              top: SSizes.sm2,
              bottom: SSizes.sm2,
              left: SSizes.md2,
            ),
            child: Text(
              STexts.done, // Ganti teks
              style: STextTheme.titleCaptionBoldLight.copyWith(
                color: SColors.green500,
              ),
            ),
          ),

          // Container kedua
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(SSizes.borderRadiussm),
              border: Border.all(
                color: dark ? SColors.green50 : SColors.softBlack50,
              ),
            ),
            padding: const EdgeInsets.all(
              SSizes.defaultMargin
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Alamat Pengiriman',
                  style: dark
                      ? STextTheme.titleBaseBoldDark
                      : STextTheme.titleBaseBoldLight,
                ),
                const SizedBox(height: SSizes.sm2),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: SColors.green500),
                    borderRadius: BorderRadius.circular(SSizes.borderRadiusmd2),
                  ),
                  padding: const EdgeInsets.all(SSizes.sm2),
                  child: Row(
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
                                
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
