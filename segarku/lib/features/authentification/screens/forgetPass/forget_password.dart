import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:segarku/commons/widget/appbar/appbar.dart';
import 'package:segarku/features/authentification/controller/Reset_password/reset_password_auth_controller.dart';
import 'package:segarku/features/authentification/screens/forgetPass/confirm_email.dart';
import 'package:segarku/utils/constants/colors.dart';
import 'package:segarku/utils/constants/sizes.dart';
import 'package:segarku/utils/models/fields.dart';
import 'package:segarku/utils/theme/custom_themes/text_theme.dart';
import '../../../../../utils/constants/text_strings.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool dark = context.isDarkMode;
    final TextEditingController emailController = TextEditingController();
    final AuthControllerResetPassword authController = Get.put(AuthControllerResetPassword());

    return Scaffold(
      body: Column(
        children: [
          // SCustomAppBar dengan Divider di bawah
          Container(
            color: dark 
              ? SColors.pureBlack 
              : SColors.pureWhite, // Ganti dengan warna yang sesuai
            child: Column(
              children: [
                const SizedBox(height: 20),
                SCustomAppBar(
                  title: STexts.resetPassword,
                  darkMode: dark, 
                ),
                const SizedBox(height: SSizes.md),
                Divider(
                  color: dark ? SColors.green50 : SColors.softBlack50,
                  thickness: 1,
                  height: 1, // Pastikan tidak ada ruang tambahan
                ),
              ],
            ),
          ),

          // Konten utama
          Expanded(
            child: Column(
              children: [
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

                              // Title
                              Text(
                                STexts.resetPasswordTitle,
                                style: dark
                                    ? STextTheme.titleLgBolddark
                                    : STextTheme.titleLgBoldLight,
                              ),
                              const SizedBox(height: SSizes.xs),

                              // Subtitle
                              Text(
                                STexts.resetPasswordSubTitle,
                                style: dark
                                    ? STextTheme.bodyCaptionRegularDark
                                    : STextTheme.bodyCaptionRegularLight,
                              ),
                              const SizedBox(height: SSizes.lg2),

                              // Email
                              InputFields.emailField(context, dark, emailController),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: SSizes.defaultMargin),
                  child: Column(
                    children: [
                      // Tombol Kirim
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            final email = emailController.text.trim();
                            if (email.isNotEmpty && GetUtils.isEmail(email)) {
                              // Memanggil fungsi untuk mengirim email reset password
                              authController.sendPasswordResetEmail(email).then((_) {
                                // Jika berhasil mengirim email, pindah ke halaman ConfirmEmailPassScreen
                                Get.to(() => ConfirmEmailPassScreen(email: email));
                              }).catchError((e) {
                                // Jika ada error saat mengirim email
                                Get.snackbar(
                                  "Error",
                                  e.toString(),
                                  snackPosition: SnackPosition.TOP,
                                  backgroundColor: SColors.danger500,
                                  colorText: SColors.pureWhite,
                                  borderRadius: 12,
                                  margin: const EdgeInsets.all(16),
                                );
                              });
                            } else {
                              // Jika email tidak valid
                              Get.snackbar(
                                "Oops, Ada yang salah",
                                "Email Anda kemungkinan kosong atau tidak valid.",
                                snackPosition: SnackPosition.TOP,
                                backgroundColor: SColors.danger500,
                                colorText: Colors.white,
                                borderRadius: 12,
                                margin: const EdgeInsets.all(16),
                              );
                            }
                          },
                          child: Text(
                            STexts.send,
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
    );
  }
}
