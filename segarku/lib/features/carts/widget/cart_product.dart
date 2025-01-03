import 'package:flutter/material.dart';
import 'package:segarku/features/shop/products/desc_product.dart';
import 'package:segarku/utils/constants/image_strings.dart';
import 'package:segarku/utils/constants/sizes.dart';
import 'package:segarku/utils/theme/custom_themes/text_theme.dart';
import '../../../../utils/constants/colors.dart';
import 'package:segarku/utils/helpers/helper_functions.dart';

class CartsProductScreen extends StatefulWidget {
  const CartsProductScreen({super.key});

  @override
  State<CartsProductScreen> createState() => _CartsProductScreenState();
}

class _CartsProductScreenState extends State<CartsProductScreen> {
  final int itemCount = 8;

  // State for selected items and their quantities
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
        .map((entry) => entry.value * 40000) // Assume each item costs 40,000
        .fold(0, (sum, price) => sum + price);
  }

  @override
  Widget build(BuildContext context) {
    final darkMode = SHelperFunctions.isDarkMode(context);

    return Stack(
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: SSizes.md, horizontal: SSizes.defaultMargin),
              child: Row(
                children: [
                  Checkbox(
                    value: selectAll,
                    onChanged: toggleSelectAll,
                  ),
                  Text(
                    "Pilih Semua",
                    style: darkMode
                    ? STextTheme.bodyCaptionRegularDark
                    : STextTheme.bodyCaptionRegularLight
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: itemCount,
                itemBuilder: (context, index) {
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
                      padding: const EdgeInsets.symmetric(vertical: SSizes.md, horizontal: SSizes.defaultMargin),
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: darkMode ? SColors.pureBlack : Colors.white,
                        ),
                        child: Row(
                          children: [
                            Checkbox(
                              value: selectedItems[index],
                              onChanged: (value) => toggleItemSelection(index, value),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.asset(
                                SImages.brokoli,
                                width: 80.0,
                                height: 80.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: SSizes.sm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Brokoli",
                                    style: darkMode
                                      ? STextTheme.titleBaseBlackDark
                                      :  STextTheme.titleBaseBlackLight
                                  ),
                                  Text(
                                    "300-500 gr/pack",
                                    style: darkMode
                                      ? STextTheme.bodySmRegularDark
                                      : STextTheme.bodySmRegularLight,
                                  ),
                                  const SizedBox(height: SSizes.sm),
                                  Text(
                                    "IDR 40.000",
                                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      color: darkMode ? SColors.pureWhite : SColors.softBlack500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const SizedBox(height: 33),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () => updateQuantity(index, -1),
                                      child: Container(
                                        width: 24,
                                        height: 24,
                                        decoration: BoxDecoration(
                                          color: darkMode ? SColors.pureBlack : Colors.white,
                                          borderRadius: BorderRadius.circular(100),
                                          border: Border.all(color: SColors.green500),
                                        ),
                                        child: const Icon(Icons.remove, size: 16, color: SColors.green500),
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    Text(
                                      '${itemQuantities[index]}',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: darkMode ? SColors.pureWhite : SColors.softBlack500,
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    GestureDetector(
                                      onTap: () => updateQuantity(index, 1),
                                      child: Container(
                                        width: 24,
                                        height: 24,
                                        decoration: BoxDecoration(
                                          color: SColors.green500,
                                          borderRadius: BorderRadius.circular(100),
                                        ),
                                        child: Icon(Icons.add, size: 16, color: darkMode ? SColors.pureBlack : SColors.pureWhite),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        if (showPopup)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
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
                children: [
                  Text(
                    "Total Harga: IDR ${calculateTotalPrice()}",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: SColors.green500,
                        ),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: SColors.green500,
                      minimumSize: const Size(double.infinity, 48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      // Implement checkout functionality
                    },
                    child: const Text(
                      "Checkout",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
