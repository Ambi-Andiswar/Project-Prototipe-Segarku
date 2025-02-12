import 'package:flutter/material.dart';
import 'package:segarku/features/orders/widget/no_history.dart';
import 'package:segarku/features/orders/widget/product_history.dart';
import 'package:segarku/utils/helpers/helper_functions.dart';
import 'package:segarku/utils/local_storage/user_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class OnproccessHistory extends StatefulWidget {
  const OnproccessHistory({super.key});

  @override
  _OnproccessHistoryState createState() => _OnproccessHistoryState();
}

class _OnproccessHistoryState extends State<OnproccessHistory> {
  List<dynamic> transactions = [];
  Map<String, dynamic> products = {}; // Menyimpan data produk
  String? userId;
  Timer? _timer;

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
      await _refreshTransactions();
      _timer = Timer.periodic(Duration(seconds: 30), (timer) {
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

    // Ambil data transaksi
    final transactionsData = await fetchTransactions(userId!);

    // Urutkan transaksi berdasarkan tanggal terbaru
    transactionsData.sort((a, b) {
      DateTime dateA = DateTime.parse(a['created_at']);
      DateTime dateB = DateTime.parse(b['created_at']);
      return dateB.compareTo(dateA); // Urutkan dari yang terbaru ke terlama
    });

    setState(() {
      transactions = transactionsData;
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

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final darkMode = SHelperFunctions.isDarkMode(context);

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _refreshTransactions,
        child: transactions.isEmpty
            ? const NoHistoryScreen()
            : ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  final transaction = transactions[index];
                  return ProductHistory(
                    transaction: transaction,
                    darkMode: darkMode,
                    products: products, // Kirim data produk ke ProductHistory
                  );
                },
              ),
      ),
    );
  }
}