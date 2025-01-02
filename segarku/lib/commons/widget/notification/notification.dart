import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:segarku/commons/widget/appbar/appbar.dart';
import 'package:segarku/commons/widget/notification/widget/no_notification.dart';
import 'package:segarku/utils/constants/colors.dart';
import 'package:segarku/utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool dark = context.isDarkMode;

    return Scaffold(
      body: Column(
        children: [
          // Padding di atas AppBar
          const SizedBox(height: 52),

          // SCustomAppBar dengan Divider di bawah
          Column(
            children: [
              SCustomAppBar(
                title: STexts.notification,
                darkMode: dark,
              ),
          const SizedBox(height: SSizes.md),
              Divider(
                color: dark ? SColors.green50 : SColors.softBlack50,
                thickness: 1,
                height: 1, // Pastikan tidak ada ruang tambahan
              ),
            ],
          ),

          const Expanded(
            child: Center(
              child: NoNotificationScreen(),
            ),
          ),
        ],
      ),
    );
  }
}
