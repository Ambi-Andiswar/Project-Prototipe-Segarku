import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthControllerSignupMdb {
  Future<Map<String, dynamic>> registerUser(
      String email, String password, String nama, String telepon) async {
    const String apiUrl = 'https://www.admin-segarku.online/api/customers/registrasi';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'nama': nama,
          'email': email,
          'telepon': telepon,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return {'success': true, 'message': responseData['message']};
      } else {
        final errorData = jsonDecode(response.body);
        return {'success': false, 'message': errorData['message'] ?? 'Unknown error'};
      }
    } catch (e) {
      return {'success': false, 'message': 'Error occurred: $e'};
    }
  }
}
