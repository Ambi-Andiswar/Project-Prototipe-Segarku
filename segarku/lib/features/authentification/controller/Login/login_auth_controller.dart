import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:segarku/navigation_menu.dart';

class AuthContorllerLogin {
  Future<void> loginUser(String email, String password) async {
    try {
      // ignore: unused_local_variable
      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      Get.to(() => const NavigationMenu());
    } on FirebaseAuthException catch (e) {
      String errorMessage;

      if (e.code == 'user-not-found') {
        errorMessage = 'Pengguna tidak ditemukan.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Kata sandi salah.';
      } else {
        errorMessage = 'Terjadi kesalahan: ${e.message}';
      }

      Get.snackbar(
        'Login Gagal',
        errorMessage,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}