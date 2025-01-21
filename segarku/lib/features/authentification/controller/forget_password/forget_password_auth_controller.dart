import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:segarku/utils/constants/colors.dart';

class AuthControllerResetPassword extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Fungsi untuk mengirim email reset password
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      // Mengirimkan email reset password
      await _auth.sendPasswordResetEmail(email: email);

      // Menampilkan notifikasi sukses
      Get.snackbar(
        "Success",
        "A reset password link has been sent to your email.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: SColors.success500,
        colorText: SColors.pureWhite,
      );

      // Menampilkan dialog popup sukses
      Get.defaultDialog(
        title: "Reset Password",
        middleText: "Check your email to reset your password.",
        confirmTextColor: SColors.pureWhite,
        onConfirm: () {
          // Aksi ketika tombol konfirmasi ditekan
          Get.back();  // Menutup dialog
        },
      );
    } catch (e) {
      // Menampilkan pesan error jika terjadi kesalahan
      String errorMessage = "An error occurred.";
      if (e is FirebaseAuthException) {
        if (e.code == 'user-not-found') {
          errorMessage = "No user found for this email.";
        } else if (e.code == 'invalid-email') {
          errorMessage = "The email address is not valid.";
        }
      }
      Get.snackbar(
        "Error",
        errorMessage,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: SColors.danger500,
        colorText: SColors.pureWhite,
      );
    }
  }
}