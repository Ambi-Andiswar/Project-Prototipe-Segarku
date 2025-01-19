import 'package:flutter/material.dart';
import 'package:segarku/utils/constants/colors.dart';

class SShadows {
  static BoxShadow fieldShadow = BoxShadow(
    // ignore: deprecated_member_use
    color: SColors.shadow.withOpacity(0.15),
    spreadRadius: -10,
    blurRadius: 40,
    offset: const Offset(0, 12),
  );

  static BoxShadow contentShadow = BoxShadow(
    // ignore: deprecated_member_use
    color: SColors.shadow.withOpacity(0.10),
    spreadRadius: -6,
    blurRadius: 24,
    offset: const Offset(0, 4),
  );

  static BoxShadow buttonShadow = BoxShadow(
    // ignore: deprecated_member_use
    color: SColors.shadow.withOpacity(0.10),
    spreadRadius: -6,
    blurRadius: 24,
    offset: const Offset(0, 0),
  );
}
