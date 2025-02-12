import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:segarku/commons/widget/appbar/appbar.dart';
import 'package:segarku/features/orders/widget/history_all/all_history.dart';
import 'package:segarku/utils/constants/colors.dart';
import 'package:segarku/utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';

class HistoryOrderProfile extends StatelessWidget {
  const HistoryOrderProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final bool dark = context.isDarkMode;

    return Scaffold(
      body: Column(
        children: [
          Container(
            color: dark ? SColors.pureBlack : SColors.pureWhite,
            child: Column(
              children: [
                const SizedBox(height: 20),
                SCustomAppBar(
                  title: STexts.history,
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
          const Expanded(
            child: AllProductHistory(), // Langsung gunakan AllProductHistory() di sini
          ),
        ],
      ),
    );
  }
}