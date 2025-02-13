import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';
import 'package:segarku/features/shop/products/list_product.dart';
import 'package:segarku/utils/constants/image_strings.dart';
import 'package:segarku/utils/constants/sizes.dart';
import 'package:segarku/utils/theme/custom_themes/text_theme.dart';
import '../../../../utils/constants/colors.dart';
import 'package:segarku/utils/helpers/helper_functions.dart';

class SCategory extends StatefulWidget {
  const SCategory({super.key});

  @override
  _SCategoryState createState() => _SCategoryState();
}

class _SCategoryState extends State<SCategory> {
  List<Map<String, dynamic>> categories = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    final url = Uri.parse("https://www.admin-segarku.online/api/categories");
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);

        if (json['success'] == true && json['data'] is List) {
          final List<dynamic> data = json['data'];
          final filteredData = data.where((item) => item['name'] != "Spesial Hari Ini").toList();

          setState(() {
            categories = filteredData.map((item) {
              return {
                'name': item['name'],
                'products': item['Jumlah'] ?? 0,
                'image': _getCategoryImage(item['name']),
              };
            }).toList();
            isLoading = false;
          });
        } else {
          throw Exception("Unexpected response format");
        }
      } else {
        throw Exception("Failed to fetch categories. Status code: ${response.statusCode}");
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("Error: $e");
    }
  }

  String _getCategoryImage(String categoryName) {
    switch (categoryName) {
      case "Sayur & Buah":
        return SImages.categoryBuahSayur;
      case "Daging & Protein":
        return SImages.categoryDagingProtein;
      case "Bumbu & Rempah":
        return SImages.categoryBumbuRempah;
      case "Sembako":
        return SImages.categorySembako;
      case "Paket Masak":
        return SImages.categoryPaketMasak;
      default:
        return SImages.appLogo;
    }
  }

  Widget _buildShimmerLoading(bool darkMode, int crossAxisCount) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 6,
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
                        Container(
                          width: 100,
                          height: 14,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        const SizedBox(height: 8),
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

  Widget _buildCategoryGrid(bool darkMode, int crossAxisCount) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: categories.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        childAspectRatio: 2.5,
      ),
      itemBuilder: (context, index) {
        final category = categories[index];

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ListCategoryProductScreen(
                  categoryName: categories[index]["name"]!,
                ),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(SSizes.borderRadiusmd2),
              color: darkMode ? SColors.slateBlack : SColors.pureWhite,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
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
                        Text(
                          category['name'],
                          style: darkMode
                              ? STextTheme.titleCaptionBoldDark
                              : STextTheme.titleCaptionBoldLight,
                        ),
                        Text(
                          '${category['products']} produk',
                          style: darkMode
                              ? STextTheme.bodyCaptionRegularDark
                              : STextTheme.bodyCaptionRegularLight,
                        ),
                      ],
                    ),
                  ),
                ),
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(100),
                    bottomLeft: Radius.circular(100),
                    topRight: Radius.circular(SSizes.borderRadiusmd2),
                    bottomRight: Radius.circular(SSizes.borderRadiusmd2),
                  ),
                  child: Image.asset(
                    category['image'],
                    fit: BoxFit.cover,
                    width: 72,
                    height: double.infinity,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final darkMode = SHelperFunctions.isDarkMode(context);
    final screenWidth = MediaQuery.of(context).size.width;

    int crossAxisCount = 2;
    if (screenWidth >= 600) crossAxisCount = 3;
    if (screenWidth >= 900) crossAxisCount = 4;

    if (isLoading) {
      return _buildShimmerLoading(darkMode, crossAxisCount);
    }

    if (categories.isEmpty) {
      return const Center(child: Text("Tidak ada kategori yang tersedia"));
    }

    return _buildCategoryGrid(darkMode, crossAxisCount);
  }
}