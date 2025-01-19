import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:segarku/navigation_menu.dart';
import 'package:segarku/utils/constants/colors.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
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
    }
  }

}


class AuthService {
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


class AuthControllerGoogle {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User get user => _auth.currentUser!;

  Stream<User?> get authState => _auth.authStateChanges();

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<User?> signInWithGoogle() async {
  try {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if (googleUser == null) {
      // Jika pengguna membatalkan login, kembalikan null
      return null;
    }
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    if (googleAuth.accessToken != null && googleAuth.idToken != null) {
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      return userCredential.user; // Kembalikan user yang berhasil login
    }
  } on FirebaseAuthException catch (e) {
    // ignore: avoid_print
    print('Error during Google sign-in: ${e.message}');
    // ignore: avoid_print
    print(e.stackTrace.toString());
  }
  return null; // Jika terjadi kesalahan, kembalikan null
}


  Future<void> signOut() async {
    _auth.signOut();
  }
}
