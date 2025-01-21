import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:segarku/features/authentification/screens/login/login.dart';
import 'package:segarku/features/authentification/screens/register/register.dart';
import 'package:segarku/utils/constants/colors.dart';
import 'package:segarku/utils/helpers/helper_functions.dart';
import 'package:segarku/utils/theme/custom_themes/text_theme.dart';

class NavigationWelcome extends StatelessWidget {
  final int initialIndex; // Menambahkan parameter untuk tab awal

  const NavigationWelcome({super.key, this.initialIndex = 0});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ButtonController());
    final darkMode = SHelperFunctions.isDarkMode(context);

    // Mengatur nilai awal selectedIndex sesuai initialIndex
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.setInitialIndex(initialIndex);
    });

    return Scaffold(
      backgroundColor: darkMode ? SColors.softBlack900 : SColors.pureWhite,
      body: Column(
        children: [
          // Navigasi (Baris Tombol)
          Obx(
            () => Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                border: Border.all(
                  color: darkMode ? SColors.pureBlack : SColors.pureWhite,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  // Button Masuk
                  Expanded(
                    child: GestureDetector(
                      onTap: () => controller.setSelectedIndex(0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          color: controller.selectedIndex.value == 0
                              ? SColors.pureWhite
                              : SColors.softWhite,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(8),
                            bottomLeft: Radius.circular(8),
                          ),
                        ),
                        child: Text(
                          'Masuk',
                          textAlign: TextAlign.center,
                          style: controller.selectedIndex.value == 0
                              ? (darkMode
                                  ? STextTheme.titleBaseBlackDark
                                  : STextTheme.titleBaseBlackLight)
                              : (darkMode
                                  ? STextTheme.bodyBaseRegularDark
                                  : STextTheme.bodyBaseRegularLight),
                        ),
                      ),
                    ),
                  ),
                  // Button Daftar
                  Expanded(
                    child: GestureDetector(
                      onTap: () => controller.setSelectedIndex(1),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          color: controller.selectedIndex.value == 1
                              ? SColors.pureWhite
                              : SColors.softWhite,
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                          ),
                        ),
                        child: Text(
                          'Daftar',
                          textAlign: TextAlign.center,
                          style: controller.selectedIndex.value == 1
                              ? (darkMode
                                  ? STextTheme.titleBaseBlackDark
                                  : STextTheme.titleBaseBlackLight)
                              : (darkMode
                                  ? STextTheme.bodyBaseRegularDark
                                  : STextTheme.bodyBaseRegularLight),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Konten Dinamis Berdasarkan `selectedIndex`
          Expanded(
            child: Obx(
              () {
                if (controller.selectedIndex.value == 0) {
                  return const LoginScreen();
                } else if (controller.selectedIndex.value == 1) {
                  return const RegisterScreen();
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ButtonController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  void setInitialIndex(int index) {
    selectedIndex.value = index; // Mengatur nilai awal selectedIndex
  }

  void setSelectedIndex(int index) {
    selectedIndex.value = index;
  }
}
