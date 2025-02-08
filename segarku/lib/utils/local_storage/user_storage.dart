import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserStorage {
  static const _storage = FlutterSecureStorage();
  
  // Keys untuk penyimpanan
  static const String apiKeyKey = 'api_key';
  static const String uidKey = 'uid';
  static const String userDataKey = 'user_data';

  // Menyimpan data session user untuk register
  static Future<void> saveUserSession({
    required String apiKey,
    required String uid,
    required Map<String, dynamic> userData,
  }) async {
    await _storage.write(key: apiKeyKey, value: apiKey);
    await _storage.write(key: uidKey, value: uid);
    await _storage.write(key: userDataKey, value: json.encode(userData));
  }

  // Menyimpan data session untuk login
  static Future<void> saveLoginSession({
    required String apiKey,
  }) async {
    await _storage.write(key: apiKeyKey, value: apiKey);
  }

  // Menyimpan/update data user
  static Future<void> updateUserData(Map<String, dynamic> userData) async {
    await _storage.write(key: userDataKey, value: json.encode(userData));
  }

  // Mengambil API Key
  static Future<String?> getApiKey() async {
    return await _storage.read(key: apiKeyKey);
  }

  // Mengambil UID
  static Future<String?> getUid() async {
    return await _storage.read(key: uidKey);
  }

  // Mengambil data user
  static Future<Map<String, dynamic>?> getUserData() async {
    final data = await _storage.read(key: userDataKey);
    if (data != null) {
      return json.decode(data);
    }
    return null;
  }

  // Menghapus semua data (untuk logout)
  static Future<void> clearAll() async {
    await _storage.deleteAll();
  }
}