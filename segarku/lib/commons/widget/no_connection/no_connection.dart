import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:segarku/commons/controller/no_connection/connectivity_controller.dart';
import 'package:segarku/utils/constants/image_strings.dart';
import 'package:segarku/utils/constants/sizes.dart';
import 'package:segarku/utils/constants/text_strings.dart';
import 'package:segarku/utils/helpers/helper_functions.dart';
import 'package:segarku/utils/theme/custom_themes/text_theme.dart';

class NoConnectionScreen extends StatelessWidget {
  const NoConnectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = SHelperFunctions.isDarkMode(context);
    final ConnectivityController connectivityController = Get.find<ConnectivityController>();

    return Scaffold(
      body: Center( // Bungkus dengan Center
        child: Padding(
          padding: const EdgeInsets.all(SSizes.defaultMargin),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Pusatkan secara vertikal
            crossAxisAlignment: CrossAxisAlignment.center, // Pusatkan secara horizontal
            children: [
              // Gambar ilustrasi tidak ada internet
              Image.asset(
                SImages.noInternetCollorfull,
                width: 254, // Lebar gambar sesuai permintaan
              ),
              const SizedBox(height: SSizes.xl), // Spasi vertikal

              // Judul
              Text(
                STexts.noNotification,
                style: dark
                    ? STextTheme.titleMdBoldDark
                    : STextTheme.titleMdBoldLight,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: SSizes.xs), // Spasi vertikal kecil

              // Subjudul
              Text(
                STexts.subNoNotification,
                style: dark
                    ? STextTheme.bodyCaptionRegularDark
                    : STextTheme.bodyCaptionRegularLight,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: SSizes.xl), // Spasi vertikal

              // Tombol "Coba Lagi"
              ElevatedButton(
                onPressed: () {
                  // Panggil metode public `refreshConnection`
                  connectivityController.refreshConnection();
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    'Coba Lagi',
                    style: dark 
                    ? STextTheme.titleBaseBoldLight
                    : STextTheme.titleBaseBoldDark),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}