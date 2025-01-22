import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
      // ignore: avoid_print
      print('Error during Google sign-in: ${e.message}');
      // ignore: avoid_print
      print(e.stackTrace.toString());
    }
    return null; // Jika terjadi kesalahan, kembalikan null
  }
}