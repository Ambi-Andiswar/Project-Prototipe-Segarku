import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:segarku/commons/widget/appbar/appbar.dart';
import 'package:segarku/navigation_menu.dart';
import 'package:segarku/utils/constants/colors.dart';
import 'package:segarku/utils/constants/image_strings.dart';
import 'package:segarku/utils/constants/sizes.dart';
import 'package:segarku/utils/models/fields.dart';
import 'package:segarku/utils/theme/custom_themes/text_theme.dart';
import '../../../../../utils/constants/text_strings.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

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
                const SizedBox(height: 52),
                SCustomAppBar(
                  title: STexts.editProfile,
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

          Padding(
            padding: const EdgeInsets.all(SSizes.defaultMargin),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(SSizes.borderRadiusmd),
                    child: Image.asset(
                      SImages.profile,
                      width: 72,
                      height: 72,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: SSizes.lg2),


                  // Change Photo Button
                  GestureDetector(
                    onTap: () {},
                    child: const Text(
                      STexts.changePhotoProfile,
                      style: STextTheme.ctaSm,
                    ),
                  ),
                  const SizedBox(height: SSizes.xl),
                  InputFields.editUsernameField(context, dark),
                  const SizedBox(height: SSizes.md),
                  InputFields.editNameField(context, dark),
                  const SizedBox(height: SSizes.md),
                  InputFields.editEmailField(context, dark),
                  const SizedBox(height: SSizes.md),
                  InputFields.editNoPhoneField(context, dark),
                ],
              ),
            ),
          ),
        ]
      ),
      // Button Selesai di bagian bawah page
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(
          left: SSizes.defaultMargin,
          top: SSizes.defaultMargin,
          right: SSizes.defaultMargin,
          bottom: SSizes.lg2
        ),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => Get.to(() => const NavigationMenu(initialIndex: 3)),
            child: const Text(
              STexts.save,
              style: STextTheme.titleBaseBoldDark,
            ),
          ),
        ),
      ),
    );
  }
}