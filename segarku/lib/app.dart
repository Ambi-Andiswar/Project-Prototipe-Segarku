import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:segarku/commons/controller/no_connection/connectivity_controller.dart';
import 'package:segarku/commons/widget/no_connection/no_connection.dart';
import 'package:segarku/features/authentification/controller/login_google/login_google_auth_contrller.dart';
import 'package:segarku/features/authentification/screens/onboarding/onboarding.dart';
import 'package:segarku/navigation_menu.dart';
import 'package:segarku/utils/helpers/helper_functions.dart';
import 'package:segarku/utils/theme/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = SHelperFunctions.isDarkMode(context);

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness:
          darkMode ? Brightness.light : Brightness.dark,
      statusBarBrightness:
          darkMode ? Brightness.dark : Brightness.light,
    ));

    final AuthControllerGoogle authController = Get.put(AuthControllerGoogle());
    final ConnectivityController connectivityController = Get.put(ConnectivityController());

    return GetMaterialApp(
      themeMode: ThemeMode.system,
      theme: SAppTheme.lightTheme,
      darkTheme: SAppTheme.darkTheme,
      home: Obx(() {
        if (!connectivityController.isConnected.value) {
          return const NoConnectionScreen();
        } else if (authController.user != null) {
          return const NavigationMenu(initialIndex: 0);
        } else {
          return const OnBoardingScreen();
        }
      }),
    );
  }
}