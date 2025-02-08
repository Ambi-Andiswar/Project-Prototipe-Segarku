import 'package:flutter/material.dart';
import 'package:segarku/utils/constants/colors.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';
import 'package:segarku/utils/local_storage/user_storage.dart';
import 'package:segarku/utils/constants/image_strings.dart';
import 'package:segarku/utils/constants/sizes.dart';
import 'package:segarku/utils/theme/custom_themes/text_theme.dart';

class SUserProfileTitle extends StatefulWidget {
  final VoidCallback onPressed;

  const SUserProfileTitle({super.key, required this.onPressed});

  @override
  _SUserProfileTitleState createState() => _SUserProfileTitleState();
}

class _SUserProfileTitleState extends State<SUserProfileTitle> {
  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final data = await UserStorage.getUserData();
    setState(() {
      userData = data;
    });
  }

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
                  child: userData?['photoUrl'] != null && userData!['photoUrl'].isNotEmpty
                      ? Image.network(
                          userData!['photoUrl'],
                          width: size.clamp(38.0, 48.0),
                          height: size.clamp(38.0, 48.0),
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              SImages.profile,
                              width: size.clamp(38.0, 48.0),
                              height: size.clamp(38.0, 48.0),
                            );
                          },
                        )
                      : Image.asset(
                          SImages.profile,
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
                    userData?['nama'] ?? 'UserSegar', // Menggunakan 'name' sesuai data Google
                    style: dark
                        ? STextTheme.titleBaseBoldDark
                        : STextTheme.titleBaseBoldLight,
                  ),
                  Text(
                    userData?['email'] ?? 'Email Tidak Diketahui',
                    style: dark
                        ? STextTheme.bodyCaptionRegularDark
                        : STextTheme.bodyCaptionRegularLight,
                  ),
                ],
              ),
            ),

            IconButton(
              onPressed: widget.onPressed,
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