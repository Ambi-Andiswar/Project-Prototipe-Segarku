import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:segarku/commons/widget/appbar/appbar.dart';
import 'package:segarku/features/authentication/screens/forgetPass/confirm_email.dart';
import 'package:segarku/features/authentication/screens/welcome.dart';
import 'package:segarku/utils/constants/colors.dart';
import 'package:segarku/utils/constants/sizes.dart';
import 'package:segarku/utils/models/fields.dart';
import 'package:segarku/utils/theme/custom_themes/text_theme.dart';
import '../../../../../utils/constants/text_strings.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool dark = context.isDarkMode;

    return Scaffold(
      body: Column(
        children: [
          

          // SCustomAppBar dengan Divider di bawah
          Container(
            color: dark 
              ? SColors.pureBlack 
              : SColors.pureWhite, // Ganti dengan warna yang sesuai
            child: Column(
              children: [
                // Padding di atas AppBar
                const SizedBox(height: 52),
                SCustomAppBar(
                  title: STexts.resetPassword,
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

          // Konten utama
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: SSizes.defaultMargin),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: SSizes.lg2),

                              // Title
                              Text(
                                STexts.resetPasswordTitle,
                                style: dark
                                    ? STextTheme.titleLgBolddark
                                    : STextTheme.titleLgBoldLight,
                              ),
                              const SizedBox(height: SSizes.xs),

                              // Subtitle
                              Text(
                                STexts.resetPasswordSubTitle,
                                style: dark
                                    ? STextTheme.bodyCaptionRegularDark
                                    : STextTheme.bodyCaptionRegularLight,
                              ),
                              const SizedBox(height: SSizes.lg2),

                              // Email
                              InputFields.emailField(context, dark),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            STexts.rememberpassword,
                            style: dark
                                ? STextTheme.bodyCaptionRegularDark
                                : STextTheme.bodyCaptionRegularLight,
                          ),
                          const SizedBox(width: SSizes.sm),
                          TextButton(
                            onPressed: () => Get.to(() => const WelcomeScreen()),
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: const Text(
                              STexts.login,
                              style: STextTheme.ctaSm,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: SSizes.md2),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => Get.to(() => const ConfirmEmailPassScreen()),
                          child: const Text(
                            STexts.send,
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
          ),
        ],
      ),
    );
  }
}
