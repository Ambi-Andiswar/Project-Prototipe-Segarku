import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:segarku/features/authentification/controller/auth_controller.dart';
import 'package:segarku/features/authentification/controller/signup/signup_auth_contorller.dart';
import 'package:segarku/navigation_menu.dart';
import 'package:segarku/utils/constants/colors.dart';
import 'package:segarku/utils/models/fields.dart';
import 'package:segarku/utils/constants/image_strings.dart';
import 'package:segarku/utils/constants/sizes.dart';
import 'package:segarku/utils/constants/text_strings.dart';
import 'package:segarku/utils/theme/custom_themes/text_theme.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final AuthContorllerSignup _authService = AuthContorllerSignup();
  final AuthControllerGoogle _authServiceGoogle = AuthControllerGoogle();

  bool _isLoading = false;

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
      Get.offAll(() => const NavigationMenu(initialIndex: 0));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login berhasil, selamat datang ${user.displayName}!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login dengan Google gagal.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final dark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    bool isChecked = false;

    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          children: [
            InputFields.usernameField(context, dark),
            const SizedBox(height: SSizes.md),
            InputFields.emailField(context, dark, emailController),
            const SizedBox(height: SSizes.md),
            InputFields.noHandphoneField(context, dark),
            const SizedBox(height: SSizes.md),
            InputFields.passwordField(context, dark, passwordController),
            const SizedBox(height: SSizes.md),
            InputFields.confirmPasswordField(context, dark, passwordController),
            const SizedBox(height: SSizes.md),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Transform.scale(
                      scale: 1.33,
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
                    Text(
                      STexts.forgetMe,
                      style: dark
                          ? STextTheme.bodyCaptionRegularDark
                          : STextTheme.bodyCaptionRegularLight,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: SSizes.lg2),
            ElevatedButton(
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  await _authService.registerUser(
                    emailController.text.trim(),
                    passwordController.text.trim(),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  vertical: SSizes.lg2,
                ),
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(SSizes.borderRadiusmd),
                ),
                side: const BorderSide(
                  color: SColors.green500,
                  width: 2,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    STexts.register,
                    style: dark
                      ? STextTheme.titleBaseBoldLight
                      : STextTheme.titleBaseBoldDark,
                  ),
                ],
              ),
            ),
            const SizedBox(height: SSizes.md),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Flexible(
                  child: Divider(
                    color: SColors.softBlack50,
                    thickness: 1.5,
                  ),
                ),
                const SizedBox(width: SSizes.md2),
                Text(
                  STexts.orSignUpWith,
                  style: dark
                      ? STextTheme.bodyCaptionRegularDark
                      : STextTheme.bodyCaptionRegularLight,
                ),
                const SizedBox(width: SSizes.md2),
                const Flexible(
                  child: Divider(
                    color: SColors.softBlack50,
                    thickness: 1.5,
                  ),
                ),
              ],
            ),
            const SizedBox(height: SSizes.md),
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
                  ? const CircularProgressIndicator()
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
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: '${STexts.agreeToRegister} ',
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
                          : STextTheme.bodyCaptionRegularLight,
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
