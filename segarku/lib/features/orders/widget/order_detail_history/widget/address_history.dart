import 'package:flutter/material.dart';
import 'package:segarku/utils/constants/colors.dart';
import 'package:segarku/utils/constants/icons.dart';
import 'package:segarku/utils/constants/sizes.dart';
import 'package:segarku/utils/theme/custom_themes/text_theme.dart';

class AddressHistory extends StatelessWidget {
  final Map<String, dynamic> shippingAddress; // Data alamat pengiriman
  final String phone; // Nomor telepon penerima
  final String shippingMethod; // Metode pengiriman
  final String createdAt; // Tanggal transaksi
  final String status; // Status transaksi
  final bool darkMode;
  final String deliveryTime; // Waktu pengiriman

  const AddressHistory({
    super.key,
    required this.shippingAddress,
    required this.phone,
    required this.shippingMethod,
    required this.createdAt,
    required this.status,
    required this.darkMode,
    required this.deliveryTime,
  });

  @override
  Widget build(BuildContext context) {
    // Tentukan warna BoxDecoration dan teks status berdasarkan status
    final Color containerColor = status == 'selesai' ? SColors.green100 : SColors.softBlack50;
    final Color statusTextColor = status == 'selesai' ? SColors.green500 : SColors.softBlack400;

    return Container(
      margin: const EdgeInsets.only(
        left: SSizes.defaultMargin,
        top: SSizes.defaultMargin,
        right: SSizes.defaultMargin,
      ),
      decoration: BoxDecoration(
        color: containerColor, // Warna container berdasarkan status
        borderRadius: BorderRadius.circular(SSizes.borderRadiussm),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: SSizes.sm2,
              bottom: SSizes.sm2,
              left: SSizes.md2,
            ),
            child: Text(
              status,
              style: STextTheme.titleCaptionBoldLight.copyWith(
                color: statusTextColor, // Warna teks status berdasarkan status
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(SSizes.borderRadiussm),
              border: Border.all(
                color: darkMode ? SColors.green50 : SColors.softBlack50,
              ),
            ),
            padding: const EdgeInsets.all(SSizes.defaultMargin),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Tanggal transaksi',
                      style: darkMode
                          ? STextTheme.bodyCaptionRegularDark
                          : STextTheme.bodyCaptionRegularLight,
                    ),
                    const Spacer(),
                    Text(
                      createdAt,
                      style: STextTheme.ctaSm,
                    ),
                  ],
                ),
                const SizedBox(height: SSizes.xs),
                Row(
                  children: [
                    Text(
                      'Metode transaksi',
                      style: darkMode
                          ? STextTheme.bodyCaptionRegularDark
                          : STextTheme.bodyCaptionRegularLight,
                    ),
                    const Spacer(),
                    Text(
                      shippingMethod,
                      style: STextTheme.ctaSm,
                    ),
                  ],
                ),
                // Tampilkan "Waktu Pengiriman" jika metode pengiriman adalah "delivery"
                if (shippingMethod == 'delivery') ...[
                  const SizedBox(height: SSizes.xs),
                  Row(
                    children: [
                      Text(
                        'Waktu Pengiriman',
                        style: darkMode
                            ? STextTheme.bodyCaptionRegularDark
                            : STextTheme.bodyCaptionRegularLight,
                      ),
                      const Spacer(),
                      Text(
                        deliveryTime,
                        style: STextTheme.ctaSm,
                      ),
                    ],
                  ),
                ],
                // Tampilkan pesan "Mohon bersabar..." jika status adalah "Proses"
                if (status == 'proses' && shippingMethod == 'delivery') ...[
                  const SizedBox(height: SSizes.md2),
                  Text(
                    'Mohon bersabar ya, Pesanan anda akan tiba dalam 20 Menit',
                    style: STextTheme.bodyCaptionRegularLight.copyWith(
                      color: SColors.green500, // Warna hijau
                    ),
                  ),
                ],
                const SizedBox(height: SSizes.md),
                Text(
                  'Alamat Pengiriman',
                  style: darkMode
                      ? STextTheme.titleBaseBoldDark
                      : STextTheme.titleBaseBoldLight,
                ),
                const SizedBox(height: SSizes.sm2),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: SColors.green500),
                    borderRadius: BorderRadius.circular(SSizes.borderRadiusmd2),
                  ),
                  padding: const EdgeInsets.all(SSizes.sm2),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        SIcons.location,
                        color: SColors.green500,
                        size: SSizes.defaultIconsm,
                      ),
                      const SizedBox(width: SSizes.sm2),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Alamat",
                              style: darkMode
                                  ? STextTheme.bodyCaptionRegularDark
                                  : STextTheme.bodyCaptionRegularLight,
                            ),
                            const SizedBox(height: SSizes.sm2),
                            Text(
                              shippingAddress['address'],
                              style: (darkMode
                                      ? STextTheme.bodyCaptionRegularDark
                                      : STextTheme.bodyCaptionRegularLight)
                                  .copyWith(
                                color: darkMode ? SColors.pureWhite : SColors.pureBlack,
                              ),
                            ),
                            const SizedBox(height: SSizes.md),
                            Row(
                              children: [
                                Text(
                                  shippingAddress['name'],
                                  style: darkMode
                                      ? STextTheme.titleCaptionBoldDark
                                      : STextTheme.titleCaptionBoldLight,
                                ),
                                const SizedBox(width: SSizes.sm2),
                                Text(
                                  '•',
                                  style: darkMode
                                      ? STextTheme.bodyCaptionRegularDark
                                      : STextTheme.bodyCaptionRegularLight,
                                ),
                                const SizedBox(width: SSizes.sm2),
                                Text(
                                  phone,
                                  style: darkMode
                                      ? STextTheme.bodyCaptionRegularDark
                                      : STextTheme.bodyCaptionRegularLight,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
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