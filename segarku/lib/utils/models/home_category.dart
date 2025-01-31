import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';
import 'package:segarku/features/shop/products/list_product.dart';
import 'package:segarku/utils/constants/image_strings.dart';
import 'package:segarku/utils/constants/sizes.dart';
import 'package:segarku/utils/theme/custom_themes/text_theme.dart';
import 'package:segarku/utils/helpers/helper_functions.dart';

class SHomeCategories extends StatefulWidget {
  const SHomeCategories({super.key});

  @override
  _SHomeCategoriesState createState() => _SHomeCategoriesState();
}

class _SHomeCategoriesState extends State<SHomeCategories> {
  List<Map<String, String>> categories = [];
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

          setState(() {
            categories = data.map<Map<String, String>>((item) {
              return {
                'name': item['name'] as String,
                'image': _getCategoryImage(item['name'] as String),
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

  @override
  Widget build(BuildContext context) {
    final darkMode = SHelperFunctions.isDarkMode(context);

    if (isLoading) {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(5, (index) => _buildShimmerCategory()),
        ),
      );
    }

    if (categories.isEmpty) {
      return const Center(child: Text("Tidak ada kategori yang tersedia"));
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          categories.length,
          (index) => Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ListCategoryProductScreen(
                      categoryName: categories[index]["name"]!.replaceAll('&amp;', '&').trim(),
                    ),
                  ),
                );
              },
              child: Container(
                width: 67,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(SSizes.borderRadiusmd2),
                  color: Colors.transparent,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: SSizes.sm),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(SSizes.borderRadiusmd),
                        child: Image.asset(
                          categories[index]["image"]!,
                          fit: BoxFit.cover,
                          height: 55,
                          width: double.infinity,
                        ),
                      ),
                      const SizedBox(height: SSizes.sm2),
                      Text(
                        categories[index]["name"]!,
                        textAlign: TextAlign.center,
                        style: darkMode
                            ? STextTheme.titleSmBoldDark
                            : STextTheme.titleSmBoldLight,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Widget untuk efek shimmer loading kategori
  Widget _buildShimmerCategory() {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          width: 67,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(SSizes.borderRadiusmd2),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: SSizes.sm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(SSizes.borderRadiusmd),
                  child: Container(
                    height: 55,
                    width: double.infinity,
                    color: Colors.grey[300],
                  ),
                ),
                const SizedBox(height: SSizes.sm2),
                Container(
                  height: 12,
                  width: 50,
                  color: Colors.grey[300],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
