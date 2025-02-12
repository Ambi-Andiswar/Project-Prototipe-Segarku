import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:segarku/commons/widget/appbar/appbar.dart';
import 'package:segarku/features/orders/widget/order_detail_history/widget/address_history.dart';
import 'package:segarku/features/orders/widget/order_detail_history/widget/detail_product_history.dart';
import 'package:segarku/features/shop/products/data/product.dart';
import 'package:segarku/navigation_menu.dart';
import 'package:segarku/service/api_product.dart';
import 'package:segarku/utils/constants/colors.dart';
import 'package:segarku/utils/constants/sizes.dart';
import 'package:segarku/utils/theme/custom_themes/text_theme.dart';
import '../../../../../../utils/constants/text_strings.dart';

class OrderDetailHistoryScreen extends StatefulWidget {
  final Map<String, dynamic> transaction;
  
  const OrderDetailHistoryScreen({
    Key? key,
    required this.transaction,
  }) : super(key: key);

  @override
  State<OrderDetailHistoryScreen> createState() => _OrderDetailHistoryScreenState();
}

class _OrderDetailHistoryScreenState extends State<OrderDetailHistoryScreen> {
  Map<String, dynamic> products = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    try {
      // Mengambil semua produk dari API
      List<SProduct> productList = await ApiServiceProduct.fetchProducts();
      
      // Mengkonversi list produk menjadi Map dengan id sebagai key
      Map<String, dynamic> productsMap = {};
      for (var product in productList) {
        productsMap[product.id] = {
          'image': product.image,
          'berat': product.berat,
          'harga': product.harga,
        };
      }

      if (mounted) {
        setState(() {
          products = productsMap;
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error loading products: $e');
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    final bool dark = context.isDarkMode;

    return Scaffold(
      body: Column(
        children: [
          Container(
            color: dark ? SColors.pureBlack : SColors.pureWhite,
            child: Column(
              children: [
                const SizedBox(height: 20),
                SCustomAppBar(
                  title: STexts.orderDetail,
                  darkMode: dark,
                ),
                const SizedBox(height: SSizes.md),
                Divider(
                  color: dark ? SColors.green50 : SColors.softBlack50,
                  thickness: 1,
                  height: 1,
                ),
              ],
            ),
          ),

          // Main Content
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AddressHistory(
                    shippingAddress: widget.transaction['shipping_address'],
                    phone: widget.transaction['phone'],
                    shippingMethod: widget.transaction['shipping_method'],
                    createdAt: widget.transaction['created_at'],
                    status: widget.transaction['status'],
                    deliveryTime: widget.transaction['delivery_time'],
                    darkMode: dark,
                  ),
                  DetailProducthistory(
                    products: widget.transaction['products'],
                    totalAmount: widget.transaction['total_amount'],
                    productData: products,
                  ),
                ],
              ),
            ),
          ),

          // Footer (Beli Lagi)
          Container(
            color: dark ? SColors.pureBlack : SColors.pureWhite,
            padding: const EdgeInsets.symmetric(horizontal: SSizes.defaultMargin),
            child: Column(
              mainAxisSize: MainAxisSize.min, // Membatasi tinggi minimum
              children: [
                const SizedBox(height: SSizes.md2),                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigasi langsung ke halaman lain tanpa popup
                      Get.to(() => const NavigationMenu(initialIndex: 1));
                    },
                    child: const Text(
                      STexts.buyMore,
                      style: STextTheme.titleBaseBoldDark,
                    ),
                  ),
                ),
                const SizedBox(height: SSizes.xl),
              ],
            ),
          ),
        ],
      ),
    );
  }
}