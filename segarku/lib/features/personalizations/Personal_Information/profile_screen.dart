import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    final User? user = FirebaseAuth.instance.currentUser; // Dapatkan data user dari FirebaseAuth

    return Scaffold(
      resizeToAvoidBottomInset:true, // Penting untuk menghindari tumpang tindih keyboard
      body: SafeArea(
        child: Column(
          children: [
            // AppBar
            Container(
              color: dark ? SColors.pureBlack : SColors.pureWhite,
              child: Column(
                children: [
                  const SizedBox(height: 20),
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

            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(SSizes.defaultMargin),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Profile Image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(SSizes.borderRadiusmd),
                        child: user?.photoURL != null
                            ? Image.network(
                                user!.photoURL!,
                                width: 72,
                                height: 72,
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                SImages.profile, // Gambar default
                                width: 72,
                                height: 72,
                                fit: BoxFit.cover,
                              ),
                      ),
                      const SizedBox(height: SSizes.lg2),

                      // Change Photo Button
                      GestureDetector(
                        onTap: () {
                          // Tambahkan aksi untuk mengubah foto profil
                        },
                        child: const Text(
                          STexts.changePhotoProfile,
                          style: STextTheme.ctaSm,
                        ),
                      ),
                      const SizedBox(height: SSizes.xl),

                      // Input Fields dengan data user
                      InputFields.usernameProfileField(context, dark, initialValue: user?.displayName ?? ''),
                      const SizedBox(height: SSizes.md),
                      InputFields.editEmailField(context, dark, initialValue: user?.email ?? ''),
                      const SizedBox(height: SSizes.md),
                      InputFields.editNoPhoneField(context, dark, initialValue: user?.phoneNumber ?? ''),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      // Button Selesai di bagian bawah page
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(
          left: SSizes.defaultMargin,
          top: SSizes.defaultMargin,
          right: SSizes.defaultMargin,
          bottom: SSizes.lg2,
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SizedBox(
              width: constraints.maxWidth,
              child: ElevatedButton(
                onPressed: () => Get.to(() => const NavigationMenu(initialIndex: 3)),
                child:  Text(
                  STexts.save,
                  style: dark
                    ? STextTheme.titleBaseBoldLight
                    : STextTheme.titleBaseBoldDark,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
