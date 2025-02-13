import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:segarku/utils/constants/colors.dart';
import 'package:segarku/utils/constants/sizes.dart';

class ProductShimmer extends StatelessWidget {
  final bool darkMode;

  const ProductShimmer({Key? key, required this.darkMode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: SSizes.defaultMargin),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: darkMode ? SColors.pureBlack : Colors.white,
              borderRadius: BorderRadius.circular(SSizes.borderRadiusmd2),
              border: Border.all(
                color: darkMode ? SColors.green50 : SColors.softBlack50,
              ),
            ),
            padding: const EdgeInsets.all(SSizes.defaultMargin),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Shimmer.fromColors(
                  baseColor: darkMode ? Colors.grey[800]! : Colors.grey[300]!,
                  highlightColor: darkMode ? Colors.grey[700]! : Colors.grey[100]!,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 100,
                            height: 16,
                            color: Colors.white,
                          ),
                          Container(
                            width: 60,
                            height: 16,
                            color: Colors.white,
                          ),
                        ],
                      ),
                      const SizedBox(height: SSizes.md),
                      Column(
                        children: List.generate(3, (index) {
                          return Padding(
                            padding: EdgeInsets.only(bottom: index == 2 ? 0 : SSizes.lg),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 80.0,
                                  height: 80.0,
                                  color: Colors.white,
                                ),
                                const SizedBox(width: SSizes.sm2),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        height: 16,
                                        color: Colors.white,
                                      ),
                                      const SizedBox(height: SSizes.sm),
                                      Container(
                                        width: 100,
                                        height: 14,
                                        color: Colors.white,
                                      ),
                                      const SizedBox(height: SSizes.sm),
                                      Container(
                                        width: 80,
                                        height: 16,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 50,
                                  height: 16,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
                      const SizedBox(height: SSizes.md),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 100,
                                height: 16,
                                color: Colors.white,
                              ),
                              const SizedBox(height: SSizes.sm),
                              Container(
                                width: 120,
                                height: 16,
                                color: Colors.white,
                              ),
                              const SizedBox(height: SSizes.sm),
                              Container(
                                width: 80,
                                height: 16,
                                color: Colors.white,
                              ),
                            ],
                          ),
                          Container(
                            width: 80,
                            height: 40,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}