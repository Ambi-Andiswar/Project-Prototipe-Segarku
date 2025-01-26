import 'package:flutter/material.dart';
import 'package:segarku/utils/constants/colors.dart';
import 'package:segarku/utils/theme/custom_themes/text_theme.dart';

class ToggleButtonHistory extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onPressed;

  const ToggleButtonHistory({
    super.key,
    required this.label,
    required this.isActive,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        backgroundColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory,
        side: BorderSide(
          color: isActive ? SColors.green500 : SColors.softBlack100,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Text(
        label,
        style: isActive
            ? STextTheme.titleCaptionBoldLight.copyWith(color: SColors.green500) 
            : STextTheme.bodyCaptionRegularLight.copyWith(color: SColors.softBlack100),
      ),
    );
  }
}

class ToggleButtonExample extends StatefulWidget {
  const ToggleButtonExample({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ToggleButtonExampleState createState() => _ToggleButtonExampleState();
}

class _ToggleButtonExampleState extends State<ToggleButtonExample> {
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ToggleButtonHistory(
          label: 'Semua',
          isActive: activeIndex == 0,
          onPressed: () {
            setState(() {
              activeIndex = 0;
            });
          },
        ),
        ToggleButtonHistory(
          label: 'Dalam proses',
          isActive: activeIndex == 1,
          onPressed: () {
            setState(() {
              activeIndex = 1;
            });
          },
        ),
        ToggleButtonHistory(
          label: 'Selesai',
          isActive: activeIndex == 2,
          onPressed: () {
            setState(() {
              activeIndex = 2;
            });
          },
        ),
      ],
    );
  }
}
