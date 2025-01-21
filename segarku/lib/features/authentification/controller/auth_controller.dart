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


class AuthControllerGoogle extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Observable user
  Rxn<User> firebaseUser = Rxn<User>();

  @override
  void onInit() {
    firebaseUser.bindStream(_auth.authStateChanges());
    super.onInit();
  }

  User? get user => firebaseUser.value;

  Future<User?> signInWithGoogle() async {
  try {
    // Logout dari GoogleSignIn terlebih dahulu untuk memastikan dialog muncul
    await _googleSignIn.signOut();

    // Mulai proses sign-in
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
    print('Error during Google sign-in: ${e.message}');
    print(e.stackTrace.toString());
  }
  return null; // Jika terjadi kesalahan, kembalikan null

  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}


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