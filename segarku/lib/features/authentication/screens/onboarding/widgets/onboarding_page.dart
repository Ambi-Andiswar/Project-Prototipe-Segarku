import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:segarku/features/authentication/screens/navigator_welcome.dart';
import 'package:segarku/features/authentication/screens/welcome.dart';
import 'package:segarku/utils/constants/colors.dart';
import 'package:segarku/utils/constants/icons.dart';
import 'package:segarku/utils/constants/sizes.dart';
import 'package:segarku/utils/constants/text_strings.dart';
import 'package:segarku/utils/helpers/helper_functions.dart';
import 'package:segarku/utils/theme/custom_themes/text_theme.dart';
//import '../../../../../../utils/helpers/helper_functions.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({
    super.key,
    required this.image,
    required this.title,
    required this.subTitle,
  });

  final String image, title, subTitle;

  @override
  Widget build(BuildContext context) {
    // Mendapatkan tema saat ini
    final isDarkMode = SHelperFunctions.isDarkMode(context);

    return Stack(
      children: [
        // Gambar sebagai background
        Positioned.fill(
          child: Image.asset(
            image,
            fit: BoxFit.cover, // Mengisi seluruh area dengan gambar
          ),
        ),

        // Bagian teks dan button di atas gambar
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.only(
              bottom: 53, // Jarak dari bawah
              left: SSizes.defaultMargin, // Jarak dari kiri
              right: SSizes.defaultMargin, // Jarak dari kanan
            ),
            child: Container(
              padding: const EdgeInsets.all(SSizes.lg2),
              decoration: BoxDecoration(
                color: isDarkMode ? SColors.pureBlack : SColors.pureWhite, // Sesuaikan warna background dengan tema
                borderRadius: BorderRadius.circular(SSizes.borderRadiuslg),
              ),

              // Title dan subTitle
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start, // Menyusun elemen secara horizontal di tengah
                crossAxisAlignment: CrossAxisAlignment.start, // Menyusun elemen secara vertikal di tengah
                children: [

                  // Title
                  Text(
                    title,
                    style: isDarkMode 
                      ? STextTheme.bodyBaseRegularDark
                      : STextTheme.bodyBaseRegularLight,
                  ),

                  const SizedBox(height: SSizes.sm),
                  
                  // Sub Title
                  Text(
                    subTitle,
                    style: isDarkMode
                      ? STextTheme.titleLgBolddark
                      : STextTheme.titleLgBoldLight,
                  ),
                  const SizedBox(height: SSizes.md),

                  // Button Mulai sekarang
                  ElevatedButton(
                    onPressed: () 
                      => Get.to(() => const WelcomeScreen())
                    ,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        vertical: SSizes.lg2, // Padding vertikal sama dengan Container
                      ),
                      minimumSize: const Size(double.infinity, 50), // Membuat tombol selebar kontainer dan tinggi tertentu
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(SSizes.borderRadiusmd), // Sudut membulat yang sama
                      ),
                      side: const BorderSide(
                        color: SColors.green500, // Sesuaikan dengan tema
                        width: 2, // Lebar border
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center, // Menyusun elemen secara horizontal di tengah
                      crossAxisAlignment: CrossAxisAlignment.center, // Menyusun elemen secara vertikal di tengah
                      children: [
                        // Text Mulai sekarang
                        Text(
                          STexts.buttonOnboarding, // Teks tombol
                          style: STextTheme.titleBaseBoldDark,
                        ),
                        SizedBox(width: SSizes.sm2),
                        // Icon Right
                        Icon(SIcons.right),
                      ],
                    ),
                  ),

                  const SizedBox(height: SSizes.md),

                  // Text Login Now
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // text non activ
                      Text(
                        STexts.alreadyAccount,
                        style: isDarkMode 
                          ? STextTheme.bodyCaptionRegularDark
                          : STextTheme.bodyCaptionRegularLight,
                      ),

                      const SizedBox(width: SSizes.sm),
                      // Text Active/button text
                      TextButton(
                        onPressed: () => Get.to(() => const NavigationWelcome(initialIndex: 1,)),
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: const Text(
                          STexts.loginNow,
                          style: STextTheme.ctaSm,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
