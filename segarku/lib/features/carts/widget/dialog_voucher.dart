import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:segarku/features/personalizations/Profile/widget/account_setting/widget/Voucher/widget/no_voucher.dart';
import 'package:segarku/utils/constants/colors.dart';
import 'package:segarku/utils/constants/sizes.dart';
import 'package:segarku/utils/theme/custom_themes/text_theme.dart';

class VoucherPopup extends StatefulWidget {
  const VoucherPopup({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _VoucherState createState() => _VoucherState();
}

class _VoucherState extends State<VoucherPopup> {
  // Data voucher
  final List<Map<String, dynamic>> vouchers = [
    // ini tempat data voucher
  ];

  // Status voucher diambil atau tidak
  late List<bool> isTaken;

  @override
  void initState() {
    super.initState();
    isTaken = List.generate(vouchers.length, (_) => false); // Default semua voucher belum diambil
  }

  @override
  Widget build(BuildContext context) {
    final bool dark = context.isDarkMode;

    return FractionallySizedBox(
      heightFactor: 0.75, // Tinggi popup 75% dari layar
      child: Padding(
        padding: const EdgeInsets.all(SSizes.defaultMargin),
        child: Scaffold(
          backgroundColor: Colors.transparent, 
          body: vouchers.isEmpty
              ? const NoVoucherScreen() // Panggil NoVoucherScreen() jika vouchers kosong
              : Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft, // Posisi kiri
                      child: Text(
                        'Pilih Voucher',
                        style: dark
                            ? STextTheme.titleBaseBoldDark
                            : STextTheme.titleBaseBoldLight,
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.only(bottom: SSizes.md),
                        itemCount: vouchers.length,
                        itemBuilder: (context, index) {
                          final voucher = vouchers[index];
                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            height: 80,
                            decoration: BoxDecoration(
                              color: dark ? SColors.pureBlack : SColors.pureWhite,
                              borderRadius:
                                  BorderRadius.circular(SSizes.borderRadiusmd2),
                              border: Border.all(
                                color:
                                    dark ? SColors.green50 : SColors.softBlack50,
                              ),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    height: double.infinity,
                                    decoration: const BoxDecoration(
                                      color: SColors.green50,
                                      borderRadius: BorderRadius.only(
                                        topLeft:
                                            Radius.circular(SSizes.borderRadiusmd2),
                                        bottomLeft:
                                            Radius.circular(SSizes.borderRadiusmd2),
                                      ),
                                    ),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            voucher['discount'],
                                            style: STextTheme.titleMdBoldDark
                                                .copyWith(
                                              color: SColors.green500,
                                            ),
                                          ),
                                          Text(
                                            'Diskon',
                                            style: STextTheme.bodyBaseRegularDark
                                                .copyWith(
                                              color: SColors.green300,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: SSizes.sm2),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          voucher['description'],
                                          style: dark
                                              ? STextTheme.titleCaptionBoldDark
                                              : STextTheme.titleCaptionBoldLight,
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          voucher['expiry'],
                                          style: dark
                                              ? STextTheme.bodySmRegularDark
                                              : STextTheme.bodySmRegularLight,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    right: SSizes.lg,
                                    top: SSizes.md2,
                                    bottom: SSizes.md2,
                                  ),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        isTaken[index] = !isTaken[index];
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: isTaken[index]
                                          ? SColors.green100
                                          : SColors.green500,
                                      foregroundColor: isTaken[index]
                                          ? SColors.green500
                                          : SColors.pureWhite,
                                      side: isTaken[index]
                                          ? BorderSide(
                                              color: SColors.green500)
                                          : BorderSide.none,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 5,
                                      ),
                                    ),
                                    child: Text(
                                      isTaken[index] ? 'Diambil' : 'Ambil',
                                      style: const TextStyle(fontSize: 10),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}