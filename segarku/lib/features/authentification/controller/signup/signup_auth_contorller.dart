import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
          snackPosition: SnackPosition.TOP,
          backgroundColor: SColors.green500,
          colorText: SColors.pureWhite,
          borderRadius: 12,
          icon: const Icon(Icons.check_circle, color: Colors.white),
          margin: const EdgeInsets.all(16),
        );
          

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
          snackPosition: SnackPosition.TOP,
          backgroundColor: SColors.danger500,
          colorText: SColors.pureWhite,
          icon: const Icon(Icons.error, color: Colors.white),
          borderRadius: 12,
          margin: const EdgeInsets.all(16),);
        print('Error saat registrasi: $errorMessage');
    }
  }

}