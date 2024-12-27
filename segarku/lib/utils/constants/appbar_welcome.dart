import 'package:flutter/material.dart';
import 'package:segarku/utils/constants/colors.dart';
import 'package:segarku/utils/constants/image_strings.dart';
import 'package:segarku/utils/constants/sizes.dart';

class AppBarWelcome extends StatelessWidget {
  const AppBarWelcome({super.key});

  @override
  Widget build(BuildContext context) {
    // Deteksi mode terang atau gelap
    final isDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;
    final overlayColor = isDarkMode ? SColors.pureBlack : SColors.pureWhite;

    return SizedBox(
      width: MediaQuery.of(context).size.width, // Lebar responsif
      height: MediaQuery.of(context).size.height/3.1, // Tinggi tetap
      child: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              SImages.welcomeBackground,
              fit: BoxFit.cover, // Mengisi seluruh lebar widget
            ),
          ),
          // Gradient overlay
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    overlayColor.withOpacity(0.0), // Warna dengan opasitas 0% di atas
                    overlayColor.withOpacity(1.0), // Warna dengan opasitas 100% di bawah
                  ],
                ),
              ),
            ),
          ),
          // Logo icon
          Padding(
            padding: const EdgeInsets.only(left: SSizes.defaultMargin, top: 85.0),
            child: Image.asset(
              SImages.iconSegarku,
              height: 40.0, // Sesuaikan ukuran logo
            ),
          ),
        ],
      ),
    );
  }
}
