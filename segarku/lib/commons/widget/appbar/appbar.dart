import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:segarku/utils/constants/colors.dart';
import 'package:segarku/utils/constants/icons.dart';
import 'package:segarku/utils/constants/sizes.dart';
import 'package:segarku/utils/theme/custom_themes/text_theme.dart';

class SCustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool darkMode;

  const SCustomAppBar({
    super.key,
    required this.title,
    this.darkMode = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false, // Menghilangkan back button default
      backgroundColor: darkMode ? SColors.pureBlack : SColors.pureWhite,
      elevation: 0,
      title: SizedBox(
        height: preferredSize.height,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(100),
                border: Border.all(
                  color: darkMode ? SColors.softBlack50 : SColors.softBlack50,
                  width: 1,
                ),
              ),
              child: IconButton(
                padding: EdgeInsets.zero, // Menghapus padding default
                onPressed: () {
                  Get.back();
                },
                icon: Icon(
                  SIcons.left, // Gunakan ikon bawaan jika tidak ada `SIcons`
                  size: 24,
                  color: darkMode ? SColors.pureWhite : SColors.softBlack500,
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  title,
                  style: darkMode
                      ? STextTheme.titleBaseBlackDark
                      : STextTheme.titleBaseBlackLight,
                ),
              ),
            ),
            const SizedBox(
              height: SSizes.md,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(52); // Tinggi AppBar
}