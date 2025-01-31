import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:segarku/features/authentification/controller/onboarding_controller.dart';
import 'package:segarku/features/authentification/screens/onboarding/widgets/onboarding_button.dart';
import 'package:segarku/features/authentification/screens/onboarding/widgets/onboarding_dot_navigator.dart';
import 'package:segarku/features/authentification/screens/onboarding/widgets/onboarding_page.dart';
import 'package:segarku/utils/constants/image_strings.dart';
import 'package:segarku/utils/constants/text_strings.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnboardingController());

    // auto-scroll saat halaman dibuat
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.startAutoScroll();
    });

    return Scaffold(
      body: Stack(
        children: [
          // Horizontal Scrollable Pages
          PageView(
            controller: controller.pageController,
            onPageChanged: (index) {
              controller.updatePageIndicator(index);
            },
            children: const [
              OnBoardingPage(
                image: SImages.onboarding1,
                title: STexts.onboarding1Title,
                subTitle: STexts.onboarding1SubTitle,
              ),
              OnBoardingPage(
                image: SImages.onboarding2,
                title: STexts.onboarding2Title,
                subTitle: STexts.onboarding2SubTitle,
              ),
              OnBoardingPage(
                image: SImages.onboarding3,
                title: STexts.onboarding3Title,
                subTitle: STexts.onboarding3SubTitle,
              ),
            ],
          ),

          // Dot Navigator SmoothPageIndicator
          const OnboardingDotNavigation(),

          // Circular Button
          const OnBoardingButtons(),

        ],
      ),
    );
  }
}
