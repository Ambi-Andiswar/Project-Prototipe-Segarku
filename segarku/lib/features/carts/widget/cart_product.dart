import 'package:flutter/material.dart';
import 'package:segarku/features/shop/products/desc_product.dart';
import 'package:segarku/features/transaction/transaction_checkout.dart';
import 'package:segarku/utils/constants/icons.dart';
import 'package:segarku/utils/constants/image_strings.dart';
import 'package:segarku/utils/constants/sizes.dart';
import 'package:segarku/utils/constants/text_strings.dart';
import 'package:segarku/utils/models/product_horizontal.dart';
import 'package:segarku/utils/theme/custom_themes/text_theme.dart';
import '../../../../utils/constants/colors.dart';
import 'package:get/get.dart';
import 'package:segarku/utils/helpers/helper_functions.dart';
import 'package:segarku/utils/models/product.dart';

class CartsProductScreen extends StatefulWidget {
  const CartsProductScreen({super.key});

  @override
  State<CartsProductScreen> createState() => _CartsProductScreenState();
}

class _CartsProductScreenState extends State<CartsProductScreen> {
  final int itemCount = 4;

  final List<Product> products = [
    Product(
      name: "Bayam",
      description: "500 gr/pack",
      image: SImages.bayam,
      price: 8000,
    ),
    Product(
      name: "Semangka",
      description: "800gr-1kg/pack",
      image: SImages.semangka,
      price: 15000,
    ),
    Product(
      name: "Tomat",
      description: "300-500 gr/pack",
      image: SImages.tomat,
      price: 5000,
    ),
    Product(
      name: "Brokoli",
      description: "300-500 gr/pack",
      image: SImages.brokoli,
      price: 25000,
    ),
  ];

  List<bool> selectedItems = [];
  List<int> itemQuantities = [];
  bool selectAll = false;
  bool showPopup = false;

  @override
  void initState() {
    super.initState();
    selectedItems = List<bool>.filled(itemCount, false);
    itemQuantities = List<int>.filled(itemCount, 1);
  }

  void toggleSelectAll(bool? value) {
    setState(() {
      selectAll = value ?? false;
      for (int i = 0; i < selectedItems.length; i++) {
        selectedItems[i] = selectAll;
      }
      showPopup = selectedItems.contains(true);
    });
  }

  void toggleItemSelection(int index, bool? value) {
    setState(() {
      selectedItems[index] = value ?? false;
      selectAll = selectedItems.every((item) => item);
      showPopup = selectedItems.contains(true);
    });
  }

  void updateQuantity(int index, int delta) {
    setState(() {
      itemQuantities[index] = (itemQuantities[index] + delta).clamp(1, 100);
      selectedItems[index] = true;
      showPopup = true;
    });
  }

  int calculateTotalPrice() {
    return itemQuantities
        .asMap()
        .entries
        .where((entry) => selectedItems[entry.key])
        .map((entry) => entry.value * products[entry.key].price) // Assume each item costs 40,000
        .fold(0, (sum, price) => sum + price);
  }

 @override
  Widget build(BuildContext context) {
    final darkMode = SHelperFunctions.isDarkMode(context);

    return Scaffold(
      body: Column(
        children: [
          // Baris atas: Select All dan Delete
          Padding(
            padding: const EdgeInsets.symmetric(
                vertical: SSizes.md, horizontal: SSizes.defaultMargin),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Transform.scale(
                      scale: 1.2,
                      child: Checkbox(
                        value: selectAll,
                        onChanged: toggleSelectAll,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(SSizes.borderRadiussm),
                        ),
                        side: BorderSide(
                          color: darkMode ? SColors.green50 : SColors.softBlack50,
                          width: 1,
                        ),
                        visualDensity: VisualDensity.compact,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ),
                    Text(
                      STexts.selectAll,
                      style: STextTheme.bodyCaptionRegularDark.copyWith(
                        color: darkMode ? SColors.pureWhite : SColors.softBlack500,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {
                    // Logika untuk menghapus item yang dipilih
                    setState(() {
                      for (int i = 0; i < selectedItems.length; i++) {
                        if (selectedItems[i]) {
                          selectedItems[i] = false;
                          itemQuantities[i] = 1; // Reset kuantitas jika diperlukan
                        }
                      }
                      showPopup = false; // Sembunyikan popup jika tidak ada item yang dipilih
                      selectAll = false; // Reset checkbox "Select All"
                    });
                  },
                  icon: const Icon(
                    SIcons.delet,
                    color: SColors.danger500,
                  ),
                ),
              ],
            ),
          ),

          // Daftar Produk
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(SSizes.defaultMargin),
                child: Column(
                  children: [
                    // Container untuk daftar produk
                    Container(
                      padding: const EdgeInsets.all(SSizes.defaultMargin),
                      decoration: BoxDecoration(
                        color: darkMode ? SColors.pureBlack : Colors.white,
                        borderRadius: BorderRadius.circular(SSizes.borderRadiusmd2),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: List.generate(products.length, (index) {
                        final product = products[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const DescProductScreen(),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: SSizes.sm),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(SSizes.borderRadiussm),
                              ),
                              child: Row(
                                children: [
                                  Transform.scale(
                                    scale: 1.2,
                                    child: Checkbox(
                                      value: selectedItems[index],
                                      onChanged: (value) => toggleItemSelection(index, value),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(SSizes.borderRadiussm),
                                      ),
                                      side: BorderSide(
                                        color: darkMode ? SColors.green50 : SColors.softBlack50,
                                        width: 1,
                                      ),
                                      visualDensity: VisualDensity.compact,
                                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                    ),
                                  ),
                                  const SizedBox(width: SSizes.sm2),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.asset(
                                      product.image,
                                      width: 80.0,
                                      height: 80.0,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(width: SSizes.sm2),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          product.name,
                                          style: darkMode
                                              ? STextTheme.titleBaseBlackDark
                                              : STextTheme.titleBaseBlackLight,
                                        ),
                                        Text(
                                          product.description,
                                          style: darkMode
                                              ? STextTheme.bodySmRegularDark
                                              : STextTheme.bodySmRegularLight,
                                        ),
                                        const SizedBox(height: SSizes.sm),
                                        Text(
                                          "Rp. ${product.price}",
                                          style: STextTheme.titleBaseBoldLight.copyWith(
                                            color: SColors.green500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () => updateQuantity(index, -1),
                                        child: Container(
                                          width: 24,
                                          height: 24,
                                          decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            border: Border.all(
                                              color: darkMode
                                                  ? SColors.green50
                                                  : SColors.softBlack50,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(SSizes.borderRadiussm),
                                          ),
                                          child: Icon(
                                            Icons.remove,
                                            size: 16,
                                            color: darkMode
                                                ? SColors.green100
                                                : SColors.softBlack100,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: SSizes.md),
                                      Text(
                                        '${itemQuantities[index]}',
                                        style: darkMode
                                            ? STextTheme.titleBaseBoldDark
                                            : STextTheme.titleBaseBoldLight,
                                      ),
                                      const SizedBox(width: SSizes.md),
                                      GestureDetector(
                                        onTap: () => updateQuantity(index, 1),
                                        child: Container(
                                          width: 24,
                                          height: 24,
                                          decoration: BoxDecoration(
                                            color: SColors.green100,
                                            borderRadius:
                                                BorderRadius.circular(SSizes.borderRadiussm),
                                          ),
                                          child: const Icon(
                                            Icons.add,
                                            size: 16,
                                            color: SColors.green500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                      ),
                    ),

                    // Tambahkan Container SProductH
                    const SizedBox(height: SSizes.md2),
                    Container(
                      color: Colors.transparent,
                      padding: const EdgeInsets.only(
                        left: SSizes.md,
                        top: SSizes.lg,
                        bottom: SSizes.lg,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            STexts.youLink,
                            style: darkMode
                                ? STextTheme.titleBaseBoldDark
                                : STextTheme.titleBaseBoldLight,
                          ),
                          const SizedBox(height: SSizes.md),
                          Divider(
                            thickness: 1.0,
                            color: darkMode ? SColors.green50 : SColors.softBlack50,
                          ),
                          const SizedBox(height: SSizes.md),
                          const SProductH(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Bagian Fixed untuk tombol bayar
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8.0,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Voucher Button
                Container(
                  margin: const EdgeInsets.only(bottom: 8.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: SColors.green500),
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.transparent,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 21.0, vertical: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              SIcons.voucher,
                              color: SColors.green500,
                            ),
                            SizedBox(width: 8),
                            Text(
                              STexts.buttonVoucher,
                              style: STextTheme.ctaSm,
                            ),
                          ],
                        ),
                        Icon(
                          SIcons.arrowRight,
                          color: SColors.green500,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: SSizes.md2),
                // Total and Pay Button Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Text Section
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Total",
                          style: darkMode
                              ? STextTheme.bodyCaptionRegularDark
                              : STextTheme.bodyCaptionRegularLight,
                        ),
                        const SizedBox(height: SSizes.xs - 2),
                        Text(
                          "Rp ${calculateTotalPrice()}",
                          style: darkMode
                              ? STextTheme.titleMdBoldDark
                              : STextTheme.titleMdBoldLight,
                        ),
                      ],
                    ),
                    // Button Section
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: SColors.green500,
                        minimumSize: const Size(165, 46), // Ukuran tombol
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () => Get.to(() => const TransactionCheckoutScreen()),
                      child: const Text(
                        STexts.buy,
                        style: STextTheme.titleBaseBoldDark,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}