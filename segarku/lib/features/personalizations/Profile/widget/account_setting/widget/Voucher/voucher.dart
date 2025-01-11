import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:segarku/features/personalizations/Profile/widget/account_setting/widget/Voucher/no_voucher.dart';
import 'package:segarku/utils/constants/colors.dart';
import 'package:segarku/utils/constants/sizes.dart';
import 'package:segarku/utils/theme/custom_themes/text_theme.dart';

class VoucherScreen extends StatefulWidget {
  const VoucherScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _VoucherState createState() => _VoucherState();
}

class _VoucherState extends State<VoucherScreen> {
  // Data voucher
  final List<Map<String, dynamic>> vouchers = [
        {
      "discount": "20%",
      "description": "Diskon 20% untuk minimal pembelian Rp 50.000",
      "expiry": "Berlaku hingga 15 Februari 2025",
    },
    {
      "discount": "30%",
      "description": "Diskon 30% untuk minimal pembelian Rp 100.000",
      "expiry": "Berlaku hingga 20 Maret 2025",
    },
    {
      "discount": "50%",
      "description": "Diskon 50% untuk minimal pembelian Rp 200.000",
      "expiry": "Berlaku hingga 1 April 2025",
    },
  ]; // Kosong untuk simulasi

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

    return Scaffold(
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
                    padding: const EdgeInsets.only(
                      bottom: SSizes.md
                    ),
                    itemCount: vouchers.length,
                    itemBuilder: (context, index) {
                      final voucher = vouchers[index];
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        height: 80,
                        decoration: BoxDecoration(
                          color: dark ? SColors.pureBlack : SColors.pureWhite,
                          borderRadius: BorderRadius.circular(SSizes.borderRadiusmd2),
                          border: Border.all(
                            color: dark ? SColors.green50 : SColors.softBlack50,
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
                                    topLeft: Radius.circular(SSizes.borderRadiusmd2),
                                    bottomLeft: Radius.circular(SSizes.borderRadiusmd2),
                                  ),
                                ),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        voucher['discount'],
                                        style: STextTheme.titleMdBoldDark.copyWith(
                                          color: SColors.green500,
                                        ),
                                      ),
                                      Text(
                                        'Diskon',
                                        style: STextTheme.bodyBaseRegularDark.copyWith(
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
                                padding: const EdgeInsets.symmetric(horizontal: SSizes.sm2),
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
                                      ? Colors.green[100]
                                      : Colors.green[800],
                                  foregroundColor: isTaken[index]
                                      ? Colors.green[800]
                                      : Colors.white,
                                  side: isTaken[index]
                                      ? BorderSide(color: Colors.green[800]!)
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
    );
  }
}
