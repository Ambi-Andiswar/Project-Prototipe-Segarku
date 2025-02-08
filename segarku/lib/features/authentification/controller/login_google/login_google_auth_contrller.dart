import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:segarku/features/authentification/controller/login_google/login_google_mdb.dart';
import 'package:segarku/utils/local_storage/user_storage.dart';

class AuthControllerGoogle extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Rxn<User> firebaseUser = Rxn<User>();

  @override
  void onInit() {
    firebaseUser.bindStream(_auth.authStateChanges());
    super.onInit();
  }

  User? get user => firebaseUser.value;

  Future<User?> signInWithGoogle() async {
  try {
    await _googleSignIn.signOut();

    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if (googleUser == null) return null;

    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final String? idToken = googleAuth.idToken;
    print('ID Token: $idToken');

    if (googleAuth.accessToken != null && googleAuth.idToken != null) {
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        // Kirim data ke MongoDB
        final mongoResponse = await LoginGoogleMdb.postUserDataToMongoDB(idToken);

        // Jika berhasil post ke MongoDB, simpan ke local storage
        if (mongoResponse != null && mongoResponse['api_key'] != null) {
          // Ambil data terbaru dari MongoDB
          final updatedUserData = await LoginGoogleMdb.getUserDataFromMongoDB(mongoResponse['api_key'], user.uid);

          if (updatedUserData != null) {
            // Simpan data terbaru ke local storage
            await UserStorage.saveUserSession(
              apiKey: mongoResponse['api_key'],
              uid: user.uid,
              userData: {
                'nama': updatedUserData['nama'] ?? user.displayName ?? '', // Gunakan nama dari MongoDB
                'email': updatedUserData['email'] ?? user.email ?? '',
                'status': updatedUserData['status'] ?? 'active',
                'photoUrl': user.photoURL ?? '',
                'telepon': updatedUserData['telepon'] ?? user.phoneNumber ?? '',
                'emailVerified': user.emailVerified,
                'auth_provider': 'google',
              },
            );
          }
        }
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