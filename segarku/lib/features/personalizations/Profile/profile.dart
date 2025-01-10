import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:segarku/features/authentication/screens/welcome.dart';
import 'package:segarku/features/personalizations/Personal_Information/profile_screen.dart';
import 'package:segarku/features/personalizations/Profile/widget/account_setting/account_setting.dart';
import 'package:segarku/features/personalizations/Profile/widget/logout/logout.dart';
import 'package:segarku/features/personalizations/Profile/widget/user_profile/user_profile.dart';
import 'package:segarku/utils/constants/colors.dart';
import 'package:segarku/utils/constants/sizes.dart';
import 'package:segarku/utils/constants/text_strings.dart';
import 'package:segarku/utils/helpers/helper_functions.dart';
import 'package:segarku/utils/theme/custom_themes/text_theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = SHelperFunctions.isDarkMode(context);
    return Scaffold(
      body: Column(
        children: [
          // Kontainer di bagian atas
          Container(
            padding: const EdgeInsets.only(top: 70, bottom: 24),
            decoration: BoxDecoration(
              color: dark
                ? SColors.pureBlack
                : SColors.pureWhite,
              border: Border(
                bottom: BorderSide(
                  color: dark
                    ? SColors.green50
                    : SColors.softBlack50,
                  width: 1.0,
                ),
              ),
            ),
            child: Center(
              child: Text(
                STexts.profile,
                style: dark
                  ? STextTheme.titleBaseBoldDark
                  : STextTheme.titleBaseBoldLight
              ),
            ),
          ),

          // Konten Profil
          Expanded(
            child: SingleChildScrollView(
              child: 
                Column(
                  children: [
                    const SizedBox(height: SSizes.md),
                    SUserProfileTitle(
                      onPressed: () => Get.to(() => const UserProfileScreen())),
                
                    const SizedBox(height: SSizes.md2),
                    Padding(
                      padding:  const EdgeInsets.symmetric(horizontal: SSizes.defaultMargin),
                      child: Divider(
                        color: dark
                          ? SColors.green50
                          : SColors.softBlack50,
                        thickness: 1,
                        ),
                    ),
                
                    const SizedBox(height: SSizes.md2),
                    AccountSetting(
                      onPressed: () {}),
                    
                    const SizedBox(height: SSizes.md2),
                    Padding(
                      padding:  const EdgeInsets.symmetric(horizontal: SSizes.defaultMargin),
                      child: Divider(
                        color: dark ? SColors.green50 : SColors.softBlack50,
                        thickness: 1,
                        ),
                    ),
                
                    const SizedBox(height: SSizes.md2),
                    LogoutSetting(
                      onPressed: () => Get.to(() => const WelcomeScreen())),
                    const SizedBox(height: SSizes.md2),
                  ],
                ),
            ),
          ),
        ],
      ),
    );
  }
}