import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:segarku/features/authentication/screens/welcome.dart';
import 'package:segarku/utils/theme/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: ThemeMode.system,
      theme: SAppTheme.lightTheme,
      darkTheme: SAppTheme.darkTheme,
      home: const WelcomeScreen(),
    );
  }
}