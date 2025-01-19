import 'package:flutter/material.dart';
import 'package:segarku/utils/constants/colors.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:segarku/utils/constants/image_strings.dart';
import 'package:segarku/utils/constants/sizes.dart';
import 'package:segarku/utils/theme/custom_themes/text_theme.dart';

class SUserProfileTitle extends StatelessWidget {
  final VoidCallback onPressed;
  final User? user; // Tambahkan parameter user

  const SUserProfileTitle({super.key, required this.onPressed, required this.user});

  @override
  Widget build(BuildContext context) {
    final bool dark = context.isDarkMode;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: SSizes.defaultMargin),
      child: Container(
        padding: const EdgeInsets.all(SSizes.defaultMargin),
        decoration: BoxDecoration(
          color: dark ? SColors.pureBlack : SColors.pureWhite,
          borderRadius: BorderRadius.circular(SSizes.borderRadiusmd),
          border: Border.all(color: SColors.softBlack50),
        ),
        child: Row(
          children: [
            // Profile Image
            LayoutBuilder(
              builder: (context, constraints) {
                final size = constraints.maxWidth * 0.12;
                return ClipRRect(
                  borderRadius: BorderRadius.circular(SSizes.borderRadiusmd),
                  child: user?.photoURL != null
                      ? Image.network(
                          user!.photoURL!,
                          width: size.clamp(38.0, 48.0),
                          height: size.clamp(38.0, 48.0),
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          SImages.profile, // Ganti dengan gambar default
                          width: size.clamp(38.0, 48.0),
                          height: size.clamp(38.0, 48.0),
                        ),
                );
              },
            ),

            const SizedBox(width: SSizes.defaultMargin),

            // Name & Email
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    user?.displayName ?? 'UserSegar',
                    style: dark
                        ? STextTheme.titleBaseBoldDark
                        : STextTheme.titleBaseBoldLight,
                  ),
                  Text(
                    user?.email ?? 'Email Tidak Diketahui', 
                    style: dark
                        ? STextTheme.bodyCaptionRegularDark
                        : STextTheme.bodyCaptionRegularLight,
                  ),
                ],
              ),
            ),

            IconButton(
              onPressed: onPressed,
              icon: const Icon(
                Iconsax.edit,
                color: SColors.green500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}