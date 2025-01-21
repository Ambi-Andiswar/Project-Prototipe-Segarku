import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:segarku/features/authentification/controller/onboarding_controller.dart';
import 'package:segarku/utils/constants/icons.dart';
import 'package:segarku/utils/constants/sizes.dart';

import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/helpers/helper_functions.dart';

class OnBoardingButtons extends StatelessWidget {
  const OnBoardingButtons({super.key}); // Super parameter digunakan di sini.

  @override
  Widget build(BuildContext context) {
    final dark = SHelperFunctions.isDarkMode(context);

    return Obx(() {
      final currentPage = OnboardingController.instance.currentPageIndex.value;

      return Stack(
        children: [
          // Tombol Previous hanya ditampilkan di halaman 2 dan 3
          if (currentPage > 0)
            Positioned(
              top: 0, // Anda bisa menggunakan `top` atau `bottom` untuk menyesuaikan posisi vertikal
              bottom: 0, // Agar button berada di tengah vertikal
              left: SSizes.defaultMargin, // Posisi kiri untuk tombol sebelumnya
              right: null,
              child: Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: OnboardingController.instance.previousPage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: dark ? SColors.pureBlack : SColors.green50,
                    minimumSize: const Size(46, 46),
                    fixedSize: const Size(46, 46),
                    padding: EdgeInsets.zero,
                    elevation: 0,
                    side: BorderSide.none,
                  ),
                  child: const Icon(
                    SIcons.left,
                    color: SColors.green500,
                  ),
                ),
              ),
            ),

          // Tombol Next hanya ditampilkan di halaman 1 dan 2
          if (currentPage < 2)
            Positioned(
             top: 0, // Anda bisa menggunakan `top` atau `bottom` untuk menyesuaikan posisi vertikal
              bottom: 0, // Agar button berada di tengah vertikal
              left: null, // Posisi kiri untuk tombol sebelumnya
              right: SSizes.defaultMargin,
              child: Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: OnboardingController.instance.nextPage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: dark ? SColors.pureBlack : SColors.green50,
                    minimumSize: const Size(46, 46),
                    fixedSize: const Size(46, 46),
                    padding: EdgeInsets.zero,
                    elevation: 0,
                    side: BorderSide.none,
                  ),
                  child: const Icon(
                    SIcons.right,
                    color: SColors.green500,
                  ),
                ),
              ),
            ),
        ],
      );
    });
  }
}
