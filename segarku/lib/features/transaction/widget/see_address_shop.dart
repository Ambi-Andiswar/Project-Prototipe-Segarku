import 'package:flutter/material.dart';
import 'package:segarku/utils/constants/colors.dart';
import 'package:segarku/utils/constants/image_strings.dart';
import 'package:segarku/utils/constants/sizes.dart';
import 'package:segarku/utils/constants/text_strings.dart';
import 'package:segarku/utils/theme/custom_themes/text_theme.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class SeeAddressShop extends StatelessWidget {
  const SeeAddressShop({super.key});

  @override
  Widget build(BuildContext context) {
    final bool dark = context.isDarkMode;
    return Container(
      padding: const EdgeInsets.all(SSizes.defaultMargin),
      decoration: BoxDecoration(
        color: dark ? SColors.pureBlack : SColors.pureWhite,
        borderRadius: BorderRadius.circular(SSizes.borderRadiusmd2),
        border: Border.all(color: SColors.green500),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon Maps Dihilangkan
              const SizedBox(width: SSizes.sm2),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      STexts.addressShop, // Diganti menjadi addressShop
                      style: dark
                          ? STextTheme.bodyCaptionRegularDark
                          : STextTheme.bodyCaptionRegularLight,
                    ),
                    Text(
                      STexts.exAddress, // Tetap exAddress
                      style: (dark
                              ? STextTheme.bodyCaptionRegularDark
                              : STextTheme.bodyCaptionRegularLight)
                          .copyWith(
                        color: dark ? SColors.pureWhite : SColors.pureBlack,
                      ),
                    ),

                    const SizedBox(height: SSizes.md),

                    // Menambahkan Gambar Maps
                    Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: const DecorationImage(
                              image: AssetImage(SImages.maps),
                              fit: BoxFit.cover,
                            ),
                          ),
                          height: 150,
                          width: double.infinity,
                        ),
                        Positioned(
                          bottom: 8,
                          child: InkWell(
                            onTap: () {
                              // Membuka tautan Google Maps
                              const url = "https://www.google.com/maps/place/Universitas+Teknokrat+Indonesia/@-5.3823787,105.255241,17z/data=!3m1!4b1!4m6!3m5!1s0x2e40dadc7970b277:0x5b1fe57f83b6416c!8m2!3d-5.382384!4d105.2578159!16s%2Fg%2F11bw39r0dq?entry=ttu&g_ep=EgoyMDI1MDEwNi4xIKXMDSoASAFQAw%3D%3D";
                              launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: SColors.pureWhite,
                                borderRadius: BorderRadius.circular(32),
                                border: Border.all(color: SColors.green500),
                              ),
                              child: Row(
                                children: [
                                  Image.asset(
                                    SImages.topRight,
                                    height: 12,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    STexts.directions,
                                    style: dark
                                        ? STextTheme.titleCaptionBoldDark
                                        : STextTheme.titleCaptionBoldLight,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: Center(
                            child: Image.asset(
                              SImages.iconMaps,
                            ),
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
