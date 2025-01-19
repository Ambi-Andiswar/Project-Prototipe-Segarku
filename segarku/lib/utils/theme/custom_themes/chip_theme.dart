//Keknya untuk ngatur active Buttom

import 'package:flutter/material.dart';

class SChipTheme {
  SChipTheme._();

  static ChipThemeData lightchipTheme = ChipThemeData(
    // ignore: deprecated_member_use
    disabledColor: Colors.grey.withOpacity(0.4),
    labelStyle: const TextStyle(color: Colors.black),
    selectedColor: Colors.green,
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
    checkmarkColor: Colors.white,
  );

    static ChipThemeData darkchipTheme = const ChipThemeData(
    disabledColor: Colors.grey,
    labelStyle: TextStyle(color: Colors.white),
    selectedColor: Colors.green,
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
    checkmarkColor: Colors.white,
  );
}