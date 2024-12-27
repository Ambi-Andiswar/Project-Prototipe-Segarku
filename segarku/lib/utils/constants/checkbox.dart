import 'package:flutter/material.dart';
import 'package:segarku/utils/constants/colors.dart';

class CheckboxStyles {
  static const double size = 24.0;

  static const Border uncheckedBorder = Border.fromBorderSide(
    BorderSide(color: SColors.softBlack50, width: 1),
  );

  static const BoxDecoration uncheckedDecoration = BoxDecoration(
    color: Colors.transparent,
    border: uncheckedBorder,
    borderRadius: BorderRadius.all(Radius.circular(8)),
  );

  static const BoxDecoration checkedDecoration = BoxDecoration(
    color: SColors.green500,
    borderRadius: BorderRadius.all(Radius.circular(4)),
  );

  static Widget buildCheckbox(bool isChecked) {
    return Container(
      width: size,
      height: size,
      decoration: isChecked ? checkedDecoration : uncheckedDecoration,
      child: isChecked
          ? const Icon(Icons.check, size: 16, color: SColors.pureWhite)
          : null, // Icon centering optional
    );
  }
}
