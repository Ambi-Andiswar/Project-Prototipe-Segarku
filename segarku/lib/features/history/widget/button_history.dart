import 'package:flutter/material.dart';
import 'package:segarku/utils/constants/colors.dart';
import 'package:segarku/utils/theme/custom_themes/text_theme.dart';

class ToggleButtonHistory extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onPressed;

  const ToggleButtonHistory({
    Key? key,
    required this.label,
    required this.isActive,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        backgroundColor: Colors.transparent,
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
  @override
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

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: Center(
        child: ToggleButtonExample(),
      ),
    ),
  ));
}
