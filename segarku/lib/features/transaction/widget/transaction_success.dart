import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:segarku/navigation_menu.dart';
import 'package:segarku/utils/constants/colors.dart';
import 'package:segarku/utils/constants/icons.dart';
import 'package:segarku/utils/constants/image_strings.dart';
import 'package:segarku/utils/constants/sizes.dart';
import 'package:segarku/utils/theme/custom_themes/text_theme.dart';
import '../../../../../utils/constants/text_strings.dart';

class TransactionSuccess extends StatelessWidget {
  const TransactionSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    final bool dark = context.isDarkMode;
    return Scaffold(
      body: Column(
        children: [
          // Kontainer di bagian atas
          Container(
            padding: const EdgeInsets.only(
                top: 78.49,
                bottom: 26,
                right: SSizes.defaultMargin,
                left: SSizes.defaultMargin),
            decoration: const BoxDecoration(
              color: Colors.transparent,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Tombol Close
                GestureDetector(
                  onTap: () => Get.to(() => const NavigationMenu(initialIndex: 0)),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: dark ? SColors.green50 : SColors.softBlack50,
                        )),
                    child: Icon(
                      SIcons.close,
                      color: dark ? SColors.pureWhite : SColors.pureBlack,
                    ),
                  ),
                ),

                // Tombol Share
                GestureDetector(
                  onTap: () {
                    // Tambahkan aksi untuk tombol Share di sini
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: dark ? SColors.green50 : SColors.softBlack50,
                        )),
                    child: const Icon(
                      SIcons.share,
                      color: SColors.green500,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Bagian konten utama
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: SSizes.defaultMargin),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: SSizes.xs),
                        Image.asset(SImages.verified1),

                        // Title
                        Text(
                          STexts.titlePaymentSucces,
                          style: dark
                              ? STextTheme.titleMdBoldDark
                              : STextTheme.titleMdBoldLight,
                        ),

                        const SizedBox(height: SSizes.sm),

                        // Subtitle
                        Text(
                          STexts.subTitlePaymentSucces,
                          style: dark
                              ? STextTheme.bodyBaseRegularDark
                              : STextTheme.bodyBaseRegularLight,
                        ),

                        const SizedBox(height: SSizes.md),

                        // Kontainer tambahan
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: dark
                              ? SColors.softBlack500
                              : SColors.softWhite,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    STexts.sum,
                                    style: dark
                                      ? STextTheme.bodyBaseRegularDark
                                      : STextTheme.bodyBaseRegularLight,
                                  ),
                                  Text(
                                    STexts.exSum,
                                    style: dark
                                    ?  STextTheme.titleMdBoldDark
                                    : STextTheme.titleMdBoldLight,
                                  ),
                                ],
                              ),

                              const SizedBox(height: SSizes.md),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    STexts.paymentStatus,
                                    style: dark
                                      ? STextTheme.bodyBaseRegularDark
                                      : STextTheme.bodyBaseRegularLight,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: SSizes.xs, horizontal: 10),
                                    decoration: BoxDecoration(
                                      color: SColors.green100,
                                      borderRadius: BorderRadius.circular(SSizes.lg2),
                                    ),
                                    child: const Text(
                                      STexts.finish,
                                      style: STextTheme.ctaSm,
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: SSizes.lg),

                              const Divider(
                                color: SColors.softBlack50,
                                thickness: 1,
                              ),

                              const SizedBox(height: SSizes.lg),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    STexts.refNumb,
                                    style: dark
                                    ? STextTheme.bodyCaptionRegularDark
                                    : STextTheme.bodyCaptionRegularLight,
                                  ),
                                  Text(
                                    STexts.exRefNumb,
                                    style: dark
                                    ? STextTheme.titleCaptionBoldDark
                                    : STextTheme.titleCaptionBoldLight,
                                  ),
                                ],
                              ),
                              const SizedBox(height: SSizes.md+2),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    STexts.paymentMethod,
                                    style: dark
                                    ? STextTheme.bodyCaptionRegularDark
                                    : STextTheme.bodyCaptionRegularLight,
                                  ),
                                  Text(
                                    STexts.expaymentMethod,
                                    style: dark
                                    ? STextTheme.titleCaptionBoldDark
                                    : STextTheme.titleCaptionBoldLight,
                                  ),
                                ],
                              ),
                              const SizedBox(height: SSizes.md+2),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    STexts.time,
                                    style: dark
                                    ? STextTheme.bodyCaptionRegularDark
                                    : STextTheme.bodyCaptionRegularLight,
                                  ),
                                  Text(
                                    STexts.exTime,
                                    style: dark
                                    ? STextTheme.titleCaptionBoldDark
                                    : STextTheme.titleCaptionBoldLight,
                                  ),
                                ],
                              ),
                              const SizedBox(height: SSizes.md+2),Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    STexts.date,
                                    style: dark
                                    ? STextTheme.bodyCaptionRegularDark
                                    : STextTheme.bodyCaptionRegularLight,
                                  ),
                                  Text(
                                    STexts.exdate,
                                    style: dark
                                    ? STextTheme.titleCaptionBoldDark
                                    : STextTheme.titleCaptionBoldLight,
                                  ),
                                ],
                              ),

                            ],
                          ),
                        ),
                        const SizedBox(height: SSizes.lg2)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Bagian bawah
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: SSizes.defaultMargin),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(
                      SIcons.download, // Ikon diambil dari SIcon.download
                      color: SColors.green500, // Warna ikon
                    ),
                    label: Text(
                      STexts.saveStruk,
                      style: STextTheme.titleBaseBoldDark.copyWith(
                          color: SColors.green500),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: SColors.green500),
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                ),

                const SizedBox(height: SSizes.md),

                // Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Get.to(() => const NavigationMenu(initialIndex: 2)),
                    child: Text(
                      STexts.done,
                      style: dark
                        ? STextTheme.titleBaseBoldLight
                        : STextTheme.titleBaseBoldDark,
                    ),
                  ),
                ),
                const SizedBox(height: SSizes.xl),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
