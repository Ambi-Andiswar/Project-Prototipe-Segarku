import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:segarku/features/authentification/controller/login_google/login_google_mdb.dart';

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
        return null;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final String? idToken = googleAuth.idToken; // Ini ID Token yang dibutuhkan
      print('ID Token: $idToken');

      if (googleAuth.accessToken != null && googleAuth.idToken != null) {
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        final UserCredential userCredential = await _auth.signInWithCredential(credential);
        final User? user = userCredential.user;

        if (user != null) {
          // Kirim hanya ID Token ke API MongoDB
          await LoginGoogleMdb.postUserDataToMongoDB(idToken);
        }

        return user;
      }
    } on FirebaseAuthException catch (e) {
      print('Error during Google sign-in: ${e.message}');
      print(e.stackTrace.toString());
    }
    return null;
  }
}