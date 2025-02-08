import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:segarku/utils/local_storage/user_storage.dart';

class AuthLoginMonggoDb {
  static const String baseUrl = "https://www.admin-segarku.online/api";

  // Fungsi untuk login
  static Future<Map<String, dynamic>> loginUser(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/customers/masuk'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final apiKey = responseData['api_key'];

        // Simpan API key dulu
        await UserStorage.saveLoginSession(apiKey: apiKey);

        // Ambil data user menggunakan API key yang baru didapat
        final userData = await fetchUserData(apiKey);
        
        if (userData['success']) {
          // Update storage dengan data user
          await UserStorage.updateUserData(userData['data']);
        }

        return {
          'success': true,
          'message': responseData['message'],
          'data': userData['data']
        };
      } else {
        return {
          'success': false,
          'message': 'Login gagal',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Terjadi kesalahan: $e',
      };
    }
  }

  // Fungsi untuk mengambil data user
  static Future<Map<String, dynamic>> fetchUserData(String apiKey) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/customers/profile'), // Sesuaikan dengan endpoint profile Anda
        headers: {
          'Authorization': 'Bearer $apiKey',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final userData = jsonDecode(response.body);
        return {
          'success': true,
          'data': userData,
        };
      } else {
        return {
          'success': false,
          'message': 'Gagal mengambil data user',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Terjadi kesalahan: $e',
      };
    }
  }
}