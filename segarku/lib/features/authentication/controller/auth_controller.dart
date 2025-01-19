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
