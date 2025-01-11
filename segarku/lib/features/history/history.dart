import 'package:flutter/material.dart';
import 'package:segarku/features/history/widget/button_history.dart';
import 'package:segarku/features/history/widget/history_all/all_history.dart';
import 'package:segarku/features/history/widget/history_onproccess/onproccess_history.dart';
import 'package:segarku/features/history/widget/history_done/done_history.dart';
import 'package:segarku/utils/constants/colors.dart';
import 'package:segarku/utils/constants/sizes.dart';
import 'package:segarku/utils/helpers/helper_functions.dart';
import 'package:segarku/utils/theme/custom_themes/text_theme.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  int activeIndex = 0;

  Widget _getHistoryContent() {
    switch (activeIndex) {
      case 0:
        return const AllProductHistory();
      case 1:
        return const OnproccessHistory();
      case 2:
        return const DoneHistory();
      default:
        return const AllProductHistory();
    }
  }

  @override
  Widget build(BuildContext context) {
    final darkMode = SHelperFunctions.isDarkMode(context);

    return Scaffold(
      body: Column(
        children: [
          // Kontainer di bagian atas
          Container(
            padding: const EdgeInsets.only(top: 70, bottom: 24),
            decoration: BoxDecoration(
              color: darkMode ? SColors.pureBlack : SColors.pureWhite,
              border: Border(
                bottom: BorderSide(
                  color: darkMode ? SColors.green50 : SColors.softBlack50,
                  width: 1.0,
                ),
              ),
            ),
            child: Center(
              child: Text(
                'Riwayat Transaksi',
                style: darkMode
                    ? STextTheme.titleBaseBoldDark
                    : STextTheme.titleBaseBoldLight,
              ),
            ),
          ),

          // Widget tombol filter
          Padding(
            padding: const EdgeInsets.symmetric(vertical: SSizes.defaultMargin, horizontal: SSizes.md),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ToggleButtonHistory(
                  label: 'Semua',
                  isActive: activeIndex == 0,
                  onPressed: () {
                    setState(() {
                      activeIndex = 0;
                    });
                  },
                ),
                const SizedBox(width: SSizes.sm2),
                ToggleButtonHistory(
                  label: 'Dalam proses',
                  isActive: activeIndex == 1,
                  onPressed: () {
                    setState(() {
                      activeIndex = 1;
                    });
                  },
                ),
                const SizedBox(width: SSizes.sm2),
                ToggleButtonHistory(
                  label: 'Selesai',
                  isActive: activeIndex == 2,
                  onPressed: () {
                    setState(() {
                      activeIndex = 2;
                    });
                  },
                ),
              ],
            ),
          ),

          // Konten di tengah-tengah layar
          Expanded(
            child: Center(
              child: _getHistoryContent(),
            ),
          ),
        ],
      ),
    );
  }
}
