import 'package:flutter/material.dart';
import 'package:segarku/utils/constants/fields.dart';
import 'package:segarku/utils/constants/sizes.dart';
import 'package:segarku/utils/helpers/helper_functions.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = SHelperFunctions.isDarkMode(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height, // Batasi tinggi minimal
            ),
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  InputFields.emailField(context, dark),
                  const SizedBox(height: SSizes.lg), // Jarak antar field
                  InputFields.passswordField(context, dark),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
