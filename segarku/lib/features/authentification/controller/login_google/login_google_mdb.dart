import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:segarku/utils/local_storage/user_storage.dart';

class LoginGoogleMdb {
  static Future<Map<String, dynamic>?> postUserDataToMongoDB(String? idToken) async {
    if (idToken == null) {
      print('DEBUG: idToken is null');
      return null;
    }

    try {
      // Tambahkan delay singkat untuk menghindari double request
      await Future.delayed(Duration(milliseconds: 500));
      
      print('DEBUG: Mengirim request ke server...');
      final response = await http.post(
        Uri.parse('https://admin-segarku.online/api/customers/google'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'id_token': idToken.trim(),
        }),
      );

      print('DEBUG: Response status: ${response.statusCode}');
      print('DEBUG: Response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        
        // Verifikasi format data
        if (responseData['status'] == 'success' && 
            responseData['data'] != null && 
            responseData['api_key'] != null) {
          
          print('DEBUG: Data valid, menyimpan ke storage...');
          
          // Simpan data ke storage segera setelah mendapat response valid
          await UserStorage.saveUserSession(
            apiKey: responseData['api_key'],
            uid: responseData['data']['uid'],
            userData: responseData['data'],
          );
          
          // Verifikasi penyimpanan
          final savedData = await UserStorage.getUserData();
          print('DEBUG: Data tersimpan: $savedData');
          
          return responseData;
        } else {
          print('DEBUG: Format response tidak sesuai: $responseData');
          return null;
        }
      } else {
        print('DEBUG: Request gagal: ${response.body}');
        return null;
      }
    } catch (e) {
      print('DEBUG: Error saat posting ke MongoDB: $e');
      return null;
    }
  }

  static Future<Map<String, dynamic>?> getUserDataFromMongoDB(String apiKey, String uid) async {
    try {
      final response = await http.get(
        Uri.parse('https://admin-segarku.online/api/customers/$uid'),
        headers: {
          'Content-Type': 'application/json',
          'X-API-KEY': apiKey,
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['status'] == 'success' && responseData['data'] != null) {
          return responseData['data'];
        }
      }
    } catch (e) {
      print('DEBUG: Error fetching user data from MongoDB: $e');
    }
    return null;
  }
}