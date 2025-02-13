import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:intl/intl.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:segarku/features/carts/controllers/cart_provider.dart';
import 'package:segarku/features/transaction/controller/handle_payment.dart';
import 'package:segarku/features/transaction/widget/purchase_options.dart';
import 'package:segarku/features/transaction/widget/detail_product_transaction.dart';
import 'package:segarku/features/transaction/widget/dialog_purchase_method.dart';
import 'package:segarku/features/transaction/widget/see_address_shop.dart';
import 'package:segarku/features/transaction/widget/select_location.dart';
import 'package:segarku/utils/constants/colors.dart';
import 'package:segarku/utils/constants/icons.dart';
import 'package:segarku/utils/constants/sizes.dart';
import 'package:segarku/utils/theme/custom_themes/text_theme.dart';
import '../../../../../utils/constants/text_strings.dart';

class TransactionCheckoutScreen extends StatefulWidget {
  const TransactionCheckoutScreen({super.key});

  @override
  State<TransactionCheckoutScreen> createState() =>
      _TransactionCheckoutScreenState();
}

class _TransactionCheckoutScreenState extends State<TransactionCheckoutScreen> {
  final CartController cartController = Get.find<CartController>();
  bool isDelivery = false;
  DateTime deliveryTime = DateTime.now();
  bool isProcessingPayment = false;
  bool isDeliveryTimeSelected = false;
  String selectedAddress = ''; 

  // Loading Overlay Widget
  Widget _buildLoadingOverlay() {
    return const Stack(
      children: [
        Opacity(
          opacity: 0.3,
          child: ModalBarrier(dismissible: false, color: SColors.green500),
        ),
        Center(
          child: CircularProgressIndicator(),
        ),
      ],
    );
  }

  // Error Dialog
  void _showErrorDialog(String message) {
    final bool dark = context.isDarkMode;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Error',
          style: dark ? STextTheme.titleBaseBoldDark : STextTheme.titleBaseBoldLight,
        ),
        content: Text(
          message,
          style: dark ? STextTheme.bodyBaseRegularDark : STextTheme.bodyBaseRegularLight,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'OK',
              style: dark ? STextTheme.titleBaseBoldDark : STextTheme.titleBaseBoldLight,
            ),
          ),
        ],
      ),
    );
  }


  // Validation
  bool _validatePayment() {
    if (isDelivery && deliveryTime.isBefore(DateTime.now())) {
      Get.snackbar(
        'Belum bisa melanjutkan pembayaran',
        'Harap pilih waktu pengiriman dahulu',
        backgroundColor: SColors.danger500,
        colorText: SColors.pureWhite,
        icon: const Icon(Icons.error, color: Colors.white),
        snackPosition: SnackPosition.TOP,
      );
      return false;
    }

    // Validate cart is not empty
    if (cartController.getSelectedProducts().isEmpty) {
      Get.snackbar(
        'Belum bisa melanjutkan pembayaran',
        'Keranjang belanja kosong',
        backgroundColor: SColors.danger500,
        colorText: SColors.pureWhite,
        icon: const Icon(Icons.error, color: Colors.white),
        snackPosition: SnackPosition.TOP,
      );
      return false;
    }

    // Validate address is not empty
    // if (isDelivery && selectedAddress.isEmpty) {
    //   Get.snackbar(
    //     'Belum bisa melanjutkan pembayaran',
    //     'Alamat pengiriman harus diisi',
    //     backgroundColor: SColors.danger500,
    //     colorText: SColors.pureWhite,
    //     icon: const Icon(Icons.error, color: Colors.white),
    //     snackPosition: SnackPosition.TOP,
    //   );
    //   return false;
    // }

    return true;
  }


  // Handle Payment Process
  Future<void> _processPayment() async {
    if (isProcessingPayment) return;
    
    if (!_validatePayment()) return;

    setState(() {
      isProcessingPayment = true;
    });

    try {
      print("DEBUG: Starting payment process");
      final success = await handlePayment(
        context,
        isDelivery,
        deliveryTime,
      );

      if (mounted) {
        if (!success) {
          print("DEBUG: Payment failed");
          Get.snackbar(
            'Gagal melakukan pembayaran',
            'Silahkan isi data pengiriman seperti alamat dan waktu pengriman(jika Anda memilih Delivery)',
            backgroundColor: SColors.danger500,
            colorText: SColors.pureWhite,
            icon: const Icon(Icons.error, color: Colors.white),
            snackPosition: SnackPosition.TOP,
          );
        }
        // Hapus navigasi ke TransactionSuccess karena akan ditangani oleh MidtransPaymentScreen
      }
    } catch (e) {
      print("DEBUG: Payment error - $e");
      if (mounted) {
        _showErrorDialog('Terjadi kesalahan: ${e.toString()}');
      }
    } finally {
      if (mounted) {
        setState(() {
          isProcessingPayment = false;
        });
      }
    }
  }


    // Confirmation Dialog
  void _showPaymentConfirmation() {
    final bool dark = context.isDarkMode;
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(SSizes.borderRadiusmd2)
        ),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(SSizes.defaultMargin),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Konfirmasi Pembelian',
                style: dark ? STextTheme.titleBaseBoldDark : STextTheme.titleBaseBoldLight,
              ),
              const SizedBox(height: SSizes.sm2),
              Text(
                'Apakah produk yang Anda beli sudah sesuai?',
                style: dark ? STextTheme.bodyBaseRegularDark : STextTheme.bodyBaseRegularLight,
              ),
              const SizedBox(height: SSizes.lg),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(
                        'Batal',
                        style: dark ? STextTheme.titleBaseBoldDark : STextTheme.titleBaseBoldLight,
                      ),
                    ),
                  ),
                  const SizedBox(width: SSizes.md),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        _processPayment();
                      },
                      child: Text(
                        'Lanjutkan',
                        style: dark ? STextTheme.titleBaseBoldLight : STextTheme.titleBaseBoldDark,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: SSizes.md2),
            ],
          ),
        );
      },
    );
  }

  Future<bool> _onWillPop() async {
  final bool dark = context.isDarkMode;
    bool? shouldExit = await showModalBottomSheet<bool>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(SSizes.defaultMargin),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Batalkan pembelian?', 
              style: dark 
                ? STextTheme.titleBaseBoldDark
                : STextTheme.titleBaseBoldLight),
            const SizedBox(height: SSizes.sm2),
            Text('Apakah Anda yakin ingin membatalkan pembelian?',
              style: dark 
              ? STextTheme.bodyBaseRegularDark
              : STextTheme.bodyBaseRegularLight),
            const SizedBox(height: SSizes.lg),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: Text(
                      'Batal',
                      style: dark 
                      ? STextTheme.titleBaseBoldDark
                      : STextTheme.titleBaseBoldLight
                    ),
                  ),
                ),
                const SizedBox(width: SSizes.md),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: Text(
                      'Keluar',
                      style: dark
                      ? STextTheme.titleBaseBoldLight
                      : STextTheme.titleBaseBoldDark,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
    return shouldExit ?? false;
  }

  

  void _showConfirmationDialog() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => ConfirmationDialog(
        isDelivery: isDelivery,
        onSave: (selectedDelivery) {
          setState(() {
            isDelivery = selectedDelivery;
          });
        },
      ),
    );
  }

  void _showDatePicker() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(SSizes.borderRadiusmd2)),
      ),
      builder: (context) {
        final DateTime now = DateTime.now();
        final bool dark = context.isDarkMode;
        
        // Fungsi untuk mengecek apakah waktu berada dalam rentang yang diizinkan
        bool isTimeInRange(DateTime date) {
          return date.hour >= 6 && date.hour < 21; // 6 pagi sampai 9 malam
        }

        // Fungsi untuk mendapatkan waktu awal yang valid
        DateTime getValidInitialTime() {
          DateTime validTime = now;
          
          // Jika waktu sekarang sebelum jam 6 pagi, set ke jam 6 pagi hari ini
          if (now.hour < 6) {
            validTime = DateTime(now.year, now.month, now.day, 6, 0);
          }
          // Jika waktu sekarang setelah jam 9 malam, set ke jam 6 pagi hari berikutnya
          else if (now.hour >= 21) {
            final tomorrow = now.add(const Duration(days: 1));
            validTime = DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 6, 0);
          }
          
          return validTime;
        }

        final DateTime initialDateTime = getValidInitialTime();

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: SSizes.defaultMargin),
          child: SizedBox(
            height: 330,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: SSizes.md2),
                Text(
                  "Pilih Waktu Pengiriman",
                  style: dark
                    ? STextTheme.titleBaseBoldDark
                    : STextTheme.titleBaseBoldLight,
                ),
                const SizedBox(height: SSizes.md),
                Text(
                  "* Estimasi pesanan Anda tiba dalam 30 menit",
                  style: STextTheme.titleCaptionBoldDark.copyWith(
                    color: SColors.green500
                  ),
                ),
                const SizedBox(height: SSizes.md),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: SColors.green500, width: 1),
                      borderRadius: BorderRadius.circular(SSizes.borderRadiusmd2),
                    ),
                    child: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.dateAndTime,
                      initialDateTime: initialDateTime,
                      minimumDate: getValidInitialTime(),
                      maximumDate: DateTime(2025, 12, 31, 20, 59), // Batas maksimum jam 8:59 PM
                      onDateTimeChanged: (DateTime newDate) {
                        if (isTimeInRange(newDate)) {
                          setState(() {
                            deliveryTime = newDate;
                            isDeliveryTimeSelected = true;
                          });
                        } else {
                          // Tampilkan pesan error jika waktu di luar rentang
                          Get.snackbar(
                            'Waktu Tidak Tersedia',
                            'Silakan pilih waktu antara jam 6 pagi - 9 malam',
                            backgroundColor: SColors.danger500,
                            colorText: SColors.pureWhite,
                            icon: const Icon(Icons.error, color: Colors.white),
                            snackPosition: SnackPosition.TOP,
                          );
                        }
                      },
                      use24hFormat: true,
                    ),
                  ),
                ),
                const SizedBox(height: SSizes.md),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(vertical: SSizes.md),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(SSizes.borderRadiusmd),
                      ),
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      "Selesai",
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
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool dark = context.isDarkMode;
  
    // Hitung subtotal, pajak, dan ongkos kirim
    double subtotal = cartController.calculateSubtotal();
    double tax = subtotal * 0.05; // Pajak 5%
    // Logika ongkir baru
    double deliveryFee = isDelivery ? (subtotal >= 35000 ? 0 : 6000) : 0;
    double total = subtotal + tax + deliveryFee;

    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: Column(
          children: [
            // AppBar
            Container(
              color: dark ? SColors.pureBlack : SColors.pureWhite,
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  AppBar(
                    automaticallyImplyLeading: false, // Menghilangkan back button default
                    backgroundColor: dark ? SColors.pureBlack : SColors.pureWhite,
                    elevation: 0,
                    title: SizedBox(
                      height: kToolbarHeight,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Positioned(
                            left: 0,
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(
                                  color: dark ? SColors.softBlack50 : SColors.softBlack50,
                                  width: 1,
                                ),
                              ),
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                icon: Icon(
                                  SIcons.left,
                                  size: 24,
                                  color: dark ? SColors.pureWhite : SColors.softBlack500,
                                ),
                                onPressed: () async {
                                  bool shouldPop = await _onWillPop();
                                  if (shouldPop) {
                                    // ignore: use_build_context_synchronously
                                    Navigator.of(context).pop();
                                  }
                                },
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              STexts.payment,
                              style: dark
                                  ? STextTheme.titleBaseBlackDark
                                  : STextTheme.titleBaseBlackLight,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: SSizes.md),
                  Divider(
                    color: dark ? SColors.green50 : SColors.softBlack50,
                    thickness: 1,
                    height: 1,
                  ),
                ],
              ),
            ),
      
            // Konten Utama
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: SSizes.defaultMargin,
                              vertical: SSizes.defaultMargin,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Waktu Pengiriman
                                if (isDelivery) ...[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Waktu Pengiriman:",
                                        style: dark
                                            ? STextTheme.titleBaseBoldDark
                                            : STextTheme.titleBaseBoldLight,
                                      ),
                                      TextButton(
                                        onPressed: _showDatePicker,
                                        child: Text(
                                          isDeliveryTimeSelected
                                              ? "${deliveryTime.hour}:${deliveryTime.minute.toString().padLeft(2, '0')}, ${deliveryTime.day}-${deliveryTime.month}-${deliveryTime.year}"
                                              : "Pilih waktu pengiriman",
                                          style: const TextStyle(
                                            color: SColors.green500,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: SSizes.md),
                                ],
      
                                // Delivery Options dengan Callback
                                DeliveryOptions(
                                  isDelivery: isDelivery,
                                  onChangeMode: (isTapped) {
                                    if (isTapped) {
                                      _showConfirmationDialog();
                                    }
                                  },
                                ),
                                const SizedBox(height: SSizes.md2),
      
                                // Tampilkan SelectLocation atau PickupOption Berdasarkan Mode
                                if (isDelivery) ...[
                                  Text(
                                    STexts.selectLocation,
                                    style: dark
                                        ? STextTheme.titleBaseBoldDark
                                        : STextTheme.titleBaseBoldLight,
                                  ),
                                  const SizedBox(height: SSizes.md),
                                  const SelectLocation(),
                                ] else ...[
                                  Text(
                                    STexts.pickUp,
                                    style: dark
                                        ? STextTheme.titleBaseBoldDark
                                        : STextTheme.titleBaseBoldLight,
                                  ),
                                  const SizedBox(height: SSizes.md),
                                  const SeeAddressShop(),
                                ],
      
                                const SizedBox(height: SSizes.md2),
      
                                // Product Detail
                                Text(
                                  STexts.productDetail,
                                  style: dark
                                      ? STextTheme.titleBaseBoldDark
                                      : STextTheme.titleBaseBoldLight,
                                ),
                                const SizedBox(height: SSizes.md),

                                // Hapus SizedBox yang membatasi tinggi
                                DetailProductTransaction(
                                  products: Get.find<CartController>().getSelectedProducts(),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
      
      
                  // Bagian Bawah (Subtotal, Tax, Delivery, Total)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: SSizes.defaultMargin),
                    child: Column(
                      children: [
                        const SizedBox(height: SSizes.md2),
                        // SubTotal
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              STexts.subTotal,
                              style: dark
                                  ? STextTheme.bodyCaptionRegularDark
                                  : STextTheme.bodyCaptionRegularLight,
                            ),
                            const Spacer(),
                            Text(
                              "Rp ${NumberFormat.decimalPattern('id').format(subtotal)}",
                              style: dark
                                  ? STextTheme.titleCaptionBoldDark
                                  : STextTheme.titleCaptionBoldLight,
                            ),
                          ],
                        ),
                        const SizedBox(height: SSizes.sm),
                        
                        // Biaya Lainnya
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              STexts.tax,
                              style: dark
                                  ? STextTheme.bodyCaptionRegularDark
                                  : STextTheme.bodyCaptionRegularLight,
                            ),
                            const SizedBox(width: 4), // Jarak antara teks dan ikon
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      backgroundColor: dark ? SColors.pureBlack : SColors.pureWhite,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(SSizes.borderRadiusmd),
                                      ),
                                      title: const  Text(
                                        'Biaya Layanan',
                                        style: TextStyle(
                                          color: SColors.green500, // Warna teks hijau
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      content: Text(
                                        'Biaya layanan diterapkan agar kami dapat terus memberikan pengalaman belanja terbaik untuk Anda.',
                                        style: TextStyle(
                                          color: dark 
                                          ?SColors.textPrimaryDark
                                          : SColors.textPrimaryLight, 
                                        ),
                                      ),
                                      actions: [
                                        SizedBox(
                                          width: double.infinity, // Lebar tombol selebar popup
                                          child: TextButton(
                                            style: TextButton.styleFrom(
                                              backgroundColor: SColors.green50, // Warna background tombol
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(SSizes.borderRadiusmd),
                                              ),
                                            ),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text(
                                              'OK',
                                              style: STextTheme.titleCaptionBoldLight.copyWith(
                                                color: SColors.green500
                                              )
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(4), // Padding kecil untuk area klik
                                child: Icon(
                                  Icons.info_outline,
                                  size: 16,
                                  color: dark ? SColors.pureWhite : SColors.softBlack500,
                                ),
                              ),
                            ),
                            const Spacer(),
                            Text(
                              "Rp ${NumberFormat.decimalPattern('id').format(tax)}",
                              style: dark
                                  ? STextTheme.titleCaptionBoldDark
                                  : STextTheme.titleCaptionBoldLight,
                            ),
                          ],
                        ),
                        const SizedBox(height: SSizes.sm),

                        // Delivery
                        isDelivery
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  STexts.postage,
                                  style: dark
                                      ? STextTheme.bodyCaptionRegularDark
                                      : STextTheme.bodyCaptionRegularLight,
                                ),
                                const Spacer(),
                                // Kondisional untuk tampilan ongkir
                                subtotal >= 35000
                                    ? Text(
                                        "Gratis Ongkir",
                                        style: STextTheme.titleCaptionBoldDark.copyWith(
                                          color: SColors.green500
                                        )
                                      )
                                    : Text(
                                        "Rp ${NumberFormat.decimalPattern('id').format(deliveryFee)}",
                                        style: dark
                                            ? STextTheme.titleCaptionBoldDark
                                            : STextTheme.titleCaptionBoldLight,
                                      ),
                              ],
                            )
                          : const SizedBox.shrink(),

                        const SizedBox(height: SSizes.md),

                        // Garis
                        Dash(
                          length: MediaQuery.of(context).size.width - (SSizes.defaultMargin * 2),
                          dashLength: 4.0,
                          dashGap: 4.0,
                          direction: Axis.horizontal,
                          dashColor: dark ? SColors.green50 : SColors.softBlack50,
                          dashBorderRadius: 4.0,
                        ),

                        const SizedBox(height: SSizes.md),

                        // Total
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              STexts.total,
                              style: dark
                                  ? STextTheme.titleCaptionBoldDark
                                  : STextTheme.titleCaptionBoldLight,
                            ),
                            const Spacer(),
                            Text(
                              "Rp ${NumberFormat.decimalPattern('id').format(total)}",
                              style: STextTheme.titleBaseBoldDark.copyWith(
                                color: SColors.green500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: SSizes.md2 + SSizes.md),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                vertical: SSizes.lg2,
                              ),
                              minimumSize: const Size(double.infinity, 30),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(SSizes.borderRadiusmd),
                              ),
                              side: const BorderSide(
                                color: SColors.green500,
                                width: 1,
                              ),
                              backgroundColor: SColors.green500,
                              // Menambahkan disabledBackgroundColor untuk mengatur warna saat disabled
                              disabledBackgroundColor: SColors.green500,
                              // Menambahkan disabledForegroundColor untuk mengatur warna foreground saat disabled
                              disabledForegroundColor: SColors.pureWhite,
                            ),
                            onPressed: isProcessingPayment ? null : _showPaymentConfirmation,
                            child: isProcessingPayment
                                ? const SpinKitThreeBounce(
                                    color: SColors.pureWhite,
                                    size: 20.0,
                                  )
                                : Text(
                                    STexts.buyNow,
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
            ),
          ],
        ),
      ),
    );
  }
}
