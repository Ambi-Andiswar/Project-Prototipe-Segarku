import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../theme/custom_themes/appbar_theme.dart';
import '../theme/custom_themes/bottom_sheet_theme.dart';
import '../theme/custom_themes/checkbox_theme.dart';
import '../theme/custom_themes/chip_theme.dart';
import '../theme/custom_themes/elevated_button_theme.dart';
import '../theme/custom_themes/outlined_button_theme.dart';
import 'package:segarku/utils/theme/custom_themes/text_field_theme.dart';
import 'package:segarku/utils/theme/custom_themes/text_theme.dart';

class SAppTheme {
  SAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Satoshi',
    brightness: Brightness.light,
    primaryColor: Colors.green,
    textTheme: STextTheme.lightTextTheme,
    chipTheme: SChipTheme.lightchipTheme,
    scaffoldBackgroundColor: SColors.softWhite,
    appBarTheme: SAppBarTheme.lightAppBarTheme,
    checkboxTheme: SCheckboxTheme.lightCheckboxTheme,
    bottomSheetTheme: SBottomSheetTheme.lightBottomSheetTheme,
    elevatedButtonTheme: SElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: SOutlinedButtonTheme.lightOutlineButtonTheme,
    inputDecorationTheme: STextFormFieldTheme.lightInputDecorationTheme,    
  );
  

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Satoshi',
    brightness: Brightness.dark,
    primaryColor: Colors.green,
    textTheme: STextTheme.darkTextTheme,
    chipTheme: SChipTheme.darkchipTheme,
    scaffoldBackgroundColor: SColors.pureBlack,
    appBarTheme: SAppBarTheme.darkAppBarTheme,
    checkboxTheme: SCheckboxTheme.darkCheckboxTheme,
    bottomSheetTheme: SBottomSheetTheme.darkBottomSheetTheme,
    elevatedButtonTheme: SElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: SOutlinedButtonTheme.darkOutlineButtonTheme,
    inputDecorationTheme: STextFormFieldTheme.darkInputDecorationTheme,  
  );


}