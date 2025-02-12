// transaction_history_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:segarku/features/orders/models/transaction_model.dart';
import 'package:segarku/utils/local_storage/user_storage.dart';

class TransactionHistoryService {
  static const String baseUrl = "https://admin-segarku.online/api/transactions";

  static Future<List<TransactionHistoryModel>> getUserTransactions() async {
    try {
      final String? uid = await UserStorage.getUid();
      if (uid == null) throw Exception('User ID not found');

      final response = await http.get(
        Uri.parse('$baseUrl?user_id=$uid'),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data
            .map((json) => TransactionHistoryModel.fromJson(json))
            .where((transaction) => 
                transaction.paymentStatus.toLowerCase() == 'pending' || 
                transaction.paymentStatus.toLowerCase() == 'processing')
            .toList();
      } else {
        throw Exception('Failed to load transactions');
      }
    } catch (e) {
      print('Error fetching transactions: $e');
      return [];
    }
  }
}