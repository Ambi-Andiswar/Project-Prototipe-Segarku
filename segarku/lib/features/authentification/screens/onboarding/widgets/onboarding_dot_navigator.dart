import 'package:flutter/material.dart';
import 'package:segarku/features/authentification/controller/onboarding_controller.dart';
import 'package:segarku/utils/constants/sizes.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../../utils/constants/colors.dart';

class OnboardingDotNavigation extends StatelessWidget {
  const OnboardingDotNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = OnboardingController.instance;

    // Mendapatkan lebar layar
    final screenWidth = MediaQuery.of(context).size.width;

    // Tentukan ukuran dot aktif dan lainnya
    final dotWidth = screenWidth * 0.3; // 30% dari lebar layar

    return Positioned(
      top: 88, // Jarak dari atas
      left: 0, // Mulai dari kiri
      right: 0, // Sampai ke kanan
      child: Container(
        width: double.infinity, // Memastikan lebar penuh
        alignment: Alignment.center, // Dot berada di tengah
        child: SmoothPageIndicator(
          count: 3, // Jumlah dot
          controller: controller.pageController,
          onDotClicked: controller.dotNavigationClick,
          effect: CustomizableEffect(
            activeDotDecoration: DotDecoration(
              width: dotWidth, // Lebar dot aktif
              height: 4, // Tinggi dot aktif
              color: SColors.pureWhite,
              borderRadius: BorderRadius.circular(100), // Responsif
            ),
            dotDecoration: DotDecoration(
              width: dotWidth, // Lebar dot lainnya
              height: 4, // Tinggi dot lainnya
              color: SColors.softBlack100,
              borderRadius: BorderRadius.circular(100), // Responsif
            ),
            spacing: SSizes.sm, // Jarak antar dot
          ),
        ),
      ),
    );
  }
}
