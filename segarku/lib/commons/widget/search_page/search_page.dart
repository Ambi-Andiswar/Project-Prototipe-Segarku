import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:segarku/commons/widget/appbar/appbar.dart';
import 'package:segarku/commons/widget/search_page/widget/no_result.dart';
import 'package:segarku/features/shop/products/add_to_cart_popup.dart';
import 'package:segarku/features/shop/products/desc_product.dart';
import 'package:segarku/service/api_product.dart';
import 'package:segarku/utils/constants/colors.dart';
import 'package:segarku/utils/constants/drop_shadow.dart';
import 'package:segarku/utils/constants/icons.dart';
import 'package:segarku/utils/constants/sizes.dart';
import 'package:segarku/utils/constants/text_strings.dart';
import 'package:segarku/features/shop/products/data/product.dart';
import 'package:segarku/utils/models/fields_search.dart';
import 'package:segarku/utils/theme/custom_themes/text_theme.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<SProduct> _products = [];
  List<SProduct> _filteredProducts = [];
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  bool _isSearchFocused = false;

  @override
  void initState() {
    super.initState();
    _fetchProducts();
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

  Future<void> _fetchProducts() async {
    try {
      final products = await ApiServiceProduct.fetchProducts();
      setState(() {
        _products = products;
        _filteredProducts = products;
      });
    } catch (e) {
      print('Error fetching products: $e');
    }
  }

  void _searchProducts(String query) {
    setState(() {
      _filteredProducts = _products
          .where((product) =>
              product.nama.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Column(
        children: [
          Container(
            color: dark ? SColors.pureBlack : SColors.pureWhite,
            child: Column(
              children: [
                const SizedBox(height: 20),
                SCustomAppBar(
                  title: STexts.search,
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
                    left: SSizes.defaultMargin,
                    right: SSizes.defaultMargin,
                  ),
                  child: InputFieldSearch.fieldSearchPage(
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
          // Bagian yang dapat di-scroll (Konten Produk)
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: SSizes.defaultMargin,
                ),
                child: Column(
                  children: [
                    if (_searchController.text.isNotEmpty && _filteredProducts.isEmpty)
                      const Center(
                        child: NoResultScreen(),
                      )
                    else
                      _buildProductGrid(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _filteredProducts.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.75,
      ),
      itemBuilder: (context, index) {
        final product = _filteredProducts[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DescProductScreen(
                  product: SProduct(
                    id: product.id,
                    image: product.image,
                    nama: product.nama,
                    berat: product.berat,
                    harga: product.harga,
                    deskripsi: product.deskripsi,
                    qty: product.qty,
                    categoryId: product.categoryId,
                    categoryName: product.categoryName,
                    showPhoto: product.showPhoto,
                    category: product.category,
                  ),
                ),
             ),
           );
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).brightness == Brightness.dark ? SColors.green50 : SColors.softBlack50,
              ),
              borderRadius: BorderRadius.circular(SSizes.borderRadiusmd2),
              color: Theme.of(context).brightness == Brightness.dark ? SColors.pureBlack : SColors.pureWhite,
              boxShadow: [SShadows.contentShadow],
            ),
            child: Padding(
              padding: const EdgeInsets.all(SSizes.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(SSizes.borderRadiusmd),
                      child: Image.network(
                        product.image,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: SSizes.sm2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.nama,
                          style: Theme.of(context).brightness == Brightness.dark
                              ? STextTheme.titleBaseBoldDark
                              : STextTheme.titleBaseBoldLight,
                        ),
                        Row(
                          children: [
                            Text(
                              product.berat,
                              style: Theme.of(context).brightness == Brightness.dark
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
                              style: Theme.of(context).brightness == Brightness.dark
                                  ? STextTheme.titleBaseBlackDark
                                  : STextTheme.titleBaseBlackLight,
                            ),
                            const Spacer(),
                            Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                color: Theme.of(context).brightness == Brightness.dark
                                    ? SColors.pureBlack
                                    : SColors.green50,
                                borderRadius: BorderRadius.circular(SSizes.borderRadiussm),
                              ),
                              child: IconButton(
                                onPressed: () {
                                  showModalBottomSheet(
                                    context: context,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(16),
                                      ),
                                    ),
                                    builder: (context) {
                                      return SAddToCartPopup(
                                          price: (product.harga),
                                          name: product.nama,
                                          id: product.id,
                                          maxQuantity:(product.qty),
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
          ),
        );
      },
    );
  }
}