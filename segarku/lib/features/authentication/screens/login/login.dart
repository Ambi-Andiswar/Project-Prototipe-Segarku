import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:segarku/features/authentication/controller/auth_controller.dart';
import 'package:segarku/features/authentication/screens/forgetPass/forget_password.dart';
import 'package:segarku/utils/constants/colors.dart';
import 'package:segarku/utils/models/fields.dart';
import 'package:segarku/utils/constants/image_strings.dart';
import 'package:segarku/utils/constants/sizes.dart';
import 'package:segarku/utils/constants/text_strings.dart';
import 'package:segarku/utils/theme/custom_themes/text_theme.dart'; 

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    bool isChecked = false;
    final formKey = GlobalKey<FormState>();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController emailController = TextEditingController();


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
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    AuthService().loginUser(
                      emailController.text.trim(),
                      passwordController.text.trim(),
                    );
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
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      STexts.login,
                      style: STextTheme.titleBaseBoldDark,
                  ),
                ],
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
              onPressed: () 
                {},
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  vertical: SSizes.lg2, // Padding vertikal sama dengan Container
                ),
                minimumSize: const Size(double.infinity, 30), // Membuat tombol selebar kontainer dan tinggi tertentu
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(SSizes.borderRadiusmd), // Sudut membulat yang sama
                ),
                side: const BorderSide(
                  color: SColors.softBlack50, // Sesuaikan dengan tema
                  width: 1, // Lebar border
                ),
                backgroundColor: dark 
                    ? SColors.pureBlack
                    : SColors.pureWhite,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center, // Menyusun elemen secara horizontal di tengah
                crossAxisAlignment: CrossAxisAlignment.center, // Menyusun elemen secara vertikal di tengah
                children: [
                  // Logo google
                  Image.asset(
                    SImages.google,
                    height: 18.0),
                  const SizedBox(width: SSizes.md2),
                  // Text google
                  Text(
                    STexts.google, // Teks tombol
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
