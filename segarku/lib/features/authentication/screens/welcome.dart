import 'package:flutter/material.dart';
import 'package:segarku/features/authentication/screens/login/login.dart';
import 'package:segarku/features/authentication/screens/register/register.dart';
import 'package:segarku/utils/constants/appbar_welcome.dart';
import 'package:segarku/utils/constants/colors.dart';
import 'package:segarku/utils/constants/sizes.dart';
import 'package:segarku/utils/constants/text_strings.dart';
import 'package:segarku/utils/helpers/helper_functions.dart';
import 'package:segarku/utils/theme/custom_themes/text_theme.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = Theme.of(context).brightness == Brightness.dark
        ? SColors.pureBlack
        : SColors.pureWhite;

    final dark = SHelperFunctions.isDarkMode(context);

    return Scaffold(
      body: Stack(
        children: [
          // Background color
          Container(
            color: backgroundColor,
          ),
          // AppBarWelcome
          const AppBarWelcome(),

          // Title dan Subtitle
          Padding(
            padding: const EdgeInsets.only(
              left: SSizes.defaultMargin,
              right: SSizes.defaultMargin,
              top: 149,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  STexts.welcomeSegarku,
                  style: dark
                      ? STextTheme.bodyMdRegularDark
                      : STextTheme.bodyMdRegularLight,
                ),
                const SizedBox(height: SSizes.xs),
                Text(
                  isLogin
                  ? STexts.loginSubTitle
                  : STexts.registerSubTitle,
                    style: dark
                        ? STextTheme.titleXlBlackDark
                        : STextTheme.titleXlBlackLight),

                const SizedBox(height: SSizes.lg2),

                // Text Button login & Register
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Login button
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isLogin = true;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              isLogin
                              ? (dark ? SColors.pureBlack : SColors.pureWhite)
                              : (dark ? SColors.softBlack400 : SColors.softWhite),
                          side: const BorderSide(color: SColors.softBlack50),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(SSizes.borderRadiussm),
                              bottomLeft: Radius.circular(SSizes.borderRadiussm),
                            ),
                          ),
                        ),
                        child: Text(
                          STexts.login,
                          style: isLogin
                              ? (dark
                                  ? STextTheme.titleBaseBoldDark
                                  : STextTheme.titleBaseBoldLight)
                              : (dark
                                  ? STextTheme.bodyBaseRegularDark
                                  : STextTheme.bodyBaseRegularLight),
                        ),
                      ),
                    ),

                    // Register Button
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isLogin = false;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              !isLogin
                              ? (dark ? SColors.pureBlack : SColors.pureWhite)
                              : (dark ? SColors.softBlack400 : SColors.softWhite),
                          side: const BorderSide(color: SColors.softBlack50),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(SSizes.borderRadiussm),
                              bottomRight: Radius.circular(SSizes.borderRadiussm),
                            ),
                          ),
                        ),
                        child: Text(
                          STexts.register,
                          style: dark
                              ? (!isLogin
                                  ? STextTheme.titleBaseBoldDark
                                  : STextTheme.bodyBaseRegularDark)
                              : (!isLogin
                                  ? STextTheme.titleBaseBoldLight
                                  : STextTheme.bodyBaseRegularLight),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: SSizes.lg2),
                Expanded(
                  child: isLogin ? const LoginScreen() : const RegisterScreen(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
