import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:segarku/utils/constants/colors.dart';
import 'package:segarku/utils/constants/image_strings.dart';
import 'package:segarku/utils/constants/sizes.dart';
import 'package:segarku/utils/constants/text_strings.dart';
import 'package:segarku/utils/helpers/helper_functions.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:segarku/utils/theme/custom_themes/text_theme.dart';

class DetailProducthistory extends StatelessWidget {
  final List<dynamic> products;
  final int totalAmount;
  final Map<String, dynamic> productData;

  const DetailProducthistory({
    super.key,
    required this.products,
    required this.totalAmount,
    required this.productData,
  });

  // Perbaikan fungsi calculateSubtotal untuk mengembalikan int
  int calculateSubtotal(List<dynamic> products) {
    num total = products
        .where((product) => product['id'] != "TAX" && product['id'] != "DELIVERY")
        .fold(0, (sum, product) {
          int price = int.parse(product['price'].toString());
          int quantity = int.parse(product['quantity'].toString());
          return sum + (price * quantity);
        });
    return total.toInt(); // Konversi num ke int
  }

  String formatPrice(dynamic price) {
    return NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp. ',
      decimalDigits: 0,
    ).format(price is String ? int.tryParse(price) ?? 0 : price);
  }

  @override
  Widget build(BuildContext context) {
    final darkMode = SHelperFunctions.isDarkMode(context);

    final List<dynamic> productItems = products
        .where((product) => product['id'] != "TAX" && product['id'] != "DELIVERY")
        .toList();
    final dynamic taxItem = products.firstWhere(
        (product) => product['id'] == "TAX",
        orElse: () => null);
    final dynamic deliveryItem = products.firstWhere(
        (product) => product['id'] == "DELIVERY",
        orElse: () => null);

    final subtotal = calculateSubtotal(products);

    return Container(
      margin: const EdgeInsets.only(
        left: SSizes.defaultMargin,
        top: SSizes.defaultMargin,
        right: SSizes.defaultMargin,
      ),
      padding: const EdgeInsets.all(SSizes.defaultMargin),
      decoration: BoxDecoration(
        color: darkMode ? SColors.pureBlack : Colors.white,
        borderRadius: BorderRadius.circular(SSizes.borderRadiussm),
        border: Border.all(
          color: darkMode ? SColors.green50 : SColors.softBlack50,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: SSizes.defaultMargin),
            child: Text(
              "Detail Produk",
              style: darkMode
                  ? STextTheme.titleBaseBoldDark
                  : STextTheme.titleBaseBoldLight,
            ),
          ),

          Column(
            children: productItems.map((product) {
              final isLast = product == productItems.last;
              final productDetail = productData[product['id'].toString()];
              
              return Padding(
                padding: EdgeInsets.only(bottom: isLast ? 0 : SSizes.lg),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(SSizes.borderRadiussm),
                      child: productDetail != null && productDetail['image'] != null
                          ? Image.network(
                              productDetail['image'],
                              width: 80.0,
                              height: 80.0,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  SImages.buahCategory,
                                  width: 80.0,
                                  height: 80.0,
                                  fit: BoxFit.cover,
                                );
                              },
                            )
                          : Image.asset(
                              SImages.buahCategory,
                              width: 80.0,
                              height: 80.0,
                              fit: BoxFit.cover,
                            ),
                    ),
                    const SizedBox(width: SSizes.sm2),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product['name'],
                            style: darkMode
                                ? STextTheme.titleBaseBlackDark
                                : STextTheme.titleBaseBlackLight,
                          ),
                          Text(
                            productDetail?['berat']?.toString() ?? '0 Kg/pack',
                            style: darkMode
                                ? STextTheme.bodySmRegularDark
                                : STextTheme.bodySmRegularLight,
                          ),
                          const SizedBox(height: SSizes.sm),
                          Text(
                            formatPrice(product['price']),
                            style: STextTheme.titleBaseBoldLight.copyWith(
                              color: SColors.green500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 80.0,
                      alignment: Alignment.bottomRight,
                      child: Text(
                        "${product['quantity']} item(s)",
                        style: darkMode
                            ? STextTheme.bodyCaptionRegularDark
                            : STextTheme.bodyCaptionRegularLight,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: SSizes.md),
          const Divider(color: SColors.softBlack50, thickness: 1),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: SSizes.md),
            child: Column(
              children: [
                _buildPriceRow("Subtotal", formatPrice(subtotal)),
                if (taxItem != null) ...[
                  const SizedBox(height: SSizes.sm),
                  _buildPriceRow("PPN (5%)", formatPrice(taxItem['price'])),
                ],
                if (deliveryItem != null) ...[
                  const SizedBox(height: SSizes.sm),
                  _buildPriceRow("Ongkir", formatPrice(deliveryItem['price'])),
                ],
              ],
            ),
          ),

          const SizedBox(height: SSizes.md),

          Dash(
            length: MediaQuery.of(context).size.width -
                (SSizes.defaultMargin * 4.3),
            dashLength: 4.0,
            dashGap: 4.0,
            direction: Axis.horizontal,
            dashColor: darkMode ? SColors.green50 : SColors.softBlack50,
            dashBorderRadius: 4.0,
          ),

          const SizedBox(height: SSizes.md),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                STexts.total,
                style: darkMode
                    ? STextTheme.titleCaptionBoldDark
                    : STextTheme.titleCaptionBoldLight,
              ),
              const Spacer(),
              Text(
                formatPrice(totalAmount),
                style: STextTheme.titleBaseBoldDark.copyWith(
                  color: SColors.green500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRow(String label, String price) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: STextTheme.bodySmRegularLight,
        ),
        Text(
          price,
          style: STextTheme.titleBaseBoldLight,
        ),
      ],
    );
  }
}