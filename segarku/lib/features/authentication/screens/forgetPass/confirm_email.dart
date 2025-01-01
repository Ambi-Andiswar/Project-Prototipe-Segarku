import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:segarku/commons/style/spacing_style.dart';
import 'package:segarku/features/authentication/screens/welcome.dart';
import 'package:segarku/utils/constants/colors.dart';
import 'package:segarku/utils/constants/icons.dart';
import 'package:segarku/utils/constants/sizes.dart';
import 'package:segarku/utils/theme/custom_themes/text_theme.dart';
import '../../../../../utils/constants/text_strings.dart';

class ConfirmEmailPassScreen extends StatelessWidget {
  const ConfirmEmailPassScreen ({super.key});

  @override
  Widget build(BuildContext context) {
    final bool dark = context.isDarkMode;
    return Scaffold(
      body: Column(
        children: [
          // Bagian konten utama
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: SSpacingStyle.paddingWithAppBarHeight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Back button
                        Row(
                          children: [
                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: dark ? Colors.black : SColors.pureWhite,
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(
                                  color: SColors.softBlack50,
                                  width: 1,
                                ),
                              ),
                              child: IconButton(
                                onPressed: () {
                                  Get.back();
                                },
                                icon: Icon(
                                  SIcons.left,
                                  size: 24,
                                  color: dark ? SColors.pureWhite : SColors.softBlack500,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: Text(
                                  STexts.confirmEmail,
                                  style: dark
                                      ? STextTheme.titleBaseBlackDark
                                      : STextTheme.titleBaseBlackLight,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: SSizes.md),
                      ],
                    ),
                  ),

                  // Divider di bawah resetPasswordTitle
                  Divider(
                    thickness: 1,
                    color: dark ? SColors.softBlack50 : SColors.softBlack50,
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: SSizes.defaultMargin),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: SSizes.lg2),

                        // Title
                        Text(
                          STexts.confirmEmailResetPasswordTitle,
                          style: dark
                              ? STextTheme.titleLgBolddark
                              : STextTheme.titleLgBoldLight,
                        ),

                        const SizedBox(height: SSizes.xs),

                        // Subtitle
                        Text(
                          STexts.confirmEmailResetPasswordSubTitle,
                          style: dark
                              ? STextTheme.bodyCaptionRegularDark
                              : STextTheme.bodyCaptionRegularLight,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Bagian bawah
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: SSizes.defaultMargin),
            child: Column(
              children: [
                // Text Login Now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // text non activ
                    Text(
                      STexts.noEmailSend,
                      style: dark
                          ? STextTheme.bodyCaptionRegularDark
                          : STextTheme.bodyCaptionRegularLight,
                    ),

                    const SizedBox(width: SSizes.sm),
                    // Text Active/button text
                    TextButton(
                      onPressed: () => Get.to(() => const WelcomeScreen()),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: const Text(
                        STexts.resend,
                        style: STextTheme.ctaSm,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: SSizes.md2),

                // Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Get.to(() => const WelcomeScreen()),
                    child: const Text(
                      STexts.done,
                      style: STextTheme.titleBaseBoldDark,
                    ),
                  ),
                ),
                const SizedBox(height: SSizes.xl),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
