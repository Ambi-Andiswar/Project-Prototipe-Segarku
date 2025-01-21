import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';  // Import FirebaseAuth
import 'package:segarku/commons/widget/appbar/appbar.dart';
import 'package:segarku/features/authentication/screens/welcome.dart';
import 'package:segarku/utils/constants/colors.dart';
import 'package:segarku/utils/constants/sizes.dart';
import 'package:segarku/utils/theme/custom_themes/text_theme.dart';
import '../../../../../utils/constants/text_strings.dart';

class ConfirmEmailPassScreen extends StatelessWidget {
  const ConfirmEmailPassScreen ({super.key});

  @override
  Widget build(BuildContext context) {
    final bool dark = context.isDarkMode;

    // Mendapatkan email dari pengguna yang sedang login
    final User? user = FirebaseAuth.instance.currentUser;
    final String? email = user?.email ?? "Email not found"; // Default jika email kosong

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
                const SizedBox(height: 52),
                SCustomAppBar(
                  title: STexts.confirmEmail,
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

                        // Title
                        Text(
                          STexts.confirmEmailResetPasswordTitle,
                          style: dark
                              ? STextTheme.titleLgBolddark
                              : STextTheme.titleLgBoldLight,
                        ),

                        const SizedBox(height: SSizes.xs),

                        // Subtitle - Menggunakan email yang diambil dari Firebase
                        Text(
                          "Tautan untuk mengatur ulang kata sandi telah dikirimkan ke alamat email Anda, yaitu $email. Silakan buka email tersebut dan ikuti instruksi yang diberikan untuk mengatur ulang kata sandi Anda",
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
                // Text Login Now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // text non activ
                    Text(
                      STexts.noEmailSend,
                      style: dark
                          ? STextTheme.bodyCaptionRegularDark
                          : STextTheme.bodyCaptionRegularLight,
                    ),

                    const SizedBox(width: SSizes.sm),
                    // Kirim Ulang
                    TextButton(
                      onPressed: () => Get.to(() => const WelcomeScreen()),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: const Text(
                        STexts.resend,
                        style: STextTheme.ctaSm,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: SSizes.md2),

                // Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.back();
                      Get.back();
          
                    },
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
