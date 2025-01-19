import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:segarku/features/authentication/controller/auth_controller.dart';
import 'package:segarku/features/authentication/screens/onboarding/onboarding.dart';
import 'package:segarku/navigation_menu.dart';
import 'package:segarku/utils/helpers/helper_functions.dart';
import 'package:segarku/utils/theme/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = SHelperFunctions.isDarkMode(context);

    // Atur status bar secara global
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Menghilangkan warna background
      statusBarIconBrightness: darkMode ? Brightness.light : Brightness.dark, // Ikon status bar
      statusBarBrightness: darkMode ? Brightness.dark : Brightness.light, // Untuk perangkat iOS
    ));

    return GetMaterialApp(
      themeMode: ThemeMode.system,
      theme: SAppTheme.lightTheme,
      darkTheme: SAppTheme.darkTheme,
      home: StreamBuilder<User?>(
        stream: AuthControllerGoogle().authState,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.connectionState == ConnectionState.done ||
              snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              return const NavigationMenu(initialIndex: 0);
            } else {
              return const OnBoardingScreen();
            }
          } else {
            return Center(
              child: Text('State: ${snapshot.connectionState}'),
            );
          }
        }
      )
    );
  }
}
