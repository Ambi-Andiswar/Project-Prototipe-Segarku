import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> registerCustomer({
  required String name,
  required String email,
  required String phone,
  required String password,
}) async {
  final Uri url = Uri.parse('https://www.admin-segarku.online/api/customers');

  try {
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'name': name,
        'email': email,
        'phone': phone,
        'password': password,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      // Jika request berhasil
      return {
        'success': true,
        'message': 'Registrasi berhasil!',
        'data': jsonDecode(response.body),
      };
    } else {
      // Jika request gagal
      return {
        'success': false,
        'message': 'Registrasi gagal: ${response.body}',
      };
    }
  } catch (e) {
    // Jika terjadi error
    return {
      'success': false,
      'message': 'Terjadi kesalahan: $e',
    };
  }
}