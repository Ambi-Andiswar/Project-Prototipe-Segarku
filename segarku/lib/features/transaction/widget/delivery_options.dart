import 'package:flutter/material.dart';
import 'package:segarku/utils/constants/colors.dart';
import 'package:segarku/utils/constants/icons.dart';
import 'package:segarku/utils/constants/sizes.dart';
import 'package:segarku/utils/constants/text_strings.dart';
import 'package:segarku/utils/theme/custom_themes/text_theme.dart';
import 'package:get/get.dart';

class DeliveryOptions extends StatelessWidget {
  const DeliveryOptions({super.key});
  @override
  Widget build(BuildContext context) {
    final bool dark = context.isDarkMode;
    return Container(
      
      // container Utama
      decoration: BoxDecoration(
        color: SColors.green100, // Warna kotak atas
        borderRadius: BorderRadius.circular(SSizes.borderRadiussm), // Border radius utama
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // Teks Delivery Title
          Padding(
            padding: const EdgeInsets.only(
              top: SSizes.sm2,
              bottom: SSizes.sm2,
              left: SSizes.md2
            ),
            child: Text(
              STexts.deliveryTitle,
              style: STextTheme.titleCaptionBoldLight.copyWith(
                color: SColors.green500, // Warna teks hijau
              ),
            ),
          ),

          // Container ke dua
          Container(
            decoration: BoxDecoration(
              color: Colors.white, // Warna pureWhite untuk kontainer baru
              borderRadius: BorderRadius.circular(SSizes.borderRadiussm),
              border: Border.all(
                color: dark
                ? SColors.green50
                : SColors.softBlack50),
            ),

            // Ukuran padding isi container ke 2
            padding: const EdgeInsets.symmetric(
              vertical: SSizes.md, 
              horizontal: SSizes.md2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Opsi Delivery
                Row(
                  children: [
                    // Icon Delivery dengan background bulat
                    const CircleAvatar(
                      radius: 20, // Ukuran bulatan
                      backgroundColor: SColors.green500, // Warna pureWhite
                      child: Icon(
                        SIcons.delivery, // Icon pengiriman
                        color: SColors.pureWhite, // Warna icon sesuai green500
                        size: SSizes.defaultIcon,
                      ),
                    ),
                    const SizedBox(width: SSizes.md),
                    // Teks Delivery
                    Text(
                      STexts.delivery,
                      style: dark
                          ? STextTheme.titleBaseBoldDark
                          : STextTheme.titleBaseBoldLight,
                    ),
                  ],
                ),

                // Tombol Ganti
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: SSizes.lg,
                    vertical: SSizes.sm2,
                  ),
                  decoration: BoxDecoration(
                    color: SColors.pureWhite, // Warna hijau untuk tombol
                    borderRadius: BorderRadius.circular(SSizes.borderRadiusmd),
                    border: Border.all(color: SColors.green500)
                  ),
                  child: Text(
                    STexts.change,
                    style: dark
                          ? STextTheme.titleBaseBoldDark
                          : STextTheme.titleBaseBoldLight,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
