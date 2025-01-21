import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:segarku/navigation_menu.dart';
import 'package:segarku/utils/constants/colors.dart';

class AuthContorllerSignup extends GetxController {
  // ignore: unused_field
  final FirebaseAuth _auth = FirebaseAuth.instance;
    Future<void> registerUser(String email, String password) async {
    try {
      // Buat akun menggunakan Firebase
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      Get.snackbar('Registrasi Berhasil', 'Akun Anda telah dibuat',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: SColors.green500,
          colorText: SColors.pureWhite);

      // Navigasi ke halaman NavigationMenu
      Get.offAll(() => const NavigationMenu(initialIndex: 0));
    } on FirebaseAuthException catch (e) {
      // Tampilkan pesan error
      String errorMessage;
      if (e.code == 'weak-password') {
        errorMessage = 'Kata sandi terlalu lemah.';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'Email ini sudah digunakan.';
      } else {
        errorMessage = e.message ?? 'Terjadi kesalahan.';
      }
      Get.snackbar('Registrasi Gagal', errorMessage,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: SColors.danger500,
          colorText: SColors.pureWhite);
        print('Error saat registrasi: $errorMessage');
    }
  }

}