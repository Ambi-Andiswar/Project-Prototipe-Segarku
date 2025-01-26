import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:segarku/commons/widget/cart/no_carts.dart';
import 'package:segarku/features/shop/products/models/product.dart';
import 'package:segarku/features/transaction/transaction_checkout.dart';
import 'package:segarku/utils/constants/drop_shadow.dart';
import 'package:segarku/utils/constants/icons.dart';
import 'package:segarku/utils/constants/image_strings.dart';
import 'package:segarku/utils/constants/sizes.dart';
import 'package:segarku/utils/constants/text_strings.dart';
import 'package:segarku/utils/models/product_horizontal.dart';
import 'package:segarku/utils/theme/custom_themes/text_theme.dart';
import '../../../../utils/constants/colors.dart';
import 'package:get/get.dart';
import 'package:segarku/utils/helpers/helper_functions.dart';

class CartsProductScreen extends StatefulWidget {
  const CartsProductScreen({super.key});

  @override
  State<CartsProductScreen> createState() => _CartsProductScreenState();
}

class _CartsProductScreenState extends State<CartsProductScreen> {
  final int itemCount = 4;

  final List<Product> products = [
      Product(
        id: '7',
        image: SImages.bayam,
        name: "Bayam",
        size: "500 gr/pack",
        price: 8000,
        description: "Bayam adalah jenis sayuran hijau yang kaya akan nutrisi dan sering digunakan dalam berbagai masakan. Tanaman ini berasal dari keluarga Amaranthaceae dan dikenal dengan daun hijau yang lembut serta rasa yang ringan. Bayam mengandung banyak zat gizi penting, seperti vitamin A, vitamin C, vitamin K, zat besi, kalsium, dan serat, yang bermanfaat untuk kesehatan tubuh.Bayam dapat dimasak dengan berbagai cara, seperti ditumis, direbus, atau dijadikan campuran dalam sup. Selain itu, bayam juga sering diolah menjadi jus atau smoothie sehat. Konsumsi bayam secara rutin dapat membantu meningkatkan daya tahan tubuh, menjaga kesehatan mata, dan mendukung sistem pencernaan yang baik."),
      Product(
        id: '8',
        image: SImages.semangka,
        name: "Semangka",
        size: "800gr-1kg /pack",
        price: 15000,
        description: "Semangka adalah buah segar yang kaya akan kandungan air, menjadikannya pilihan sempurna untuk menghidrasi tubuh. Buah ini memiliki daging berwarna merah cerah atau kuning dengan rasa manis alami yang nikmat. Semangka kaya akan vitamin A, vitamin C, dan antioksidan seperti likopen, yang baik untuk menjaga kesehatan kulit, meningkatkan daya tahan tubuh, dan melindungi dari radikal bebas. Buah ini sering dinikmati sebagai camilan segar, jus, atau sebagai pelengkap salad buah."),
      Product(
        id: '3',
        image: SImages.tomat,
        name: "Tomat",
        size: "300-500 gr/pack",
        price: 5000,
        description: "Tomat adalah buah yang sering dianggap sebagai sayuran karena penggunaannya dalam masakan. Tomat memiliki rasa asam dan manis yang segar, serta kaya akan likopen, vitamin C, dan kalium, yang baik untuk kesehatan jantung, kulit, dan daya tahan tubuh. Tomat dapat dimakan mentah, dijadikan jus, atau digunakan sebagai bahan utama dalam saus, sup, dan berbagai hidangan."),
      Product(
        id: '1',
        image: SImages.brokoli,
        name: "Brokoli",
        size: "300-500 gr/pack",
        price: 25000,
        description: "Brokoli adalah sayuran hijau dari keluarga cruciferous yang kaya akan vitamin C, vitamin K, serat, dan antioksidan. Sayuran ini bermanfaat untuk mendukung kesehatan tulang, meningkatkan sistem imun, dan melawan peradangan dalam tubuh. Brokoli dapat dimasak dengan cara dikukus, direbus, atau ditumis, dan sering menjadi bahan favorit dalam sup, salad, atau hidangan tumisan."),
      
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

      // Cek apakah daftar produk kosong
    if (products.isEmpty) {
      return const NoItemCartScreen();
    }

    return Scaffold(
      body: Column(
        children: [
          // Baris atas: Select All dan Delete
          Padding(
            padding: const EdgeInsets.only(
                left: SSizes.defaultMargin, right: SSizes.defaultMargin, top: SSizes.md),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Transform.scale(
                      scale: 1.3,
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

          // konten product yang dimasukan di keranjang
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal : SSizes.defaultMargin, vertical: SSizes.sm2),
                child: Column(
                  children: [
                    // Container untuk daftar produk
                    Container(
                      padding: const EdgeInsets.only(
                        top : SSizes.defaultMargin,
                        right: SSizes.defaultMargin,
                        bottom: SSizes.defaultMargin
                        ),
                      decoration: BoxDecoration(
                        color: darkMode ? SColors.pureBlack : Colors.white,
                        borderRadius: BorderRadius.circular(SSizes.borderRadiusmd2),
                        border: Border.all(
                          color: darkMode
                            ? SColors.green50
                            : SColors.softBlack50
                        )
                      ),
                      child: Column(
                        children: List.generate(products.length, (index) {
                          final product = products[index];
                          return Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) => DescProductScreen(product: product),
                                  //   ),
                                  // );
                                },
                                child: Container(
                                  padding: const EdgeInsets.only(left: SSizes.sm2),
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(SSizes.borderRadiussm),
                                  ),
                                  child: Row(
                                    children: [
                                      Transform.scale(
                                        scale: 1.3,
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
                                      const SizedBox(width: SSizes.sm),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(SSizes.borderRadiussm),
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
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            // Teks nama dan ukuran
                                            Text(
                                              product.name,
                                              style: darkMode
                                                  ? STextTheme.titleBaseBlackDark
                                                  : STextTheme.titleBaseBlackLight,
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              product.size,
                                              style: darkMode
                                                  ? STextTheme.bodySmRegularDark
                                                  : STextTheme.bodySmRegularLight,
                                            ),
                                            const SizedBox(height: 8),
                                            // Harga dan kontrol kuantitas dalam 1 Row
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                // Teks harga
                                                Text(
                                                  'Rp. ${NumberFormat.decimalPattern('id').format(product.price)}',
                                                  style: STextTheme.titleBaseBoldLight.copyWith(
                                                    color: SColors.green500,
                                                  ),
                                                ),
                                                // Kontrol kuantitas
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
                                                          borderRadius: BorderRadius.circular(
                                                              SSizes.borderRadiussm),
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
                                                          borderRadius: BorderRadius.circular(
                                                              SSizes.borderRadiussm),
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
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              if (index != products.length - 1)
                                const SizedBox(height: 20), // Jarak antar produk
                            ],
                          );
                        }),
                      ),
                    ),

                    // Konten product yang mungkin anda suka
                    const SizedBox(height: SSizes.md2),
                    Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            STexts.youLink,
                            style: darkMode
                                ? STextTheme.titleBaseBoldDark
                                : STextTheme.titleBaseBoldLight,
                          ),
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
                SShadows.buttonShadow
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                        minimumSize: const Size(165, 40), // Ukuran tombol
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(SSizes.borderRadiusmd),
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