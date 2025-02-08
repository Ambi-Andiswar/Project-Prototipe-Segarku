import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:segarku/features/authentification/controller/Login/auth_controller_firebase.dart';
import 'package:segarku/features/authentification/controller/Login/auth_controller_mongodb.dart';
import 'package:segarku/features/authentification/controller/login_google/login_google_auth_contrller.dart';
import 'package:segarku/features/authentification/controller/login_google/login_google_mdb.dart';
import 'package:segarku/features/authentification/screens/forgetPass/forget_password.dart';
import 'package:segarku/navigation_menu.dart';
import 'package:segarku/utils/constants/colors.dart';
import 'package:segarku/utils/models/fields.dart';
import 'package:segarku/utils/constants/image_strings.dart';
import 'package:segarku/utils/constants/sizes.dart';
import 'package:segarku/utils/constants/text_strings.dart';
import 'package:segarku/utils/theme/custom_themes/text_theme.dart'; 

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  // ignore: unused_field, non_constant_identifier_names
  final AuthLoginMonggoDb _AuthContorllerLogin = AuthLoginMonggoDb();
  // ignore: non_constant_identifier_names
  final AuthControllerGoogle _authServiceGoogle = AuthControllerGoogle();

  bool _isLoading = false;

  String selectedAuthMethod = "Firebase"; // Default ke Firebase

  // ignore: non_constant_identifier_names
  Future<void> _LoginGoogle() async {
    setState(() {
      _isLoading = true;
    });

    final user = await _authServiceGoogle.signInWithGoogle();
    setState(() {
      _isLoading = false;
    });

    if (user != null) {
  final idToken = await user.getIdToken();
  await LoginGoogleMdb.postUserDataToMongoDB(idToken);

  Get.offAll(() => const NavigationMenu(initialIndex: 0));
    Get.snackbar(
      STexts.loginSuccessTitle,
      'Berhasil Masuk. Selamat datang kembali ${user.displayName}!',
      backgroundColor: SColors.green500,
      colorText: SColors.pureWhite,
      icon: const Icon(Icons.check_circle, color: Colors.white),
      snackPosition: SnackPosition.TOP,
    );

    Get.offAll(() => const NavigationMenu(initialIndex: 0));
  } else {
    Get.snackbar(
      STexts.loginFailedTitle,
      'Login dengan Google gagal.',
      backgroundColor: SColors.danger500,
      colorText: SColors.pureWhite,
      icon: const Icon(Icons.error, color: Colors.white),
      snackPosition: SnackPosition.TOP,
    );
    }
  }
  

  @override
  Widget build(BuildContext context) {
    final dark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    bool isChecked = false;

    return SingleChildScrollView(
      child: Form(
        key: formKey, // Tambahkan key untuk form
        child: Column(
          children: [
            // Email Field
            InputFields.emailField(context, dark, emailController),
            const SizedBox(height: SSizes.md),
            
            // Password Field
            InputFields.passwordField(context, dark, passwordController),
            const SizedBox(height: SSizes.md),
            
            // Checkbox RememberMe & Forget Password
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    // Checkbox
                    Transform.scale(
                      scale: 1.33, // Sesuaikan dengan rasio skala untuk ukuran 40
                      child: Checkbox(
                        value: isChecked,
                        onChanged: (value) {},
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(SSizes.borderRadiussm),
                        ),
                        side: BorderSide(
                          color: dark ? SColors.green50 : SColors.softBlack50,
                          width: 1,
                        ),
                        visualDensity: VisualDensity.compact,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ),
        
                    const SizedBox(width: SSizes.sm),
                    // Text RememberMe
                    Text(
                      STexts.forgetMe, 
                      style: dark 
                      ? STextTheme.bodyCaptionRegularDark
                      : STextTheme.bodyCaptionRegularLight
                    ),
                  ],
                ),
                // Forget Password Button
                TextButton(
                  onPressed: () => Get.to(() => const ResetPasswordScreen()),
                  style: TextButton.styleFrom(
                    overlayColor: Colors.transparent, // Menghilangkan efek
                  ),
                  child: const Text(
                    STexts.forgetPassword,
                    style: STextTheme.ctaSm,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: SSizes.lg2),
            
            // Button Mulai sekarang
            ElevatedButton(
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  setState(() {
                    _isLoading = true;
                  });

                  final result = await AuthLoginMonggoDb.loginUser(
                    emailController.text.trim(),
                    passwordController.text.trim(),
                  );

                  setState(() {
                    _isLoading = false;
                  });

                  if (result['success']) {
                    Get.offAll(() => const NavigationMenu(initialIndex: 0));
                    Get.snackbar(
                      STexts.loginSuccessTitle,
                      'Berhasil Masuk. Selamat datang kembali $emailController',
                      backgroundColor: SColors.green500,
                      colorText: SColors.pureWhite,
                      icon: const Icon(Icons.check_circle, color: Colors.white),
                      snackPosition: SnackPosition.TOP,
                    );
                  } else {
                    Get.snackbar(
                      STexts.loginFailedTitle,
                      'Coba periksa kembali email dan kata sandi Anda!',
                      backgroundColor: SColors.danger500,
                      colorText: SColors.pureWhite,
                      icon: const Icon(Icons.error, color: Colors.white),
                      snackPosition: SnackPosition.TOP,
                    );
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  vertical: SSizes.lg2,
                ),
                minimumSize: const Size(double.infinity, 30),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(SSizes.borderRadiusmd),
                ),
                side: const BorderSide(
                  color: SColors.green500,
                  width: 1,
                ),
              ),
              child: _isLoading
                  ? const SpinKitThreeBounce(
                      color:SColors.pureWhite ,
                      size: 20.0,
                    )
                  : Text(
                      STexts.login,
                      style: dark
                          ? STextTheme.titleBaseBoldLight
                          : STextTheme.titleBaseBoldDark,
                    ),
            ),
        
            const SizedBox(height: SSizes.md),
            
            // Divider & text or login with
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
        
                // Divider kiri
                const Flexible(
                  child: Divider(
                    color: SColors.softBlack50,
                    thickness: 1.5,
                  )
                ),
        
                const SizedBox(width: SSizes.md2),
        
                // Text atau login dengan
                Text(STexts.orSignInWith,
                  style: dark 
                    ? STextTheme.bodyCaptionRegularDark
                    : STextTheme.bodyCaptionRegularLight),
        
                const SizedBox(width: SSizes.md2),
                
                // divider kanan
                const Flexible(
                  child: Divider(
                    color:  SColors.softBlack50,
                    thickness: 1.5,
                  )
                ),
              ],
            ),
        
            const SizedBox(height: SSizes.md),
        
            // Tombol login dengan google
            ElevatedButton(
              onPressed: _isLoading ? null : _LoginGoogle,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  vertical: SSizes.lg2,
                ),
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(SSizes.borderRadiusmd),
                ),
                side: const BorderSide(
                  color: SColors.softBlack50,
                  width: 1,
                ),
                backgroundColor: dark ? SColors.pureBlack : SColors.pureWhite,
              ),
              child: _isLoading
                  ? const SpinKitThreeBounce(
                      color: SColors.pureWhite,
                      size: 20.0,
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(SImages.google, height: 18.0),
                        const SizedBox(width: SSizes.md2),
                        Text(
                          STexts.google,
                          style: dark
                              ? STextTheme.titleBaseBoldDark
                              : STextTheme.titleBaseBoldLight,
                        ),
                      ],
                    ),
            ),
        
            const SizedBox(height: 50),
        
            // Text Agree to Policy
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: RichText(
                textAlign: TextAlign.center,
                  text: TextSpan(
                    text: '${STexts.agreeToLogin} ',
                    style: dark 
                    ? STextTheme.bodyCaptionRegularDark
                    : STextTheme.bodyCaptionRegularLight,
                    children: [
                      TextSpan(
                        text: STexts.agreeToTerms,
                        style: dark 
                        ? STextTheme.titleCaptionBoldDark
                        : STextTheme.titleCaptionBoldLight,
                        recognizer: TapGestureRecognizer()..onTap = () {},
                      ),
                      TextSpan(
                        text: ' ${STexts.and} ',
                        style: dark 
                        ? STextTheme.bodyCaptionRegularDark
                        : STextTheme.bodyCaptionRegularLight
                        ),
                      TextSpan(
                        text: STexts.privacyPolicy,
                        style: dark 
                        ? STextTheme.titleCaptionBoldDark
                        : STextTheme.titleCaptionBoldLight,
                        recognizer: TapGestureRecognizer()..onTap = () {},
                        ),
                      ],
                  ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}