import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:segarku/features/authentification/screens/welcome.dart';
import 'package:segarku/features/personalizations/Personal_Information/profile_screen.dart';
import 'package:segarku/features/personalizations/Profile/widget/account_setting/account_setting.dart';
import 'package:segarku/features/personalizations/Profile/widget/logout/logout.dart';
import 'package:segarku/features/personalizations/Profile/widget/user_profile/user_profile.dart';
import 'package:segarku/utils/constants/colors.dart';
import 'package:segarku/utils/constants/sizes.dart';
import 'package:segarku/utils/constants/text_strings.dart';
import 'package:segarku/utils/helpers/helper_functions.dart';
import 'package:segarku/utils/theme/custom_themes/text_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = SHelperFunctions.isDarkMode(context);
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 70, bottom: 24),
            decoration: BoxDecoration(
              color: dark ? SColors.pureBlack : SColors.pureWhite,
              border: Border(
                bottom: BorderSide(
                  color: dark ? SColors.green50 : SColors.softBlack50,
                  width: 1.0,
                ),
              ),
            ),
            child: Center(
              child: Text(
                STexts.profile,
                style: dark
                    ? STextTheme.titleBaseBoldDark
                    : STextTheme.titleBaseBoldLight,
              ),
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: SSizes.md2),

                  // Profil Pengguna
                  SUserProfileTitle(
                    onPressed: () => Get.to(() => const UserProfileScreen()),
                  ),

                  const SizedBox(height: SSizes.md2),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: SSizes.defaultMargin),
                    child: Divider(
                      color: dark ? SColors.green50 : SColors.softBlack50,
                      thickness: 1,
                    ),
                  ),

                  const SizedBox(height: SSizes.md2),

                  // Pengaturan Akun
                  AccountSetting(
                    onPressed: () {
                      // Tambahkan logika pengaturan akun
                    },
                  ),

                  const SizedBox(height: SSizes.md2),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: SSizes.defaultMargin),
                    child: Divider(
                      color: dark ? SColors.green50 : SColors.softBlack50,
                      thickness: 1,
                    ),
                  ),

                  const SizedBox(height: SSizes.md2),

                  // Logout
                  LogoutSetting(
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();
                      Get.offAll(() => const WelcomeScreen());
                    },
                  ),
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
