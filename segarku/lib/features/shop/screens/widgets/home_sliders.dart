import 'package:flutter/material.dart';
import 'package:segarku/utils/constants/image_strings.dart';
import 'package:segarku/utils/constants/sizes.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class sliderWidget extends StatefulWidget {
  const sliderWidget({Key? key}) : super(key: key);

  @override
  _sliderWidgetState createState() => _sliderWidgetState();
}

class _sliderWidgetState extends State<sliderWidget> {
  final PageController controller = PageController();
  final List<String> sliders = [
    SImages.slider1,
    SImages.slider2,
    SImages.slider3,
  ];

  final bool darkMode = false; // Change this based on your app's theme.

  @override
  Widget build(BuildContext context) {
    return  Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.33, // Responsive height
            child: PageView.builder(
              controller: controller,
              itemCount: sliders.length,
              itemBuilder: (context, index) {
                final slider = sliders[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: SSizes.sm2), // Spacing between banners
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(SSizes.borderRadiusmd)),
                    child: Image.asset(
                      slider,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: SSizes.sm2),
          SmoothPageIndicator(
            controller: controller,
            count: sliders.length,
            effect: CustomizableEffect(
              spacing: 5.0,
              activeDotDecoration: DotDecoration(
                width: 31,
                height: 6,
                color: darkMode ? Colors.white : Colors.green.shade800,
                borderRadius: BorderRadius.circular(3),
              ),
              dotDecoration: DotDecoration(
                width: 6,
                height: 6,
                color: darkMode ? Colors.grey.shade300 : Colors.green.shade300,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
        ],
      
    );
  }
}

