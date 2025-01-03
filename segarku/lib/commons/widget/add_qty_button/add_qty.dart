import 'package:flutter/material.dart';
import 'package:segarku/utils/constants/colors.dart';
import 'package:segarku/utils/constants/sizes.dart';
import 'package:segarku/utils/theme/custom_themes/text_theme.dart';


class QuantitySelector extends StatefulWidget {
  const QuantitySelector({super.key});
  @override
  QuantitySelectorState createState() => QuantitySelectorState();
}

class QuantitySelectorState extends State<QuantitySelector> {
  int quantity = 0;

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Button Min
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(
              color: isDarkMode 
                ? SColors.green50 : SColors.softBlack100,
            ),
            borderRadius: BorderRadius.circular(SSizes.borderRadiussm),
          ),
          child: IconButton(
            padding: EdgeInsets.zero,
            icon: Icon(
              Icons.remove,
              size: 16,
              color: isDarkMode ? SColors.green50 : SColors.softBlack100,
            ),
            onPressed: () {
              setState(() {
                if (quantity > 0) quantity--;
              });
            },
          ),
        ),

        const SizedBox(width: SSizes.md),

        // Quantity Text
        Text(
          '$quantity',
          style: isDarkMode
              ? STextTheme.titleBaseBoldDark
              : STextTheme.titleBaseBoldLight,
        ),

        const SizedBox(width: SSizes.md),

        // Button Add
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: SColors.green100,
            borderRadius: BorderRadius.circular(SSizes.borderRadiussm),
          ),
          child: IconButton(
            padding: EdgeInsets.zero,
            icon: const Icon(
              Icons.add,
              size: 16,
              color: SColors.green500,
            ),
            onPressed: () {
              setState(() {
                quantity++;
              });
            },
          ),
        ),
      ],
    );
  }
}
