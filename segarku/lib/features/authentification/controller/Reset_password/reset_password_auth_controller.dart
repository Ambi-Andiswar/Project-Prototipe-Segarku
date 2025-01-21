import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:segarku/utils/constants/colors.dart';
import 'package:segarku/utils/constants/text_strings.dart';

class AuthControllerResetPassword extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Fungsi untuk mengirim email reset password
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      // Mengirimkan email reset password
      await _auth.sendPasswordResetEmail(email: email);

      // Menampilkan notifikasi sukses
      Get.snackbar(
        STexts.resetPassTitle,
        "Kami telah mengiriman verifikasi ke email anda. Coba Anda periksa email $email", // Sisipkan email user di sini
        snackPosition: SnackPosition.TOP,
        backgroundColor: SColors.success500,
        colorText: SColors.pureWhite,
        borderRadius: 12,
        icon: const Icon(Icons.check_circle, color: Colors.white),
        margin: const EdgeInsets.all(16),
        
      );

    } catch (e) {
      // Menampilkan pesan error jika terjadi kesalahan
      String errorMessage = "Sementara ini belum bisa mereset password Anda";
      if (e is FirebaseAuthException) {
        if (e.code == 'user-not-found') {
          errorMessage = STexts.userNotFound;
        } else if (e.code == 'invalid-email') {
          errorMessage = STexts.invalidEmail;
        }
      }
      Get.snackbar(
        "Error",
        errorMessage,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: SColors.danger500,
        colorText: SColors.pureWhite,
        borderRadius: 12,
        margin: const EdgeInsets.all(16),
      );
    }
  }
}