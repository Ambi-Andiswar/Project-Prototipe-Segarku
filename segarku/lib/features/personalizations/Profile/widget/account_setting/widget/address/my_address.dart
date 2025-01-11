import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:segarku/commons/widget/appbar/appbar.dart';
import 'package:segarku/utils/constants/colors.dart';
import 'package:segarku/utils/constants/sizes.dart';
import 'package:segarku/utils/constants/text_strings.dart';
import 'package:segarku/utils/constants/image_strings.dart';
import 'package:segarku/utils/theme/custom_themes/text_theme.dart';
import 'package:segarku/utils/models/fields.dart';
import 'package:segarku/utils/models/fields_search.dart';

class MyAddressScreen extends StatelessWidget {
  const MyAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool dark = context.isDarkMode;

    return Scaffold(
      body: Column(
        children: [
          // AppBar
          Container(
            color: dark ? SColors.pureBlack : SColors.pureWhite,
            child: Column(
              children: [
                const SizedBox(height: 20),
                SCustomAppBar(
                  title: STexts.address,
                  darkMode: dark,
                ),
                const SizedBox(height: SSizes.md),
                Divider(
                  color: dark ? SColors.green50 : SColors.softBlack50,
                  thickness: 1,
                  height: 1,
                ),
              ],
            ),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(SSizes.defaultMargin),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      STexts.selectLocation,
                      style: dark
                          ? STextTheme.titleBaseBoldDark
                          : STextTheme.titleBaseBoldLight,
                    ),
                    const SizedBox(height: SSizes.md),

                    InputFieldSearch.fieldSearchAddress(context, dark),
                    const SizedBox(height: SSizes.md),

                    Divider(
                      color: dark
                        ? SColors.green50
                        : SColors.softBlack50,
                      thickness: 1.0,
                    ),
                    const SizedBox(height: SSizes.md),

                    Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: const DecorationImage(
                              image: AssetImage(SImages.maps),
                              fit: BoxFit.cover,
                            ),
                          ),
                          height: 150,
                          width: double.infinity,
                        ),
                        Positioned(
                          bottom: 8,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: SColors.pureWhite,
                              borderRadius: BorderRadius.circular(32),
                              border: Border.all(color: SColors.green500),
                            ),
                            child: Row(
                              children: [
                                Image.asset(
                                  SImages.topRight,
                                  height: 12,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  STexts.directions,
                                  style: dark
                                      ? STextTheme.titleCaptionBoldDark
                                      : STextTheme.titleCaptionBoldLight,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: SSizes.md),

                    InputFields.addressField(context, dark),
                    const SizedBox(height: SSizes.md),

                    InputFields.addressRecordsField(context, dark),
                    const SizedBox(height: SSizes.md),

                    InputFields.recipientNameField(context, dark),
                    const SizedBox(height: SSizes.md),

                    InputFields.noHandphoneAddressField(context, dark),
                    const SizedBox(height: SSizes.md),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: SColors.green500,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Simpan',
                          style: dark
                              ? STextTheme.titleBaseBoldLight
                              : STextTheme.titleBaseBoldDark,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
