import 'package:flutter/material.dart';
import 'package:segarku/utils/constants/colors.dart';

// note : kalo ada yang mau diubah harus di hard restart
class STextTheme {
  STextTheme._();
  
  // Title Style Black
  static const TextStyle title2XlBlackLight = TextStyle(
    fontFamily: 'Satoshi', 
    fontWeight: FontWeight.w900, 
    fontSize: 40.0, 
    height: 56.0 / 40.0, 
    letterSpacing: -0.35,
    color: SColors.textPrimaryLight 
  );

  static const TextStyle titleXlBlackLight = TextStyle(
    fontFamily: 'Satoshi', 
    fontWeight: FontWeight.w900, 
    fontSize: 32.0, 
    height: 42.0 / 32.0, 
    letterSpacing: -0.34,
    color: SColors.textPrimaryLight 
  );

  static const TextStyle titleLgBlackLight = TextStyle(
    fontFamily: 'Satoshi', 
    fontWeight: FontWeight.w900, 
    fontSize: 24.0, 
    height: 34.0 / 24.0, 
    letterSpacing: -0.3,
    color: SColors.textPrimaryLight 
  );

  static const TextStyle titleMdBlackLight = TextStyle(
    fontFamily: 'Satoshi', 
    fontWeight: FontWeight.w900, 
    fontSize: 18.0, 
    height: 25.0 / 18.0, 
    letterSpacing: -0.22,
    color: SColors.textPrimaryLight 
  );

  static const TextStyle titleBaseBlackLight = TextStyle(
    fontFamily: 'Satoshi', 
    fontWeight: FontWeight.w900, 
    fontSize: 16.0, 
    height: 22.0 / 16.0, 
    letterSpacing: -0.18,
    color: SColors.textPrimaryLight  
  );

  static const TextStyle titleCaptionBlackLight = TextStyle(
    fontFamily: 'Satoshi', 
    fontWeight: FontWeight.w900, 
    fontSize: 12.0, 
    height: 17.0 / 12.0, 
    letterSpacing: 0,
    color: SColors.textPrimaryLight 
  );

  static const TextStyle titleSmBlackLight = TextStyle(
    fontFamily: 'Satoshi', 
    fontWeight: FontWeight.w900, 
    fontSize: 10.0, 
    height: 14.0 / 10.0, 
    letterSpacing: 0,
    color: SColors.textPrimaryLight 
  );


  // Title Style Bold
  static const TextStyle title2XlBoldLight = TextStyle(
    fontFamily: 'Satoshi', 
    fontWeight: FontWeight.w600, 
    fontSize: 40.0, 
    height: 56.0 / 40.0, 
    letterSpacing: -0.35,
    color: SColors.textPrimaryLight 
  );

  static const TextStyle titleXlBoldLight = TextStyle(
    fontFamily: 'Satoshi', 
    fontWeight: FontWeight.w600, 
    fontSize: 32.0, 
    height: 42.0 / 32.0, 
    letterSpacing: -0.34,
    color: SColors.textPrimaryLight 
  );

  static const TextStyle titleLgBoldLight = TextStyle(
    fontFamily: 'Satoshi', 
    fontWeight: FontWeight.w600, 
    fontSize: 24.0, 
    height: 34.0 / 24.0, 
    letterSpacing: -0.3,
    color: SColors.textPrimaryLight 
  );

  static const TextStyle titleMdBoldLight = TextStyle(
    fontFamily: 'Satoshi', 
    fontWeight: FontWeight.w600, 
    fontSize: 18.0, 
    height: 25.0 / 18.0, 
    letterSpacing: -0.22,
    color: SColors.textPrimaryLight  
  );

  static const TextStyle titleBaseBoldLight = TextStyle(
    fontFamily: 'Satoshi', 
    fontWeight: FontWeight.w600, 
    fontSize: 16.0, 
    height: 22.0 / 16.0, 
    letterSpacing: -0.18,
    color: SColors.textPrimaryLight 
  );

  static const TextStyle titleCaptionBoldLight = TextStyle(
    fontFamily: 'Satoshi', 
    fontWeight: FontWeight.w600, 
    fontSize: 12.0, 
    height: 17.0 / 12.0, 
    letterSpacing: 0,
    color: SColors.textPrimaryLight 
  );

  static const TextStyle titleSmBoldLight = TextStyle(
    fontFamily: 'Satoshi', 
    fontWeight: FontWeight.w600, 
    fontSize: 10.0, 
    height: 14.0 / 10.0, 
    letterSpacing: 0,
    color: SColors.textPrimaryLight 
  );


  // Body Style Regular
  static const TextStyle bodyLgRegularLight = TextStyle(
    fontFamily: 'Satoshi', 
    fontWeight: FontWeight.w400, 
    fontSize: 20.0, 
    height: 28.0 / 20.0, 
    letterSpacing: -0.27,
    color: SColors.textSecondaryLight
  );

  static const TextStyle bodyMdRegularLight = TextStyle(
    fontFamily: 'Satoshi', 
    fontWeight: FontWeight.w400, 
    fontSize: 18.0, 
    height: 25.0 / 18.0, 
    letterSpacing: -0.22,
    color: SColors.textSecondaryLight 
  );

  static const TextStyle bodyBaseRegularLight = TextStyle(
    fontFamily: 'Satoshi', 
    fontWeight: FontWeight.w400, 
    fontSize: 16.0, 
    height: 22.0 / 16.0, 
    letterSpacing: -0.18,
    color: SColors.textSecondaryLight
  );

  static const TextStyle bodyCaptionRegularLight = TextStyle(
    fontFamily: 'Satoshi', 
    fontWeight: FontWeight.w400, 
    fontSize: 12.0, 
    height: 17.0 / 12.0, 
    letterSpacing: 0,
    color: SColors.textSecondaryLight
  );

  static const TextStyle bodySmRegularLight = TextStyle(
    fontFamily: 'Satoshi', 
    fontWeight: FontWeight.w300, 
    fontSize: 10.0, 
    height: 14.0 / 10.0, 
    letterSpacing: 0,
    color: SColors.textSecondaryLight
  );

  // Body Style Light
  static const TextStyle bodyLgLight = TextStyle(
    fontFamily: 'Satoshi', 
    fontWeight: FontWeight.w300, 
    fontSize: 20.0, 
    height: 28.0 / 20.0, 
    letterSpacing: -0.27,
    color: SColors.textSecondaryLight 
  );

  static const TextStyle bodyMdLight = TextStyle(
    fontFamily: 'Satoshi', 
    fontWeight: FontWeight.w300, 
    fontSize: 18.0, 
    height: 25.0 / 18.0, 
    letterSpacing: -0.22,
    color: SColors.textSecondaryLight
  );

  static const TextStyle bodyBaseLight = TextStyle(
    fontFamily: 'Satoshi', 
    fontWeight: FontWeight.w300, 
    fontSize: 16.0, 
    height: 22.0 / 16.0, 
    letterSpacing: -0.18,
    color: SColors.textSecondaryLight
  );

  static const TextStyle bodyCaptionLight = TextStyle(
    fontFamily: 'Satoshi', 
    fontWeight: FontWeight.w300, 
    fontSize: 12.0, 
    height: 17.0 / 12.0, 
    letterSpacing: 0,
    color: SColors.textSecondaryLight
  );

  static const TextStyle bodySmLight = TextStyle(
    fontFamily: 'Satoshi', 
    fontWeight: FontWeight.w300, 
    fontSize: 10.0, 
    height: 14.0 / 10.0, 
    letterSpacing: 0,
    color: SColors.textSecondaryLight
  );


  // CTA Style 
  static const TextStyle ctaBase = TextStyle(
    fontFamily: 'Satoshi', 
    fontWeight: FontWeight.w600, 
    fontSize: 16.0, 
    height: 22.0 / 16.0, 
    letterSpacing: -0.18,
    color: SColors.textCTALight
  );

  static const TextStyle ctaSm = TextStyle(
    fontFamily: 'Satoshi', 
    fontWeight: FontWeight.w600, 
    fontSize: 12.0, 
    height: 17.0 / 12.0, 
    letterSpacing: 0,
    color: SColors.textCTALight
  );




  // Title Style Black Dark Mode
  static const TextStyle title2XlBlackDark = TextStyle(
    fontFamily: 'Satoshi', 
    fontWeight: FontWeight.w900, 
    fontSize: 40.0, 
    height: 56.0 / 40.0, 
    letterSpacing: -0.35,
    color: SColors.textPrimaryDark
  );

  static const TextStyle titleXlBlackDark = TextStyle(
    fontFamily: 'Satoshi', 
    fontWeight: FontWeight.w900, 
    fontSize: 32.0, 
    height: 42.0 / 32.0, 
    letterSpacing: -0.34,
    color: SColors.textPrimaryDark
  );

  static const TextStyle titleLgBlackDark = TextStyle(
    fontFamily: 'Satoshi', 
    fontWeight: FontWeight.w900, 
    fontSize: 24.0, 
    height: 34.0 / 24.0, 
    letterSpacing: -0.3,
    color: SColors.textPrimaryDark
  );

  static const TextStyle titleMdBlackDark = TextStyle(
    fontFamily: 'Satoshi', 
    fontWeight: FontWeight.w900, 
    fontSize: 18.0, 
    height: 25.0 / 18.0, 
    letterSpacing: -0.22,
    color: SColors.textPrimaryDark 
  );

  static const TextStyle titleBaseBlackDark = TextStyle(
    fontFamily: 'Satoshi', 
    fontWeight: FontWeight.w900, 
    fontSize: 16.0, 
    height: 22.0 / 16.0, 
    letterSpacing: -0.18,
    color: SColors.textPrimaryDark
  );

  static const TextStyle titleCaptionBlackDark = TextStyle(
    fontFamily: 'Satoshi', 
    fontWeight: FontWeight.w900, 
    fontSize: 12.0, 
    height: 17.0 / 12.0, 
    letterSpacing: 0,
    color: SColors.textPrimaryDark 
  );

  static const TextStyle titleSmBlackDark = TextStyle(
    fontFamily: 'Satoshi', 
    fontWeight: FontWeight.w900, 
    fontSize: 10.0, 
    height: 14.0 / 10.0, 
    letterSpacing: 0,
    color: SColors.textPrimaryDark
  );


  // Title Style Bold
  static const TextStyle title2XlBoldDark = TextStyle(
    fontFamily: 'Satoshi', 
    fontWeight: FontWeight.w600, 
    fontSize: 40.0, 
    height: 56.0 / 40.0, 
    letterSpacing: -0.35,
    color: SColors.textPrimaryDark
  );

  static const TextStyle titleXlBoldDark = TextStyle(
    fontFamily: 'Satoshi', 
    fontWeight: FontWeight.w600, 
    fontSize: 32.0, 
    height: 42.0 / 32.0, 
    letterSpacing: -0.34,
    color: SColors.textPrimaryDark
  );

  static const TextStyle titleLgBolddark = TextStyle(
    fontFamily: 'Satoshi', 
    fontWeight: FontWeight.w600, 
    fontSize: 24.0, 
    height: 34.0 / 24.0, 
    letterSpacing: -0.3,
    color: SColors.textPrimaryDark
  );

  static const TextStyle titleMdBoldDark = TextStyle(
    fontFamily: 'Satoshi', 
    fontWeight: FontWeight.w600, 
    fontSize: 18.0, 
    height: 25.0 / 18.0, 
    letterSpacing: -0.22,
    color: SColors.textPrimaryDark
  );

  static const TextStyle titleBaseBoldDark = TextStyle(
    fontFamily: 'Satoshi', 
    fontWeight: FontWeight.w600, 
    fontSize: 16.0, 
    height: 22.0 / 16.0, 
    letterSpacing: -0.18,
    color: SColors.textPrimaryDark
  );

  static const TextStyle titleCaptionBoldDark = TextStyle(
    fontFamily: 'Satoshi', 
    fontWeight: FontWeight.w600, 
    fontSize: 12.0, 
    height: 17.0 / 12.0, 
    letterSpacing: 0,
    color: SColors.textPrimaryDark
  );

  static const TextStyle titleSmBoldDark = TextStyle(
    fontFamily: 'Satoshi', 
    fontWeight: FontWeight.w600, 
    fontSize: 10.0, 
    height: 14.0 / 10.0, 
    letterSpacing: 0,
    color: SColors.textPrimaryDark
  );


  // Body Style Regular
  static const TextStyle bodyLgRegularDark = TextStyle(
    fontFamily: 'Satoshi', 
    fontWeight: FontWeight.w400, 
    fontSize: 20.0, 
    height: 28.0 / 20.0, 
    letterSpacing: -0.27,
    color: SColors.textSecondaryDark 
  );

  static const TextStyle bodyMdRegularDark = TextStyle(
    fontFamily: 'Satoshi', 
    fontWeight: FontWeight.w400, 
    fontSize: 18.0, 
    height: 25.0 / 18.0, 
    letterSpacing: -0.22,
    color: SColors.textSecondaryDark 
  );

  static const TextStyle bodyBaseRegularDark = TextStyle(
    fontFamily: 'Satoshi', 
    fontWeight: FontWeight.w400, 
    fontSize: 16.0, 
    height: 22.0 / 16.0, 
    letterSpacing: -0.18,
    color: SColors.textSecondaryDark 
  );

  static const TextStyle bodyCaptionRegularDark = TextStyle(
    fontFamily: 'Satoshi', 
    fontWeight: FontWeight.w400, 
    fontSize: 12.0, 
    height: 17.0 / 12.0, 
    letterSpacing: 0,
    color: SColors.textSecondaryDark 
  );

  static const TextStyle bodySmRegularDark = TextStyle(
    fontFamily: 'Satoshi', 
    fontWeight: FontWeight.w300, 
    fontSize: 10.0, 
    height: 14.0 / 10.0, 
    letterSpacing: 0,
    color: SColors.textSecondaryDark 
  );

  // Body Style Light
  static const TextStyle bodyLgLightDark = TextStyle(
    fontFamily: 'Satoshi', 
    fontWeight: FontWeight.w300, 
    fontSize: 20.0, 
    height: 28.0 / 20.0, 
    letterSpacing: -0.27,
    color: SColors.textSecondaryDark 
  );

  static const TextStyle bodyMdLightDark = TextStyle(
    fontFamily: 'Satoshi', 
    fontWeight: FontWeight.w300, 
    fontSize: 18.0, 
    height: 25.0 / 18.0, 
    letterSpacing: -0.22,
    color: SColors.textSecondaryDark  
  );

  static const TextStyle bodyBaseLightDark = TextStyle(
    fontFamily: 'Satoshi', 
    fontWeight: FontWeight.w300, 
    fontSize: 16.0, 
    height: 22.0 / 16.0, 
    letterSpacing: -0.18,
    color: SColors.textSecondaryDark  
  );

  static const TextStyle bodyCaptionLightDark = TextStyle(
    fontFamily: 'Satoshi', 
    fontWeight: FontWeight.w300, 
    fontSize: 12.0, 
    height: 17.0 / 12.0, 
    letterSpacing: 0,
    color: SColors.textSecondaryDark 
  );

  static const TextStyle bodySmLightDark = TextStyle(
    fontFamily: 'Satoshi', 
    fontWeight: FontWeight.w300, 
    fontSize: 10.0, 
    height: 14.0 / 10.0, 
    letterSpacing: 0,
    color: SColors.textSecondaryDark  
  );


  // Navigation text Button
  static const TextStyle selectText = TextStyle(
    fontFamily: 'Satoshi', 
    fontWeight: FontWeight.w500, 
    fontSize: 12.0, 
    height: 17.0 / 12.0, 
    letterSpacing: 0,
    color: SColors.green500  
  );

  static const TextStyle noSelectText = TextStyle(
    fontFamily: 'Satoshi', 
    fontWeight: FontWeight.w500, 
    fontSize: 12.0, 
    height: 17.0 / 12.0, 
    letterSpacing: 0,
    color: SColors.softBlack200  
  );

  


  static TextTheme lightTextTheme = TextTheme(
    headlineLarge: const TextStyle().copyWith(
        fontSize: 32.0, fontWeight: FontWeight.bold, color: SColors.secondary),
    headlineMedium: const TextStyle().copyWith(
        fontSize: 24.0, fontWeight: FontWeight.bold, color: SColors.secondary),
    headlineSmall: const TextStyle().copyWith(
        fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.black),
    titleLarge: const TextStyle().copyWith(
        fontSize: 20.0, fontWeight: FontWeight.w600, color: Colors.black),
    titleMedium: const TextStyle().copyWith(
        fontSize: 16.0, fontWeight: FontWeight.w500, color: Colors.black),
    titleSmall: const TextStyle().copyWith(
        fontSize: 16.0, fontWeight: FontWeight.w400, color: Colors.black),
    bodyLarge: const TextStyle().copyWith(
        fontSize: 14.0, fontWeight: FontWeight.w500, color: Colors.black),
    bodyMedium: const TextStyle().copyWith(
        fontSize: 14.0,
        fontWeight: FontWeight.normal,
        color: SColors.slateBlack),
    bodySmall: const TextStyle().copyWith(
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
        color: Colors.black.withOpacity(0.5)),
    labelSmall: const TextStyle().copyWith(fontSize: 14.0),
    labelLarge: const TextStyle().copyWith(
        fontSize: 12.0, fontWeight: FontWeight.normal, color: Colors.black),
    labelMedium: const TextStyle().copyWith(
        fontSize: 12.0,
        fontWeight: FontWeight.normal,
        color: Colors.black.withOpacity(0.5)),
  );

  static TextTheme darkTextTheme = TextTheme(
    headlineLarge: const TextStyle().copyWith(
        fontSize: 32.0, fontWeight: FontWeight.bold, color: Colors.white),
    headlineMedium: const TextStyle().copyWith(
        fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.white),
    headlineSmall: const TextStyle().copyWith(
        fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.white),
    titleLarge: const TextStyle().copyWith(
        fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.white),
    titleMedium: const TextStyle().copyWith(
        fontSize: 16.0, fontWeight: FontWeight.w500, color: Colors.white),
    titleSmall: const TextStyle().copyWith(
        fontSize: 16.0, fontWeight: FontWeight.w400, color: Colors.white),
    bodyLarge: const TextStyle().copyWith(
        fontSize: 14.0, fontWeight: FontWeight.w500, color: Colors.white),
    bodyMedium: const TextStyle().copyWith(
        fontSize: 14.0, fontWeight: FontWeight.normal, color: Colors.white),
    bodySmall: const TextStyle().copyWith(
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
        color: Colors.white.withOpacity(0.5)),
    labelSmall: const TextStyle()
        .copyWith(fontSize: 14.0, fontWeight: FontWeight.normal),
    labelLarge: const TextStyle().copyWith(
        fontSize: 12.0, fontWeight: FontWeight.normal, color: Colors.white),
    labelMedium: const TextStyle().copyWith(
        fontSize: 12.0,
        fontWeight: FontWeight.normal,
        color: Colors.white.withOpacity(0.5)),
  );
}
