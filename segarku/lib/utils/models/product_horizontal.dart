import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:segarku/features/shop/products/models/product.dart';
import 'package:segarku/utils/constants/icons.dart';
import 'package:segarku/utils/constants/image_strings.dart';
import 'package:segarku/features/shop/products/desc_product.dart';
import 'package:segarku/utils/constants/sizes.dart';
import 'package:segarku/utils/theme/custom_themes/text_theme.dart';
import '../../../../utils/constants/colors.dart';
import 'package:segarku/utils/helpers/helper_functions.dart';

class SProductH extends StatelessWidget {
  const SProductH({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = SHelperFunctions.isDarkMode(context);

    final List<Product> products = [
      Product(
        image: SImages.semangka,
        name: "Semangka",
        size: "800gr-1kg /pack",
        price: 15000,
        description: "Semangka adalah buah segar yang kaya akan kandungan air, menjadikannya pilihan sempurna untuk menghidrasi tubuh. Buah ini memiliki daging berwarna merah cerah atau kuning dengan rasa manis alami yang nikmat. Semangka kaya akan vitamin A, vitamin C, dan antioksidan seperti likopen, yang baik untuk menjaga kesehatan kulit, meningkatkan daya tahan tubuh, dan melindungi dari radikal bebas. Buah ini sering dinikmati sebagai camilan segar, jus, atau sebagai pelengkap salad buah."),
      Product(
        image: SImages.terong,
        name: "Terong",
        size: "500 gr/pack",
        price: 10000,
        description: "Terong adalah sayuran serbaguna dengan tekstur lembut dan rasa yang khas. Sayuran ini kaya akan serat, vitamin B, dan mineral seperti kalium dan magnesium, yang baik untuk mendukung kesehatan jantung dan pencernaan. Terong dapat diolah dengan berbagai cara, seperti digoreng, dipanggang, ditumis, atau dijadikan bahan utama dalam masakan seperti ratatouille atau balado terong."), 
      Product(
        image: SImages.wortel,
        name: "Wortel",
        size: "500 gr/pack",
        price: 5000,
        description: "Wortel adalah sayuran akar yang dikenal karena warna oranye cerahnya dan kandungan beta-karoten yang tinggi, yang diubah oleh tubuh menjadi vitamin A. Nutrisi ini sangat penting untuk menjaga kesehatan mata, kulit, dan sistem imun. Wortel memiliki rasa manis alami yang cocok untuk dimakan mentah sebagai camilan, dimasak sebagai pelengkap hidangan, atau diolah menjadi jus sehat."),
      Product(
        image: SImages.brokoli,
        name: "Brokoli",
        size: "300-500 gr/pack",
        price: 25000,
        description: "Brokoli adalah sayuran hijau dari keluarga cruciferous yang kaya akan vitamin C, vitamin K, serat, dan antioksidan. Sayuran ini bermanfaat untuk mendukung kesehatan tulang, meningkatkan sistem imun, dan melawan peradangan dalam tubuh. Brokoli dapat dimasak dengan cara dikukus, direbus, atau ditumis, dan sering menjadi bahan favorit dalam sup, salad, atau hidangan tumisan."),
      Product(
        image: SImages.lobak,
        name: "Lobak Putih",
        size: "500 gr/pack",
        price: 13000,
        description: "Lobak putih adalah sayuran akar dengan rasa yang ringan dan sedikit pedas. Lobak ini kaya akan vitamin C, serat, dan senyawa antioksidan yang membantu melancarkan pencernaan, mendukung detoksifikasi tubuh, dan meningkatkan sistem imun. Lobak putih sering digunakan dalam masakan sup, tumisan, atau acar, serta sebagai pelengkap hidangan khas Asia."),
      Product(
        image: SImages.tomat,
        name: "Tomat",
        size: "300-500 gr/pack",
        price: 5000,
        description: "Tomat adalah buah yang sering dianggap sebagai sayuran karena penggunaannya dalam masakan. Tomat memiliki rasa asam dan manis yang segar, serta kaya akan likopen, vitamin C, dan kalium, yang baik untuk kesehatan jantung, kulit, dan daya tahan tubuh. Tomat dapat dimakan mentah, dijadikan jus, atau digunakan sebagai bahan utama dalam saus, sup, dan berbagai hidangan."),
      Product(
        image: SImages.paprika,
        name: "Paprika Kuning",
        size: "400 gr/pack",
        price: 30000,
        description: "Paprika kuning adalah sayuran berwarna cerah dengan rasa manis yang lembut. Kaya akan vitamin C, vitamin A, dan antioksidan, paprika kuning membantu menjaga kesehatan kulit, meningkatkan daya tahan tubuh, dan melindungi sel dari kerusakan akibat radikal bebas. Paprika kuning sering digunakan dalam salad, tumisan, panggangan, atau sebagai camilan segar."),
      Product(
        image: SImages.bayam,
        name: "Bayam",
        size: "500 gr/pack",
        price: 8000,
        description: "Bayam adalah jenis sayuran hijau yang kaya akan nutrisi dan sering digunakan dalam berbagai masakan. Tanaman ini berasal dari keluarga Amaranthaceae dan dikenal dengan daun hijau yang lembut serta rasa yang ringan. Bayam mengandung banyak zat gizi penting, seperti vitamin A, vitamin C, vitamin K, zat besi, kalsium, dan serat, yang bermanfaat untuk kesehatan tubuh.Bayam dapat dimasak dengan berbagai cara, seperti ditumis, direbus, atau dijadikan campuran dalam sup. Selain itu, bayam juga sering diolah menjadi jus atau smoothie sehat. Konsumsi bayam secara rutin dapat membantu meningkatkan daya tahan tubuh, menjaga kesehatan mata, dan mendukung sistem pencernaan yang baik."),
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: products.map((product) {
          return Padding(
            padding: const EdgeInsets.only(right: SSizes.md),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DescProductScreen(product: product),
                  ),
                );
              },
              child: Container(
                width: 140,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: darkMode ? SColors.green50 : SColors.softBlack50,
                  ),
                  borderRadius: BorderRadius.circular(SSizes.borderRadiusmd2),
                  color: darkMode ? SColors.slateBlack : SColors.pureWhite,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(SSizes.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(SSizes.borderRadiusmd),
                        child: Image.asset(
                          product.image,
                          fit: BoxFit.cover,
                          height: 100,
                          width: double.infinity,
                        ),
                      ),
                      const SizedBox(height: SSizes.sm2),
                      Text(
                        product.name,
                        style: darkMode
                            ? STextTheme.titleBaseBoldDark
                            : STextTheme.titleBaseBoldLight,
                      ),
                      Text(
                        product.size,
                        style: darkMode
                            ? STextTheme.bodySmRegularDark
                            : STextTheme.bodySmRegularLight,
                      ),
                      const SizedBox(height: SSizes.xs),
                      Row(
                        children: [
                          Text(
                            NumberFormat.currency(
                              locale: 'id', 
                              symbol: 'Rp. ', 
                              decimalDigits: 0 // Mengatur agar tidak ada angka desimal
                            ).format(product.price),  
                            style: darkMode
                                ? STextTheme.titleCaptionBlackDark
                                : STextTheme.titleCaptionBlackLight,
                          ),
                          const Spacer(),
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: darkMode ? SColors.pureBlack : SColors.green50,
                              borderRadius: BorderRadius.circular(SSizes.borderRadiussm),
                            ),
                            child: IconButton(
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(SSizes.borderRadiusmd2),
                                    ),
                                  ),
                                  builder: (context) {
                                    return AddToCartPopup(
                                      price: product.price,
                                      name: product.name, // Kirimkan nama produk ke dialog
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
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class AddToCartPopup extends StatefulWidget {
  final int price;
  final String name;

  const AddToCartPopup({super.key, required this.price, required this.name});

  @override
  State<AddToCartPopup> createState() => _AddToCartPopupState();
}

class _AddToCartPopupState extends State<AddToCartPopup> {
  int quantity = 1;

  void _addToCart() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final darkMode = SHelperFunctions.isDarkMode(context);

    return Padding(
      padding: const EdgeInsets.all(SSizes.defaultMargin),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.name, // Menampilkan nama produk
                style: darkMode
                    ? STextTheme.titleBaseBoldDark
                    : STextTheme.titleBaseBoldLight,
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: quantity > 1
                        ? () => setState(() => quantity--)
                        : null,
                    child: Icon(
                      Icons.remove,
                      color: darkMode
                          ? SColors.green50
                          : SColors.softBlack50,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text('$quantity',
                        style: darkMode
                            ? STextTheme.titleBaseBoldDark
                            : STextTheme.titleBaseBoldLight),
                  ),
                  GestureDetector(
                    onTap: () => setState(() => quantity++),
                    child: const Icon(
                      Icons.add,
                      color: SColors.green500,
                    ),
                  ),
                ],
              ),
              Text(
                'Rp. ${NumberFormat.decimalPattern('id').format(widget.price * quantity)}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: SColors.green500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _addToCart,
              child: const Text('Tambahkan ke Keranjang'),
            ),
          ),
        ],
      ),
    );
  }
}
