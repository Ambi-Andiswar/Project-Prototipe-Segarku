import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:segarku/commons/widget/appbar/appbar.dart';
import 'package:segarku/features/authentification/controller/Reset_password/reset_password_auth_controller.dart';
import 'package:segarku/features/authentification/screens/forgetPass/confirm_email.dart';
import 'package:segarku/utils/constants/colors.dart';
import 'package:segarku/utils/constants/sizes.dart';
import 'package:segarku/utils/local_storage/user_storage.dart';
import 'package:segarku/utils/models/fields.dart';
import 'package:segarku/utils/theme/custom_themes/text_theme.dart';
import '../../../../../utils/constants/text_strings.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  final AuthControllerResetPassword authController = Get.put(AuthControllerResetPassword());
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadUserEmail();
  }

  Future<void> _loadUserEmail() async {
    final userData = await UserStorage.getUserData();
    if (userData != null && userData['email'] != null) {
      setState(() {
        emailController.text = userData['email'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool dark = context.isDarkMode;

    return Scaffold(
      body: Column(
        children: [
          // SCustomAppBar (tetap sama seperti sebelumnya)
          Container(
            color: dark ? SColors.pureBlack : SColors.pureWhite,
            child: Column(
              children: [
                const SizedBox(height: 20),
                SCustomAppBar(
                  title: STexts.resetPassword,
                  darkMode: dark,
                ),
                const SizedBox(height: SSizes.md),
                Divider(
                  color: dark ? SColors.green50 : SColors.softBlack50,
                  thickness: 1,
                  height: 1,
                ),
              ],
            ),
          ),

          // Konten utama
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: SSizes.defaultMargin),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: SSizes.lg2),

                              // Title & Subtitle (tetap sama)
                              Text(
                                STexts.resetPasswordTitle,
                                style: dark
                                    ? STextTheme.titleLgBolddark
                                    : STextTheme.titleLgBoldLight,
                              ),
                              const SizedBox(height: SSizes.xs),
                              Text(
                                STexts.resetPasswordSubTitle,
                                style: dark
                                    ? STextTheme.bodyCaptionRegularDark
                                    : STextTheme.bodyCaptionRegularLight,
                              ),
                              const SizedBox(height: SSizes.lg2),

                              // Email field dengan data yang sudah terisi
                              InputFields.emailField(
                                context, 
                                dark, 
                                emailController,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Button (tetap sama seperti sebelumnya dengan loading yang sudah dimodifikasi)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: SSizes.defaultMargin),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _isLoading 
                              ? () {}
                              : () async {
                                  final email = emailController.text.trim();
                                  if (email.isNotEmpty && GetUtils.isEmail(email)) {
                                    setState(() {
                                      _isLoading = true;
                                    });

                                    try {
                                      await authController.sendPasswordResetEmail(email);
                                      setState(() {
                                        _isLoading = false;
                                      });
                                      Get.to(() => ConfirmEmailPassScreen(email: email));
                                    } catch (e) {
                                      setState(() {
                                        _isLoading = false;
                                      });
                                      Get.snackbar(
                                        "Error",
                                        e.toString(),
                                        snackPosition: SnackPosition.TOP,
                                        backgroundColor: SColors.danger500,
                                        colorText: SColors.pureWhite,
                                        borderRadius: 12,
                                        margin: const EdgeInsets.all(16),
                                      );
                                    }
                                  } else {
                                    Get.snackbar(
                                      "Oops, Ada yang salah",
                                      "Email Anda kemungkinan kosong atau tidak valid.",
                                      snackPosition: SnackPosition.TOP,
                                      backgroundColor: SColors.danger500,
                                      colorText: Colors.white,
                                      borderRadius: 12,
                                      margin: const EdgeInsets.all(16),
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
                            backgroundColor: SColors.green500,
                            disabledBackgroundColor: SColors.green500,
                            disabledForegroundColor: SColors.pureWhite,
                          ),
                          child: _isLoading
                              ? const SpinKitThreeBounce(
                                  color: SColors.pureWhite,
                                  size: 20.0,
                                )
                              : Text(
                                  STexts.send,
                                  style: dark
                                      ? STextTheme.titleBaseBoldLight
                                      : STextTheme.titleBaseBoldDark,
                                ),
                        ),
                      ),
                      const SizedBox(height: SSizes.xl),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
}