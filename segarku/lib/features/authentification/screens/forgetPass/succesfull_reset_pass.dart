import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:segarku/features/authentification/screens/welcome.dart';
import 'package:segarku/utils/constants/sizes.dart';
import 'package:segarku/utils/theme/custom_themes/text_theme.dart';
import '../../../../../utils/constants/text_strings.dart';

class SuccesfullResetPassScreen extends StatelessWidget {
  const SuccesfullResetPassScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool dark = context.isDarkMode;

    return Scaffold(
      body: Column(
        children: [
          // Bagian konten utama (di tengah)
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // GIF
                    Image.asset(
                      'assets/images/verified1.gif',
                      height: 150, // Sesuaikan tinggi GIF sesuai kebutuhan
                    ),

                    const SizedBox(height: SSizes.md2),

                    // Title
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 90),
                      child: Text(
                        STexts.succesfullResetPassTitle,
                        style: dark
                            ? STextTheme.titleLgBolddark
                            : STextTheme.titleLgBoldLight,
                        textAlign: TextAlign.center, // Pusatkan teks
                      ),
                    ),

                    const SizedBox(height: SSizes.xs),

                    // Subtitle
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: SSizes.defaultMargin),
                      child: Text(
                        STexts.succesfullResetPassSubTitle,
                        style: dark
                            ? STextTheme.bodyCaptionRegularDark
                            : STextTheme.bodyCaptionRegularLight,
                        textAlign: TextAlign.center, // Pusatkan teks
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Bagian bawah (tombol)
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: SSizes.defaultMargin,
              vertical: SSizes.lg,
            ),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Get.to(() => const WelcomeScreen(isLogin: true));
                },
                child: Text(
                  STexts.loginAgain,
                  style: dark
                      ? STextTheme.titleBaseBoldLight
                      : STextTheme.titleBaseBoldDark,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}