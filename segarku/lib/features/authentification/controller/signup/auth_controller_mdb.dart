import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:segarku/utils/local_storage/user_storage.dart';

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

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = jsonDecode(response.body);

        // Jika registrasi berhasil, simpan data user
        if (responseData['status'] == 'success') {
          await UserStorage.saveUserSession(
            apiKey: responseData['api_key'],
            uid: responseData['data']['uid'],
            userData: responseData['data'],
          );
        }

        return {
          'success': responseData['status'] == 'success',
          'message': responseData['message']
        };
      } else {
        final errorData = jsonDecode(response.body);
        return {'success': false, 'message': errorData['message'] ?? 'Unknown error'};
      }
    } catch (e) {
      print('Error occurred: $e');
      return {'success': false, 'message': 'Error occurred: $e'};
    }
  }
}