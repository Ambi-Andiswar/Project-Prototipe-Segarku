import 'package:flutter/material.dart';
import 'package:segarku/utils/constants/colors.dart';
import 'package:segarku/utils/constants/icons.dart';
import 'package:segarku/utils/constants/sizes.dart';
import 'package:segarku/utils/constants/text_strings.dart';
import 'package:segarku/utils/theme/custom_themes/text_theme.dart';

class InputFields {
  //-------------------- Email Field --------------------//
  static Widget emailField(BuildContext context, bool dark) {
    // FocusNode untuk mendeteksi fokus
    final FocusNode focusNode = FocusNode();
    bool isFocused = false;

    return StatefulBuilder(
      builder: (context, setState) {
        // Listener untuk fokus
        focusNode.addListener(() {
          setState(() {
            isFocused = focusNode.hasFocus;
          });
        });

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text Email
            Text(
              STexts.email,
              style: dark
                  ? STextTheme.titleCaptionBoldDark
                  : STextTheme.titleCaptionBoldLight,
            ),
            const SizedBox(height: SSizes.xs),

            // Text & Icons Form Field Email
            TextFormField(
              focusNode: focusNode,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: SSizes.md2, vertical: SSizes.md),
                // Menambahkan Icon di dalam field
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(top:SSizes.md, bottom: SSizes.md, left: SSizes.md2, right: SSizes.sm2),
                  child: Icon(
                    SIcons.email,
                    color: isFocused
                        ? (dark ? SColors.green500 : SColors.green500)
                        : (dark ? SColors.softBlack50 : SColors.softBlack300),
                  ),
                ),
                // Text email field
                labelText: STexts.emailField,
                labelStyle: dark
                    ? STextTheme.bodyBaseRegularLight
                    : STextTheme.bodyBaseRegularDark,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                hintText: STexts.emailField,
                hintStyle: dark
                    ? STextTheme.bodyBaseRegularLight
                    : STextTheme.bodyBaseRegularDark,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(SSizes.borderRadiussm),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(SSizes.borderRadiussm),
                  borderSide: const BorderSide(color: SColors.softBlack50),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(SSizes.borderRadiussm),
                  borderSide: const BorderSide(color: SColors.green500),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  //-------------------- Password Field --------------------//
  static Widget passwordField(BuildContext context, bool dark) {
  // FocusNode untuk mendeteksi fokus
  final FocusNode focusNode = FocusNode();
  bool isFocused = false;
  bool isPasswordVisible = false;

  return StatefulBuilder(
    builder: (context, setState) {
      // Listener untuk fokus
      focusNode.addListener(() {
        setState(() {
          isFocused = focusNode.hasFocus;
        });
      });

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text Password
          Text(
            STexts.password,
            style: dark
                ? STextTheme.titleCaptionBoldDark
                : STextTheme.titleCaptionBoldLight,
          ),
          const SizedBox(height: SSizes.xs),

          // Text & Icons Form Field Password
          TextFormField(
            focusNode: focusNode,
            obscureText: !isPasswordVisible, // Mengatur apakah password disembunyikan
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: SSizes.md2, vertical: SSizes.md),
              // Menambahkan Icon di dalam field
              prefixIcon: Padding(
                padding: const EdgeInsets.only(top:SSizes.md, bottom: SSizes.md, left: SSizes.md2, right: SSizes.sm2),
                child: Icon(
                  SIcons.password,
                  color: isFocused
                      ? (dark ? SColors.green500 : SColors.green500)
                      : (dark ? SColors.softBlack50 : SColors.softBlack300),
                ),
              ),
              // Menambahkan Icon untuk toggle password visibility
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    isPasswordVisible = !isPasswordVisible;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: SSizes.md, bottom: SSizes.md, left: SSizes.sm2, right: SSizes.md2),
                  child: Icon(
                    isPasswordVisible ? SIcons.eye : SIcons.eyeSlash,
                    color: isFocused
                        ? (dark ? SColors.green500 : SColors.green500)
                        : (dark ? SColors.softBlack50 : SColors.softBlack300),
                  ),
                ),
              ),
              // Text Password field
              labelText: STexts.passwordField,
              labelStyle: dark
                  ? STextTheme.bodyBaseRegularLight
                  : STextTheme.bodyBaseRegularDark,
              floatingLabelBehavior: FloatingLabelBehavior.never,
              hintText: STexts.passwordField,
              hintStyle: dark
                  ? STextTheme.bodyBaseRegularLight
                  : STextTheme.bodyBaseRegularDark,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(SSizes.borderRadiussm),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(SSizes.borderRadiussm),
                borderSide: const BorderSide(color: SColors.softBlack50),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(SSizes.borderRadiussm),
                borderSide: const BorderSide(color: SColors.green500),
              ),
            ),
          ),
        ],
      );
    },
  );
}


  //-------------------- Confirm Password Field --------------------//
  static Widget confirmPasswordField(BuildContext context, bool dark) {
    // FocusNode untuk mendeteksi fokus
    final FocusNode focusNode = FocusNode();
    bool isFocused = false;
    bool isPasswordVisible = false;

    return StatefulBuilder(
      builder: (context, setState) {
        // Listener untuk fokus
        focusNode.addListener(() {
          setState(() {
            isFocused = focusNode.hasFocus;
          });
        });

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text Confirm Password
            Text(
              STexts.confirmPassword,
              style: dark
                  ? STextTheme.titleCaptionBoldDark
                  : STextTheme.titleCaptionBoldLight,
            ),
            const SizedBox(height: SSizes.xs),

            // Text & Icons Form Field Confirm Password
            TextFormField(
              focusNode: focusNode,
              obscureText: !isPasswordVisible, // Mengatur apakah password disembunyikan
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: SSizes.md2, vertical: SSizes.md),
                // Menambahkan Icon di dalam field
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(top:SSizes.md, bottom: SSizes.md, left: SSizes.md2, right: SSizes.sm2),
                  child: Icon(
                    SIcons.password,
                    color: isFocused
                        ? (dark ? SColors.green500 : SColors.green500)
                        : (dark ? SColors.softBlack50 : SColors.softBlack300),
                  ),
                ),
                // Menambahkan Icon untuk toggle password visibility
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      isPasswordVisible = !isPasswordVisible;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: SSizes.md, bottom: SSizes.md, left: SSizes.sm2, right: SSizes.md2),
                    child: Icon(
                      isPasswordVisible ? SIcons.eye : SIcons.eyeSlash,
                      color: isFocused
                          ? (dark ? SColors.green500 : SColors.green500)
                          : (dark ? SColors.softBlack50 : SColors.softBlack300),
                    ),
                  ),
                ),
                // Text Password field
                labelText: STexts.confirmPasswordField,
                labelStyle: dark
                    ? STextTheme.bodyBaseRegularLight
                    : STextTheme.bodyBaseRegularDark,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                hintText: STexts.confirmPasswordField,
                hintStyle: dark
                    ? STextTheme.bodyBaseRegularLight
                    : STextTheme.bodyBaseRegularDark,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(SSizes.borderRadiussm),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(SSizes.borderRadiussm),
                  borderSide: const BorderSide(color: SColors.softBlack50),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(SSizes.borderRadiussm),
                  borderSide: const BorderSide(color: SColors.green500),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  //-------------------- Username Field --------------------//
  static Widget usernameField(BuildContext context, bool dark) {
    // FocusNode untuk mendeteksi fokus
    final FocusNode focusNode = FocusNode();
    bool isFocused = false;

    return StatefulBuilder(
      builder: (context, setState) {
        // Listener untuk fokus
        focusNode.addListener(() {
          setState(() {
            isFocused = focusNode.hasFocus;
          });
        });

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text username
            Text(
              STexts.username,
              style: dark
                  ? STextTheme.titleCaptionBoldDark
                  : STextTheme.titleCaptionBoldLight,
            ),
            const SizedBox(height: SSizes.xs),

            // Text & Icons Form Field Username
            TextFormField(
              focusNode: focusNode,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: SSizes.md2, vertical: SSizes.md),
                // Menambahkan Icon di dalam field
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(top:SSizes.md, bottom: SSizes.md, left: SSizes.md2, right: SSizes.sm2),
                  child: Icon(
                    SIcons.username,
                    color: isFocused
                        ? (dark ? SColors.green500 : SColors.green500)
                        : (dark ? SColors.softBlack50 : SColors.softBlack300),
                  ),
                ),
                // Text Username field
                labelText: STexts.usernameField,
                labelStyle: dark
                    ? STextTheme.bodyBaseRegularLight
                    : STextTheme.bodyBaseRegularDark,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                hintText: STexts.usernameField,
                hintStyle: dark
                    ? STextTheme.bodyBaseRegularLight
                    : STextTheme.bodyBaseRegularDark,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(SSizes.borderRadiussm),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(SSizes.borderRadiussm),
                  borderSide: const BorderSide(color: SColors.softBlack50),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(SSizes.borderRadiussm),
                  borderSide: const BorderSide(color: SColors.green500),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  //-------------------- No Phone Field --------------------//
  static Widget noHandphoneField(BuildContext context, bool dark) {
    // FocusNode untuk mendeteksi fokus
    final FocusNode focusNode = FocusNode();
    bool isFocused = false;

    return StatefulBuilder(
      builder: (context, setState) {
        // Listener untuk fokus
        focusNode.addListener(() {
          setState(() {
            isFocused = focusNode.hasFocus;
          });
        });

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text No Phone
            Text(
              STexts.noPhone,
              style: dark
                  ? STextTheme.titleCaptionBoldDark
                  : STextTheme.titleCaptionBoldLight,
            ),
            const SizedBox(height: SSizes.xs),

            // Text & Icons Form Field no Phone
            TextFormField(
              focusNode: focusNode,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: SSizes.md2, vertical: SSizes.md),
                // Menambahkan Icon di dalam field
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(top:SSizes.md, bottom: SSizes.md, left: SSizes.md2, right: SSizes.sm2),
                  child: Icon(
                    SIcons.phone,
                    color: isFocused
                        ? (dark ? SColors.green500 : SColors.green500)
                        : (dark ? SColors.softBlack50 : SColors.softBlack300),
                  ),
                ),
                // Text No Phone field
                labelText: STexts.noPhoneField,
                labelStyle: dark
                    ? STextTheme.bodyBaseRegularLight
                    : STextTheme.bodyBaseRegularDark,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                hintText: STexts.noPhoneField,
                hintStyle: dark
                    ? STextTheme.bodyBaseRegularLight
                    : STextTheme.bodyBaseRegularDark,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(SSizes.borderRadiussm),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(SSizes.borderRadiussm),
                  borderSide: const BorderSide(color: SColors.softBlack50),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(SSizes.borderRadiussm),
                  borderSide: const BorderSide(color: SColors.green500),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
