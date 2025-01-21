import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:segarku/navigation_menu.dart';
import 'package:segarku/utils/constants/colors.dart';
import 'package:segarku/utils/constants/text_strings.dart';

class AuthControllerLogin {
  Future<void> loginUser(String email, String password) async {
    try {
      // Melakukan login dengan Firebase Authentication
      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      final User? user = userCredential.user;

      // Snackbar untuk login berhasil
      Get.snackbar(
        STexts.loginSuccessTitle,
        '${STexts.loginSuccessMessage} ${user?.email ?? ''}',
        backgroundColor: SColors.green500,
        colorText: SColors.pureWhite,
        icon: const Icon(Icons.check_circle, color: Colors.white),
        snackPosition: SnackPosition.TOP,
        borderRadius: 12,
        margin: const EdgeInsets.all(16),
      );

      // Arahkan ke halaman utama
      Get.to(() => const NavigationMenu());
    } on FirebaseAuthException catch (e) {
      String errorMessage;

      // Debugging: Cetak kode dan pesan kesalahan untuk pengembangan
      debugPrint('FirebaseAuthException code: ${e.code}');
      debugPrint('FirebaseAuthException message: ${e.message}');

      // Penanganan berdasarkan kode kesalahan
      switch (e.code) {
        case 'user-not-found':
          errorMessage = STexts.errorMessage;
          break;
        case 'wrong-password':
          errorMessage = STexts.wrongPassword;
          break;
        case 'invalid-email':
          errorMessage = STexts.invalidEmail;
          break;
        case 'too-many-requests':
          errorMessage = STexts.toManyRequest;
          break;
        default: 
          errorMessage = STexts.loginFailedMessage;
      }

      // Snackbar untuk login gagal
      Get.snackbar(
        STexts.loginFailedTitle,
        errorMessage,
        backgroundColor: SColors.danger500,
        colorText: SColors.pureWhite,
        icon: const Icon(Icons.error, color: Colors.white),
        snackPosition: SnackPosition.TOP,
        borderRadius: 12,
        margin: const EdgeInsets.all(16),
      );
    } catch (e) {
      // Penanganan jika terjadi kesalahan lain
      debugPrint('Unhandled Exception: $e');

      Get.snackbar(
        STexts.loginFailedTitle,
        STexts.loginFailedsubTitle,
        backgroundColor: SColors.danger500,
        colorText: SColors.pureWhite,
        icon: const Icon(Icons.error, color: Colors.white),
        snackPosition: SnackPosition.TOP,
        borderRadius: 12,
        margin: const EdgeInsets.all(16),
      );
    }
  }
}
