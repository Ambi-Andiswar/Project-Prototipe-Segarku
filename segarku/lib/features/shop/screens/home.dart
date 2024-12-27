import 'package:flutter/material.dart';
import 'package:segarku/utils/constants/fields.dart';
import 'package:segarku/utils/constants/sizes.dart';
import 'package:segarku/utils/helpers/helper_functions.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = SHelperFunctions.isDarkMode(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: SSizes.lg,
            horizontal: SSizes.lg,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InputFields.emailField(context, dark),
              const SizedBox(height: SSizes.lg), // Jarak antar field
              InputFields.passwordField(context, dark),
              const SizedBox(height: SSizes.lg), // Jarak antar field
              InputFields.confirmPasswordField(context, dark),
              const SizedBox(height: SSizes.lg), // Jarak antar field
              InputFields.usernameField(context, dark),
              const SizedBox(height: SSizes.lg), // Jarak antar field
              InputFields.noHandphoneField(context, dark),
            ],
          ),
        ),
      ),
    );
  }
}
