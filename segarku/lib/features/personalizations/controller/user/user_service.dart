import 'package:segarku/utils/local_storage/user_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserApiService {
  static const String baseUrl = 'https://admin-segarku.online/api/customers';

  // Get semua customers
  static Future<List<Map<String, dynamic>>> getAllCustomers() async {
    try {
      final apiKey = await UserStorage.getApiKey();
      final response = await http.get(
        Uri.parse(baseUrl),
        headers: {
          'X-API-KEY': apiKey ?? '',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return List<Map<String, dynamic>>.from(responseData['data']);
      } else {
        throw Exception('Failed to load customers');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Get single customer profile (berdasarkan uid)
  static Future<Map<String, dynamic>> getCustomerProfile(String uid) async {
    try {
      final apiKey = await UserStorage.getApiKey();
      final response = await http.get(
        Uri.parse('$baseUrl/$uid'),
        headers: {
          'X-API-KEY': apiKey ?? '',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return responseData['data'];
      } else {
        throw Exception('Failed to load profile');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Fungsi untuk menambahkan alamat baru
  static Future<void> addCustomerAddress({
    required String uid,
    required String addressDetail,
    required String addressNote,
    required String recipientName,
    required String recipientPhone,
  }) async {
    try {
      final apiKey = await UserStorage.getApiKey();
      final response = await http.post(
        Uri.parse('$baseUrl/$uid/TambahAlamat'),
        headers: {
          'X-API-KEY': apiKey ?? '',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'alamat': addressDetail,
          'catatan': addressNote,
          'nama_penerima': recipientName,
          'telepon': recipientPhone,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print('Alamat berhasil ditambahkan: ${responseData['message']}');
      } else {
        throw Exception('Gagal menambahkan alamat: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // fungsi untuk mengedit alamat 
  static Future<void> editCustomerAddress({
    required String uid,
    required String addressDetail,
    required String addressNote,
    required String recipientName,
    required String recipientPhone,
  }) async {
    try {
      final apiKey = await UserStorage.getApiKey();
      final response = await http.put(
        Uri.parse('$baseUrl/$uid/EditAlamat'),
        headers: {
          'X-API-KEY': apiKey ?? '',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'alamat': addressDetail,
          'catatan': addressNote,
          'nama_penerima': recipientName,
          'telepon': recipientPhone,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print('Alamat berhasil diubah: ${responseData['message']}');
      } else {
        throw Exception('Gagal mengubah alamat: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Mengambil data addres berdasrkan dari API
  static Future<Map<String, dynamic>> getCustomerAddress(String uid) async {
  try {
    final apiKey = await UserStorage.getApiKey();
    final response = await http.get(
      Uri.parse('$baseUrl/$uid'),
      headers: {
        'X-API-KEY': apiKey ?? '',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      return responseData['data'];
    } else {
      throw Exception('Gagal memuat data alamat');
    }
  } catch (e) {
    throw Exception('Error: $e');
  }
}

}