import 'package:flutter/material.dart';
import 'package:segarku/utils/constants/appbar_welcome.dart';
import 'package:segarku/utils/constants/colors.dart';
import 'package:segarku/utils/constants/sizes.dart';
import 'package:segarku/utils/constants/text_strings.dart';
import 'package:segarku/utils/helpers/helper_functions.dart';
import 'package:segarku/utils/theme/custom_themes/text_theme.dart'; // Pastikan import ini ada untuk SColors

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Pilih warna background berdasarkan mode
    final backgroundColor = Theme.of(context).brightness == Brightness.dark
        ? SColors.pureBlack
        : SColors.pureWhite;

     final isDarkMode = SHelperFunctions.isDarkMode(context);

    return Scaffold(
      body: Stack(
        children: [
          // Background color
          Container(
            color: backgroundColor,
          ),
          // AppBarWelcome
          const AppBarWelcome(),

          Padding(
            padding: const EdgeInsets.only(
              left: SSizes.defaultMargin,
              right: SSizes.defaultMargin,
              top: 149),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(STexts.welcomeSegarku,
                 style: isDarkMode 
                  ? STextTheme.bodyMdRegularDark
                  : STextTheme.bodyMdRegularLight),
                
                const SizedBox(height: SSizes.xs),
            
                Text(STexts.loginSubTitle,
                 style: isDarkMode 
                  ? STextTheme.titleXlBlackDark
                  : STextTheme.titleXlBlackLight),

                const SizedBox(height: SSizes.lg2),
                
                
                
              ],
            ),
          ),
        ],
      ),
    );
  }
}
