import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:segarku/commons/widget/appbar/appbar.dart';
import 'package:segarku/features/shop/products/add_to_cart_popup.dart';
import 'package:segarku/features/shop/products/data/product.dart';
import 'package:segarku/service/api_product.dart';
import 'package:segarku/utils/constants/colors.dart';
import 'package:segarku/utils/constants/drop_shadow.dart';
import 'package:segarku/utils/constants/icons.dart';
import 'package:segarku/utils/constants/sizes.dart';
import 'package:segarku/utils/models/fields_search.dart';
import 'package:segarku/utils/theme/custom_themes/text_theme.dart';

class ListCategoryProductScreen extends StatefulWidget {
  final String categoryName;

  const ListCategoryProductScreen({super.key, required this.categoryName});

  @override
  _ListCategoryProductScreenState createState() => _ListCategoryProductScreenState();
}

class _ListCategoryProductScreenState extends State<ListCategoryProductScreen> {
  List<SProduct> products = [];
  List<SProduct> filteredProducts = [];
  bool isLoading = true;
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  bool _isSearchFocused = false;

  @override
  void initState() {
    super.initState();
    fetchProducts();
    _searchFocusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _searchFocusNode.removeListener(_onFocusChange);
    _searchFocusNode.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isSearchFocused = _searchFocusNode.hasFocus;
    });
  }

  Future<void> fetchProducts() async {
    try {
      final allProducts = await ApiServiceProduct.fetchProducts();

      // Filter produk berdasarkan kategori yang dipilih
      setState(() {
        products = allProducts.where((product) {
          final productCategory = product.categoryName.trim().toLowerCase();
          final selectedCategory = widget.categoryName.trim().toLowerCase();
          return productCategory == selectedCategory;
        }).toList();
        filteredProducts = products; // Inisialisasi filteredProducts dengan produk yang sudah difilter
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("Error: $e");
    }
  }

  void _searchProducts(String query) {
    setState(() {
      filteredProducts = products
          .where((product) =>
              product.nama.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool dark = context.isDarkMode;
    return Scaffold(
      body: Column(
        children: [
          // AppBar dan SearchField di luar SingleChildScrollView
          Container(
            color: dark ? SColors.pureBlack : SColors.pureWhite,
            child: Column(
              children: [
                const SizedBox(height: 20),
                SCustomAppBar(
                  title: widget.categoryName,
                  darkMode: dark,
                ),
                const SizedBox(height: SSizes.md),
                Divider(
                  color: dark ? SColors.green50 : SColors.softBlack50,
                  thickness: 1,
                  height: 1,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: SSizes.lg,
                    right: SSizes.defaultMargin,
                    left: SSizes.defaultMargin,
                  ),
                  child: InputFieldSearch.fieldSearchAll(
                    context,
                    dark,
                    focusNode: _searchFocusNode,
                    isFocused: _isSearchFocused,
                    onChanged: _searchProducts,
                    controller: _searchController,
                  ),
                ),
              ],
            ),
          ),
          // Produk di dalam SingleChildScrollView
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: SSizes.defaultMargin,
                ),
                child: Column(
                  children: [
                    if (isLoading)
                      const Center(child: CircularProgressIndicator())
                    else if (filteredProducts.isEmpty)
                      const Center(child: Text("Tidak ada produk yang tersedia"))
                    else
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: SSizes.md,
                          mainAxisSpacing: SSizes.md,
                          childAspectRatio: 0.75,
                        ),
                        itemCount: filteredProducts.length,
                        itemBuilder: (context, index) {
                          final product = filteredProducts[index];
                          final isOutOfStock = (product.qty) <= 0;
                          return Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: dark ? SColors.green50 : SColors.softBlack50,
                              ),
                              borderRadius: BorderRadius.circular(SSizes.borderRadiusmd2),
                              color: dark ? SColors.pureBlack : SColors.pureWhite,
                              boxShadow: [SShadows.contentShadow],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(SSizes.md),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(SSizes.borderRadiusmd),
                                          child: Image.network(
                                            product.image,
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                          ),
                                        ),
                                        if (isOutOfStock)
                                          Container(
                                            width: double.infinity,
                                            height: double.infinity,
                                            decoration: BoxDecoration(
                                              color: Colors.black.withOpacity(0.5),
                                              borderRadius: BorderRadius.circular(SSizes.borderRadiusmd),
                                            ),
                                            child: const Center(
                                              child: Text(
                                                'Stok Habis!',
                                                style: STextTheme.titleCaptionBoldDark,
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: SSizes.sm2),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          product.nama,
                                          style: dark
                                              ? STextTheme.titleBaseBoldDark
                                              : STextTheme.titleBaseBoldLight,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              product.berat,
                                              style: dark
                                                  ? STextTheme.bodyCaptionRegularDark
                                                  : STextTheme.bodyCaptionRegularLight,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: SSizes.xs),
                                        Row(
                                          children: [
                                            Text(
                                              NumberFormat.currency(
                                                locale: 'id',
                                                symbol: 'Rp. ',
                                                decimalDigits: 0,
                                              ).format(product.harga),
                                              style: dark
                                                  ? STextTheme.titleBaseBlackDark
                                                  : STextTheme.titleBaseBlackLight,
                                            ),
                                            const Spacer(),
                                            if (!isOutOfStock)
                                              Container(
                                                width: 24,
                                                height: 24,
                                                decoration: BoxDecoration(
                                                  color: dark ? SColors.pureBlack : SColors.green50,
                                                  borderRadius: BorderRadius.circular(SSizes.borderRadiussm),
                                                ),
                                                child: IconButton(
                                                  onPressed: () {
                                                    showModalBottomSheet(
                                                      context: context,
                                                      shape: const RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.vertical(
                                                            top: Radius.circular(16)),
                                                      ),
                                                      builder: (context) {
                                                        return SAddToCartPopup(
                                                          price: (product.harga),
                                                          name: product.nama,
                                                          id: product.id,
                                                          maxQuantity: (product.qty),
                                                          image: product.image,
                                                          size: product.berat,
                                                        );
                                                      },
                                                    );
                                                  },
                                                  icon: const Icon(
                                                    SIcons.add,
                                                    color: SColors.primary,
                                                    size: 16,
                                                  ),
                                                  padding: EdgeInsets.zero,
                                                ),
                                              ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}