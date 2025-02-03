import 'package:flutter/material.dart';
import 'package:segarku/utils/constants/colors.dart';
import 'package:segarku/utils/constants/icons.dart';
import 'package:segarku/utils/constants/sizes.dart';
import 'package:segarku/utils/constants/text_strings.dart';
import 'package:segarku/utils/theme/custom_themes/text_theme.dart';
import 'package:get/get.dart';

class DeliveryOptions extends StatelessWidget {
  final bool isDelivery; // Tambahkan parameter untuk mode
  final Function(bool) onChangeMode; // Callback untuk mengirim aksi perubahan

  const DeliveryOptions({
    super.key,
    required this.isDelivery, // Terima nilai dari state halaman utama
    required this.onChangeMode,
  });

  @override
  Widget build(BuildContext context) {
    final bool dark = context.isDarkMode;

    return Container(
      decoration: BoxDecoration(
        color: SColors.green100,
        borderRadius: BorderRadius.circular(SSizes.borderRadiussm),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Teks Delivery Title
          Padding(
            padding: const EdgeInsets.only(
              top: SSizes.sm2,
              bottom: SSizes.sm2,
              left: SSizes.md2,
            ),
            child: Text(
              STexts.deliveryTitle, // Ganti teks
              style: STextTheme.titleCaptionBoldLight.copyWith(
                color: SColors.green500,
              ),
            ),
          ),

          // Container ke dua
          Container(
            decoration: BoxDecoration(
              color: dark
              ? SColors.pureBlack
              : SColors.pureWhite,
              borderRadius: BorderRadius.circular(SSizes.borderRadiussm),
              border: Border.all(
                color: dark ? SColors.green100 : SColors.softBlack50,
              ),
            ),
            padding: const EdgeInsets.symmetric(
              vertical: SSizes.md,
              horizontal: SSizes.md2,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Opsi Delivery
                Row(
                  children: [
                    // Icon Delivery dengan background bulat
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: SColors.green500,
                      child: Icon(
                        isDelivery ? SIcons.delivery : SIcons.pickUp, // Ganti ikon
                        color: SColors.pureWhite,
                        size: SSizes.defaultIcon,
                      ),
                    ),
                    const SizedBox(width: SSizes.md),
                    // Teks Delivery
                    Text(
                      isDelivery ? STexts.delivery : STexts.pickUp, // Ganti teks
                      style: dark
                          ? STextTheme.titleBaseBoldDark
                          : STextTheme.titleBaseBoldLight,
                    ),
                  ],
                ),

                // Tombol Ganti
                GestureDetector(
                  onTap: () => onChangeMode(true), // Panggil callback saat diklik
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: SSizes.lg,
                      vertical: SSizes.sm2,
                    ),
                    decoration: BoxDecoration(
                      color: dark
                      ? SColors.pureBlack
                      : SColors.pureWhite,
                      borderRadius:
                          BorderRadius.circular(SSizes.borderRadiusmd),
                      border: Border.all(color: SColors.green500),
                    ),
                    child: Text(
                      STexts.change,
                      style: dark
                          ? STextTheme.titleBaseBoldDark
                          : STextTheme.titleBaseBoldLight,
                    ),
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
