import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:segarku/features/carts/cart.dart';
import 'package:segarku/features/history/order.dart';
import 'package:segarku/features/personalizations/Profile/profile.dart';
import 'package:segarku/features/shop/screens/home.dart';
import 'package:segarku/utils/constants/drop_shadow.dart';
import 'package:segarku/utils/constants/icons.dart';
import 'package:segarku/utils/helpers/helper_functions.dart';
import 'package:segarku/utils/constants/colors.dart';
import 'package:segarku/utils/theme/custom_themes/text_theme.dart';

class NavigationMenu extends StatelessWidget {
  final int initialIndex; // Menambahkan parameter untuk tab awal

  const NavigationMenu({super.key, this.initialIndex = 0});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());

    // Set initial index di luar build phase
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.selectedIndex.value = initialIndex;
    });

    final darkMode = SHelperFunctions.isDarkMode(context);

    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBarTheme(
          data: NavigationBarThemeData(
            indicatorColor: Colors.transparent,
            labelTextStyle: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.selected)) {
                return STextTheme.selectText; // Gaya saat terpilih
              }
              return STextTheme.noSelectText; // Gaya saat tidak terpilih
            }),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: darkMode ? SColors.softBlack500 : SColors.pureWhite,
              boxShadow: [SShadows.contentShadow],
            ),
          child: NavigationBar(
            height: 82,
            elevation: 0,
            selectedIndex: controller.selectedIndex.value,
            onDestinationSelected: (index) =>
                controller.selectedIndex.value = index,
            backgroundColor: darkMode ? SColors.softBlack500 : SColors.pureWhite,
            destinations: List.generate(
              controller.screens.length,
              (index) {
                final isSelected = controller.selectedIndex.value == index;
                return NavigationDestination(
                  icon: Stack(
                    alignment: Alignment.center,
                    children: [
                      if (isSelected)
                        Container(
                          width: 40,
                          height: 40,
                          decoration: const BoxDecoration(
                            color: SColors.green500,
                            shape: BoxShape.circle,
                          ),
                        ),
                      Icon(
                        _getIconForIndex(index),
                        color: isSelected
                            ? SColors.iconSelect
                            : SColors.iconnonSelect,
                      ),
                    ],
                  ),
                  label: _getLabelForIndex(index), // Properti label hanya String
                );
              },
            ),
          ),
          ),
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }

  IconData _getIconForIndex(int index) {
    switch (index) {
      case 0:
        return SIcons.home;
      case 1:
        return SIcons.cart;
      case 2:
        return SIcons.history;
      case 3:
        return SIcons.profile;
      default:
        return SIcons.home;
    }
  }

  String _getLabelForIndex(int index) {
    switch (index) {
      case 0:
        return 'Beranda';
      case 1:
        return 'Keranjang';
      case 2:
        return 'Pesanan';
      case 3:
        return 'Profile';
      default:
        return 'Beranda';
    }
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [
    const HomeScreen(),
    const CartScreen(),
    const OrderScreen(),
    const ProfileScreen(),
  ];
}
