import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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
        // Parsing respons JSON
        final json = jsonDecode(response.body);

        if (json['success'] == true && json['data'] is List) {
          // Ambil data dari JSON
          final List<dynamic> data = json['data'];

          setState(() {
            categories = data.map((item) {
              return {
                'name': item['name'],
                'products': item['Jumlah'] ?? 0, // Jumlah produk dari JSON
                'image': _getCategoryImage(item['name']), // Tentukan gambar kategori
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

  // Fungsi untuk menentukan gambar berdasarkan nama kategori
  String _getCategoryImage(String categoryName) {
    switch (categoryName) {
      case "sayur & buah":
        return SImages.categoryBuahSayur;
      case "Daging Dam Protein":
        return SImages.categoryDagingProtein;
      case "Bumbu dan Rempah":
        return SImages.categoryBumbuRempah;
      case "Sembako":
        return SImages.categorySembako;
      case "Paket Siap Masak":
        return SImages.categoryPaketMasak;
      default:
        return SImages.appLogo;
    }
  }

  @override
  Widget build(BuildContext context) {
    final darkMode = SHelperFunctions.isDarkMode(context);

    // Mendapatkan lebar layar
    final screenWidth = MediaQuery.of(context).size.width;

    // Menentukan jumlah kolom secara responsif
    int crossAxisCount = 2; // Default jumlah kolom
    if (screenWidth >= 600) {
      crossAxisCount = 3; // Jika lebar >= 600, gunakan 3 kolom
    }
    if (screenWidth >= 900) {
      crossAxisCount = 4; // Jika lebar >= 900, gunakan 4 kolom
    }

    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (categories.isEmpty) {
      return const Center(child: Text("Tidak ada kategori yang tersedia"));
    }

    return GridView.builder(
      shrinkWrap: true, // Agar GridView tidak scroll sendiri
      physics: const NeverScrollableScrollPhysics(),
      itemCount: categories.length, // Jumlah kategori berdasarkan data
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount, // Kategori per baris
        crossAxisSpacing: 15, // Spasi horizontal antar kategori
        mainAxisSpacing: 15, // Spasi vertikal antar kategori
        childAspectRatio: 2.5, // Perbandingan lebar dan tinggi container kategori
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
                        // Nama kategori
                        Text(
                          category['name'], // Nama kategori
                          style: darkMode
                              ? STextTheme.titleCaptionBoldDark
                              : STextTheme.titleCaptionBoldLight,
                        ),

                        // Jumlah produk dalam kategori
                        Text(
                          '${category['products']} produk', // Jumlah produk
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
                    category['image'], // Gambar kategori
                    fit: BoxFit.cover,
                    width: 72, // Ukuran gambar
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
}
