import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';

class CategoryShimmerLoading extends StatelessWidget {
  const CategoryShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = SHelperFunctions.isDarkMode(context);
    
    // Mendapatkan lebar layar untuk responsiveness
    final screenWidth = MediaQuery.of(context).size.width;
    
    // Menentukan jumlah kolom secara responsif
    int crossAxisCount = 2;
    if (screenWidth >= 600) crossAxisCount = 3;
    if (screenWidth >= 900) crossAxisCount = 4;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 6, // Jumlah shimmer placeholder
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        childAspectRatio: 2.5,
      ),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: darkMode ? Colors.grey[800]! : Colors.grey[300]!,
          highlightColor: darkMode ? Colors.grey[700]! : Colors.grey[100]!,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(SSizes.borderRadiusmd2),
              color: darkMode ? SColors.slateBlack : SColors.pureWhite,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Shimmer untuk nama kategori
                        Container(
                          width: 100,
                          height: 14,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Shimmer untuk jumlah produk
                        Container(
                          width: 60,
                          height: 12,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Shimmer untuk gambar kategori
                Container(
                  width: 72,
                  height: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(100),
                      bottomLeft: Radius.circular(100),
                      topRight: Radius.circular(SSizes.borderRadiusmd2),
                      bottomRight: Radius.circular(SSizes.borderRadiusmd2),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}