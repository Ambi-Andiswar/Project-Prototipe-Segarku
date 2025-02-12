import 'package:flutter/material.dart';
import 'package:segarku/features/orders/widget/no_history.dart';
import 'package:segarku/features/orders/widget/product_history.dart';
import 'package:segarku/utils/constants/colors.dart';
import 'package:segarku/utils/helpers/helper_functions.dart';
import 'package:segarku/utils/local_storage/user_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:segarku/utils/theme/custom_themes/text_theme.dart';

class AllProductHistory extends StatefulWidget {
  const AllProductHistory({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AllProductHistoryState createState() => _AllProductHistoryState();
}

class _AllProductHistoryState extends State<AllProductHistory> {
  List<dynamic> allTransactions = [];
  List<dynamic> filteredTransactions = [];
  String? userId;
  Map<String, dynamic> products = {};
  Timer? _timer;
  String selectedFilter = 'Semua'; // Default filter

  // Daftar pilihan filter
  final List<String> filterOptions = [
    'Semua',
    'Hari ini',
    '7 Hari Terakhir',
    '30 Hari Terakhir',
  ];

  @override
  void initState() {
    super.initState();
    _loadUserId();
  }

  Future<void> _loadUserId() async {
    final storageUid = await UserStorage.getUid();
    setState(() {
      userId = storageUid;
    });
    if (userId != null) {
      _refreshTransactions();
      _timer = Timer.periodic(const Duration(seconds: 30), (timer) {
        _refreshTransactions();
      });
    }
  }

  Future<Map<String, dynamic>> fetchProducts() async {
    final response = await http.get(Uri.parse('https://www.admin-segarku.online/api/products'));

    if (response.statusCode == 200) {
      final List<dynamic> products = json.decode(response.body)['data'];
      // Buat Map dengan key = id produk dan value = data produk
      return {for (var product in products) product['id']: product};
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<void> _refreshTransactions() async {
    if (userId == null) return;

    // Ambil data produk terlebih dahulu
    final productsData = await fetchProducts();
    setState(() {
      products = productsData;
    });

    final transactions = await fetchTransactions(userId!);
    final outgoingTransactions = await fetchOutgoingTransactions(userId!);

    // Gabungkan semua transaksi
    List<dynamic> allTransactions = [...transactions, ...outgoingTransactions];

    // Urutkan transaksi berdasarkan tanggal terbaru
    allTransactions.sort((a, b) {
      DateTime dateA = DateTime.parse(a['created_at']);
      DateTime dateB = DateTime.parse(b['created_at']);
      return dateB.compareTo(dateA); // Urutkan dari yang terbaru ke terlama
    });

    setState(() {
      this.allTransactions = allTransactions;
      _applyFilter(); // Panggil applyFilter setelah allTransactions diperbarui
    });
  }

  Future<List<dynamic>> fetchTransactions(String userId) async {
    final response = await http.get(Uri.parse('https://admin-segarku.online/api/transactions?user_id=$userId'));

    if (response.statusCode == 200) {
      return json.decode(response.body)['data'];
    } else {
      throw Exception('Failed to load transactions');
    }
  }

  Future<List<dynamic>> fetchOutgoingTransactions(String userId) async {
    final response = await http.get(Uri.parse('https://admin-segarku.online/api/outgoingtransactions?user_id=$userId'));

    if (response.statusCode == 200) {
      return json.decode(response.body)['data'];
    } else {
      throw Exception('Failed to load outgoing transactions');
    }
  }

  // Fungsi untuk menerapkan filter
  void _applyFilter() {
    final now = DateTime.now();
    setState(() {
      filteredTransactions = allTransactions.where((transaction) {
        final transactionDate = DateTime.parse(transaction['created_at']);
        switch (selectedFilter) {
          case 'Hari ini':
            return transactionDate.year == now.year &&
                   transactionDate.month == now.month &&
                   transactionDate.day == now.day;
          case '7 Hari Terakhir':
            return transactionDate.isAfter(now.subtract(const Duration(days: 7)));
          case '30 Hari Terakhir':
            return transactionDate.isAfter(now.subtract(const Duration(days: 30)));
          case 'Semua':
          default:
            return true;
        }
      }).toList();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final darkMode = SHelperFunctions.isDarkMode(context);

    return Scaffold(
      // Hapus AppBar karena sudah ada di HistoryOrderProfile
      body: Column(
        children: [
          // Tambahkan Row untuk mengatur layout filter ke kanan
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end, // Mengatur posisi ke kanan
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(40.0),
                    border: Border.all(
                      color: SColors.green500,
                      width: 1.0,
                    ),
                  ),
                  child: DropdownButton<String>(
                    value: selectedFilter,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedFilter = newValue!;
                        _applyFilter(); // Terapkan filter saat pilihan berubah
                      });
                    },
                    items: filterOptions.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: STextTheme.titleCaptionBoldDark.copyWith(color: SColors.green500)
                        ),
                      );
                    }).toList(),
                    underline: Container(), // Hilangkan garis bawah default
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: darkMode ? Colors.white : SColors.green500,
                    ),
                    dropdownColor: darkMode ?  SColors.softBlack500 : SColors.pureWhite,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _refreshTransactions,
              child: filteredTransactions.isEmpty
                  ? const NoHistoryScreen()
                  : ListView.builder(
                      itemCount: filteredTransactions.length,
                      itemBuilder: (context, index) {
                        final transaction = filteredTransactions[index];
                        return ProductHistory(
                          transaction: transaction,
                          darkMode: darkMode,
                          products: products,
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}