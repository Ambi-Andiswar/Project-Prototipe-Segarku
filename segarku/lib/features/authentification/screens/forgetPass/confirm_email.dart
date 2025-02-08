import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:segarku/commons/widget/appbar/appbar.dart';
import 'package:segarku/features/authentification/controller/Reset_password/reset_password_auth_controller.dart'; // Import controller
import 'package:segarku/features/authentification/screens/forgetPass/succesfull_reset_pass.dart';
import 'package:segarku/utils/constants/colors.dart';
import 'package:segarku/utils/constants/sizes.dart';
import 'package:segarku/utils/theme/custom_themes/text_theme.dart';
import '../../../../../utils/constants/text_strings.dart';

class ConfirmEmailPassScreen extends StatefulWidget {
  const ConfirmEmailPassScreen({
    super.key,
    required this.email, // Tambahkan parameter email
  });

  final String email; // Deklarasikan variabel untuk menyimpan email

  @override
  State<ConfirmEmailPassScreen> createState() => _ConfirmEmailPassScreenState();
  }
  class _ConfirmEmailPassScreenState extends State<ConfirmEmailPassScreen> {
  final AuthControllerResetPassword authController = Get.put(AuthControllerResetPassword());
  bool _isResendLoading = false;
  bool _isDoneLoading = false;

  @override
  Widget build(BuildContext context) {
    final bool dark = context.isDarkMode;
    final AuthControllerResetPassword authController = Get.put(AuthControllerResetPassword()); // Tambahkan controller

    return Scaffold(
      body: Column(
        children: [
          // SCustomAppBar dengan Divider di bawah
          Container(
            color: dark ? SColors.pureBlack : SColors.pureWhite,
            child: Column(
              children: [
                const SizedBox(height: 20),
                SCustomAppBar(
                  title: STexts.confirmEmail,
                  darkMode: dark,
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
          // Bagian konten utama
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: SSizes.defaultMargin),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: SSizes.lg2),
                        Text(
                          STexts.confirmEmailResetPasswordTitle,
                          style: dark
                              ? STextTheme.titleLgBolddark
                              : STextTheme.titleLgBoldLight,
                        ),
                        const SizedBox(height: SSizes.xs),
                        Text(
                          "Tautan untuk mengatur ulang kata sandi telah dikirimkan ke alamat email Anda, yaitu ${widget.email}. Silakan buka email tersebut dan ikuti instruksi yang diberikan untuk mengatur ulang kata sandi Anda",
                          style: dark
                              ? STextTheme.bodyCaptionRegularDark
                              : STextTheme.bodyCaptionRegularLight,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Bagian bawah
                    Padding(
            padding: const EdgeInsets.symmetric(horizontal: SSizes.defaultMargin),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      STexts.noEmailSend,
                      style: dark
                          ? STextTheme.bodyCaptionRegularDark
                          : STextTheme.bodyCaptionRegularLight,
                    ),
                    const SizedBox(width: SSizes.sm),
                    TextButton(
                      onPressed: _isResendLoading
                          ? null
                          : () async {
                              setState(() {
                                _isResendLoading = true;
                              });
                              try {
                                await authController.sendPasswordResetEmail(widget.email);
                                Get.snackbar(
                                  "Berhasil",
                                  "Email reset password telah dikirim ulang",
                                  snackPosition: SnackPosition.TOP,
                                  backgroundColor: SColors.green500,
                                  colorText: SColors.pureWhite,
                                  borderRadius: 12,
                                  margin: const EdgeInsets.all(16),
                                );
                              } catch (e) {
                                Get.snackbar(
                                  "Error",
                                  e.toString(),
                                  snackPosition: SnackPosition.TOP,
                                  backgroundColor: SColors.danger500,
                                  colorText: SColors.pureWhite,
                                  borderRadius: 12,
                                  margin: const EdgeInsets.all(16),
                                );
                              } finally {
                                setState(() {
                                  _isResendLoading = false;
                                });
                              }
                            },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: _isResendLoading
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: SColors.green500,
                              ),
                            )
                          : const Text(
                              STexts.resend,
                              style: STextTheme.ctaSm,
                            ),
                    ),
                  ],
                ),
                const SizedBox(height: SSizes.md2),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isDoneLoading
                        ? () {}
                        : () {
                            setState(() {
                              _isDoneLoading = true;
                            });
                            // Simulasi delay
                            Future.delayed(const Duration(seconds: 1), () {
                              setState(() {
                                _isDoneLoading = false;
                              });
                              Get.to(() => const SuccesfullResetPassScreen());
                            });
                          },
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
                      disabledBackgroundColor: SColors.green500,
                      disabledForegroundColor: SColors.pureWhite,
                    ),
                    child: _isDoneLoading
                        ? const SpinKitThreeBounce(
                            color: SColors.pureWhite,
                            size: 20.0,
                          )
                        : Text(
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