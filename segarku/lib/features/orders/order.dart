import 'package:flutter/material.dart';
import 'package:segarku/features/orders/widget/button_history.dart';
import 'package:segarku/features/orders/widget/history_all/all_history.dart';
import 'package:segarku/features/orders/widget/history_onproccess/onproccess_history.dart';
import 'package:segarku/features/orders/widget/history_done/done_history.dart';
import 'package:segarku/utils/constants/colors.dart';
import 'package:segarku/utils/constants/sizes.dart';
import 'package:segarku/utils/helpers/helper_functions.dart';
import 'package:segarku/utils/theme/custom_themes/text_theme.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  int activeIndex = 0;

  Widget _getOrderContent() {
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
                'Pesanan',
                style: darkMode
                    ? STextTheme.titleBaseBoldDark
                    : STextTheme.titleBaseBoldLight,
              ),
            ),
          ),

          // Widget tombol filter
          Padding(
            padding: const EdgeInsets.only(
              right: SSizes.defaultMargin,
              left: SSizes.defaultMargin,
              top: SSizes.md),
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
              child: _getOrderContent(),
            ),
          ),
        ],
      ),
    );
  }
}
