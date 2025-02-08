import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AddressLocalStorage {
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  // Key untuk penyimpanan
  static const String _addressDetailKey = 'addressDetail';
  static const String _villageKey = 'village';
  static const String _addressNoteKey = 'addressNote'; 
  static const String _nameKey = 'name';
  static const String _phoneKey = 'phone';

  // Menyimpan data alamat
  static Future<void> saveAddress({
    required String addressDetail,
    required String village,
    required String addressNote,
    required String name,
    required String phone,
  }) async {
    await _storage.write(key: _addressDetailKey, value: addressDetail);
    await _storage.write(key: _villageKey, value: village);
    await _storage.write(key: _addressNoteKey, value: addressNote);
    await _storage.write(key: _nameKey, value: name);
    await _storage.write(key: _phoneKey, value: phone);
  }

  // Mengambil data alamat
  static Future<Map<String, String>> getAddress() async {
    final addressDetail = await _storage.read(key: _addressDetailKey);
    final village = await _storage.read(key: _villageKey);
    final addressNote = await _storage.read(key: _addressNoteKey);
    final name = await _storage.read(key: _nameKey);
    final phone = await _storage.read(key: _phoneKey);

    // Pastikan semua nilai adalah String non-null
    return {
      'addressDetail': addressDetail ?? '',
      'village': village ?? '',
      'addressNote': addressNote ?? '',
      'name': name ?? '',
      'phone': phone ?? '',
    };
  }

  // Menghapus data alamat
  static Future<void> clearAddress() async {
    await _storage.delete(key: _addressDetailKey);
    await _storage.delete(key: _villageKey);
    await _storage.delete(key: _addressNoteKey);
    await _storage.delete(key: _nameKey);
    await _storage.delete(key: _phoneKey);
  }
}