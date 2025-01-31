// slider_widget.dart
import 'package:flutter/material.dart';
import 'package:segarku/features/shop/controller/slider_controller.dart';
import 'package:segarku/utils/constants/sizes.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:shimmer/shimmer.dart';

class SliderWidget extends StatefulWidget {
  const SliderWidget({super.key});

  @override
  _SliderWidgetState createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  final PageController controller = PageController();
  final SliderService sliderService = SliderService(); // Instance dari SliderService
  List<String> sliders = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadSliders();
  }

  // Fungsi untuk memuat data slider
  Future<void> loadSliders() async {
    try {
      final fetchedSliders = await sliderService.fetchSliders();
      setState(() {
        sliders = fetchedSliders;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      // Handle error, misalnya tampilkan pesan error
      print('Error: $e');
    }
  }

 @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.width * 0.33, // Responsive height
          child: isLoading
              ? Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: SSizes.sm2),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(SSizes.borderRadiusmd),
                    ),
                  ),
                )
              : PageView.builder(
                  controller: controller,
                  itemCount: sliders.length,
                  itemBuilder: (context, index) {
                    final slider = sliders[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: SSizes.sm2),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(SSizes.borderRadiusmd)),
                        child: Image.network(
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
              color: Colors.green.shade800,
              borderRadius: BorderRadius.circular(3),
            ),
            dotDecoration: DotDecoration(
              width: 6,
              height: 6,
              color: Colors.green.shade300,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
        ),
      ],
    );
  }
}