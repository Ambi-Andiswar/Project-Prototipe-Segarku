import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:segarku/commons/widget/notification/notification.dart';
import 'package:segarku/utils/constants/colors.dart';
import 'package:segarku/utils/constants/icons.dart';
import 'package:segarku/utils/theme/custom_themes/text_theme.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool dark;

  const HomeAppBar({super.key, required this.dark}); // Menggunakan super parameter

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false, // Menghilangkan tombol back
      titleSpacing: 0,

      // Appbar Title
      title:  RichText(
          text: TextSpan(
            text: 'Belanja ',
            style: dark 
              ? STextTheme.titleMdBoldDark
              : STextTheme.titleMdBoldLight,
            children: [
              TextSpan(
                text: 'buah ',
                style: (dark 
                  ? STextTheme.titleMdBoldDark 
                  : STextTheme.titleMdBoldLight
                  ).copyWith(
                    color: SColors.green500,
                  ),
              ),
              TextSpan(
                text: 'dan ',
                style: dark 
                  ? STextTheme.titleMdBoldDark
                  : STextTheme.titleMdBoldLight,
              ),
              TextSpan(
                text: 'sayur ',
                style: (dark 
                  ? STextTheme.titleMdBoldDark 
                  : STextTheme.titleMdBoldLight
                  ).copyWith(
                    color: SColors.green500,
                  ),
              ),
              TextSpan(
                text: 'mudah dan cepat.',
                style: dark 
                  ? STextTheme.titleMdBoldDark
                  : STextTheme.titleMdBoldLight,
              ),
            ],
        ),
      ),

      // Notification Button
      actions: [
        Container(
          width: 40,
          height: 40,
          alignment: Alignment.center,
          child: IconButton(
            padding: EdgeInsets.zero, // Menghilangkan padding bawaan
            constraints: const BoxConstraints(), // Menghilangkan batasan tambahan
            icon: SIcons.notificationIcon(dark),
            onPressed: ()  => Get.to(() => const NotificationScreen()),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
