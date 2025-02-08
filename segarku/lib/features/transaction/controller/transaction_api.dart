import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:segarku/features/transaction/models/transaction_models.dart';

class ApiServiceTransaction {
  static const String baseUrl = "https://admin-segarku.online/api/transactions";

  // Request Snap Token dari Backend
  static Future<String?> createTransaction(TransactionModel transaction) async {
  try {
    const url = "$baseUrl/create";
    final body = jsonEncode(transaction.toJson());
    
    print("DEBUG API:");
    print("URL: $url");
    print("Request Headers: {Content-Type: application/json, Accept: application/json}");
    print("Request Body: $body");
    
    final response = await http.post(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json"
      },
      body: body,
    );

    print("Response Status Code: ${response.statusCode}");
    print("Response Headers: ${response.headers}");
    print("Response Body: ${response.body}");

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print("Parsed Response Data: $data");
      
      final snapToken = data['snap_token'];
      print("Extracted Snap Token: $snapToken");
      
      return snapToken;
    } else {
      print("Error Response Status: ${response.statusCode}");
      print("Error Response Body: ${response.body}");
      return null;
    }
  } catch (e, stackTrace) {
    print("API Exception:");
    print("Error: $e");
    print("Stack Trace: $stackTrace");
    return null;
  }
}
}
