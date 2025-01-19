import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:segarku/commons/widget/appbar/appbar.dart';
import 'package:segarku/commons/widget/notification/widget/notification_item.dart';
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
          // SCustomAppBar dengan Divider di bawah
            Container(
              color: dark 
                ? SColors.pureBlack 
                : SColors.pureWhite, // Ganti dengan warna yang sesuai
              child: Column(
                children: [
                  // Padding di atas AppBar
                  const SizedBox(height: 20),
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
            ),

          const Expanded(
            child: Center(
              child: NotificationItemScreen(),
            ),
          ),
        ],
      ),
    );
  }
}
