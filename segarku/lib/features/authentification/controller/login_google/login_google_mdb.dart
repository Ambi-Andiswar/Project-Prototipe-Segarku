import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginGoogleMdb {
  static Future<void> postUserDataToMongoDB(String? idToken) async {
    if (idToken == null) {
      print("ID Token tidak ditemukan!");
      return;
    }

    const String apiUrl = 'https://admin-segarku.online/api/customers/google';
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'id_token': idToken}), // Kirim ID Token ke API
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("User data berhasil disimpan di MongoDB!");
      } else {
        print("Gagal menyimpan data user di MongoDB: ${response.body}");
      }
    } catch (e) {
      print("Error saat mengirim data ke MongoDB: $e");
    }
  }
}
