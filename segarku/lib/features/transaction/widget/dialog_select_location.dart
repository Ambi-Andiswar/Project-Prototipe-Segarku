import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:segarku/features/transaction/controller/storage_address_local.dart';
import 'dart:convert';
import 'package:segarku/utils/constants/colors.dart';
import 'package:segarku/utils/constants/icons.dart';
import 'package:segarku/utils/constants/image_strings.dart';
import 'package:segarku/utils/constants/sizes.dart';
import 'package:segarku/utils/theme/custom_themes/text_theme.dart';
import 'package:segarku/utils/constants/text_strings.dart';
import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:segarku/features/personalizations/controller/user/user_service.dart';
import 'package:segarku/utils/local_storage/user_storage.dart';

class AddressPopup extends StatefulWidget {
  const AddressPopup({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AddressPopupState createState() => _AddressPopupState();
}

class _AddressPopupState extends State<AddressPopup> {
  final TextEditingController _addressDetailController = TextEditingController();
  final TextEditingController _addressNoteController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _villageController = TextEditingController();

  List<String> villageNames = [];
  String? selectedVillage;
  Map<String, dynamic>? userData;
  String? uid;
  bool isEditing = false;

  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  static const String _villageKey = 'selected_village';

  @override
  void initState() {
    super.initState();
    fetchVillages();
    _loadSelectedVillage();
    _loadUserData().then((_) {
      _loadAddressData();
    });
  }

  Future<void> _loadUserData() async {
    final data = await UserStorage.getUserData();
    final storageUid = await UserStorage.getUid();
    setState(() {
      userData = data;
      uid = storageUid;
      _nameController.text = data?['nama'] ?? '';
      _phoneController.text = data?['telepon'] ?? '';
    });
  }

  Future<void> _loadSelectedVillage() async {
    final village = await _storage.read(key: _villageKey);
    setState(() {
      selectedVillage = village;
      _villageController.text = village ?? '';
    });
  }

  Future<void> _saveSelectedVillage(String village) async {
    await _storage.write(key: _villageKey, value: village);
  }

  Future<void> fetchVillages() async {
    final response = await http.get(Uri.parse('https://emsifa.github.io/api-wilayah-indonesia/api/villages/1871071.json'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      setState(() {
        villageNames = data.map((village) => village['name'].toString()).toList();
      });
    } else {
      throw Exception('Gagal memuat data desa');
    }
  }

  Future<void> _loadAddressData() async {
    if (uid == null) return;

    try {
      final addressData = await UserApiService.getCustomerAddress(uid!);
      if (addressData['addresses'] != null && addressData['addresses'].isNotEmpty) {
        final address = addressData['addresses'][0];
        setState(() {
          _nameController.text = address['nama_penerima'] ?? '';
          _phoneController.text = address['telepon'] ?? '';
          _addressDetailController.text = address['alamat'] ?? '';
          _addressNoteController.text = address['catatan'] ?? '';
          isEditing = true;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal memuat data alamat: $e')),
      );
    }
  }

Future<void> _saveAddress({bool isEdit = false}) async {
  if (uid == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('User tidak terautentikasi')),
    );
    return;
  }

  if (selectedVillage == null || _addressDetailController.text.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Harap isi semua field yang diperlukan')),
    );
    return;
  }

  try {
    if (isEdit) {
      await UserApiService.editCustomerAddress(
        uid: uid!,
        addressDetail: _addressDetailController.text,
        addressNote: _addressNoteController.text,
        recipientName: _nameController.text,
        recipientPhone: _phoneController.text,
      );
    } else {
      await UserApiService.addCustomerAddress(
        uid: uid!,
        addressDetail: _addressDetailController.text,
        addressNote: _addressNoteController.text,
        recipientName: _nameController.text,
        recipientPhone: _phoneController.text,
      );
    }

    // Simpan data alamat ke penyimpanan lokal
    await _saveAddressToLocalStorage(
      addressDetail: _addressDetailController.text,
      village: selectedVillage!,
      addressNote: _addressNoteController.text,
      name: _nameController.text,
      phone: _phoneController.text,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Alamat berhasil disimpan')),
    );

    // Kirim data kembali ke SelectLocation dengan memastikan semua nilai adalah String
    Navigator.pop(context, {
      'addressdetail': _addressDetailController.text,
      'village': selectedVillage ?? '',  // Pastikan tidak null
      'addressnote': _addressNoteController.text,
      'name': _nameController.text,
      'phone': _phoneController.text,
    });
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Gagal menyimpan alamat: $e')),
    );
  }
}

  Future<void> _saveAddressToLocalStorage({
    required String addressDetail,
    required String village,
    required String addressNote,
    required String name,
    required String phone,
  }) async {
    await AddressLocalStorage.saveAddress(
      addressDetail: addressDetail,
      village: village,
      addressNote: addressNote,
      name: name,
      phone: phone,
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool dark = context.isDarkMode;

    return Container(
      color: dark ? SColors.pureBlack : SColors.pureWhite,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                STexts.selectLocation,
                style: dark ? STextTheme.titleMdBoldDark : STextTheme.titleMdBoldLight,
              ),
              const SizedBox(height: 16),
              Text(
                "* Layanan pengiriman hanya tersedia untuk daerah Kemiling.",
                style: STextTheme.bodyCaptionRegularDark.copyWith(
                  color: SColors.danger500
                ),
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () {
                  // Fungsi untuk memilih lokasi
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 150,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: const DecorationImage(
                          image: AssetImage(SImages.maps),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const Icon(Icons.location_on, color: SColors.green500, size: 40),
                  ],
                ),
              ),
              const SizedBox(height: SSizes.md2),
              _buildDropdownField("Pilih Kelurahan", _villageController, SIcons.location, dark),
              const SizedBox(height: SSizes.sm),
              _buildTextField("Detail Alamat", _addressDetailController, SIcons.home, dark),
              const SizedBox(height: SSizes.sm),
              _buildTextField("Catatan Alamat", _addressNoteController, SIcons.noteAddress, dark),
              const SizedBox(height: SSizes.sm),
              _buildTextField("Nama Penerima", _nameController, SIcons.profile, dark),
              const SizedBox(height: SSizes.sm),
              _buildNumberField("Nomor Telepon", _phoneController, SIcons.phone, dark),
              const SizedBox(height: SSizes.md),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _saveAddress(isEdit: isEditing),
                  child: Text(
                    STexts.done,
                    style: dark ? STextTheme.titleBaseBoldLight : STextTheme.titleBaseBoldDark,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownField(String label, TextEditingController controller, IconData icon, bool dark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: dark ? STextTheme.titleCaptionBoldDark : STextTheme.titleCaptionBoldLight,
        ),
        const SizedBox(height: SSizes.xs),
        DropdownButtonFormField<String>(
          value: selectedVillage,
          decoration: _inputDecoration(label, icon, dark),
          items: villageNames.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              selectedVillage = newValue;
              controller.text = newValue ?? '';
            });
          },
        ),
      ],
    );
  }

  Widget _buildNumberField(String label, TextEditingController controller, IconData icon, bool dark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: dark ? STextTheme.titleCaptionBoldDark : STextTheme.titleCaptionBoldLight,
        ),
        const SizedBox(height: SSizes.xs),
        TextFormField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: _inputDecoration(label, icon, dark),
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
        ),
      ],
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, IconData icon, bool dark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: dark ? STextTheme.titleCaptionBoldDark : STextTheme.titleCaptionBoldLight,
        ),
        const SizedBox(height: SSizes.xs),
        TextFormField(
          controller: controller,
          decoration: _inputDecoration(label, icon, dark),
        ),
      ],
    );
  }

  InputDecoration _inputDecoration(String label, IconData icon, bool dark) {
    return InputDecoration(
      contentPadding: const EdgeInsets.symmetric(horizontal: SSizes.md2, vertical: SSizes.md),
      prefixIcon: Padding(
        padding: const EdgeInsets.only(top: SSizes.md, bottom: SSizes.md, left: SSizes.md2, right: SSizes.sm2),
        child: Icon(
          icon,
          color: dark ? SColors.softBlack50 : SColors.softBlack300,
        ),
      ),
      labelText: label,
      labelStyle: dark ? STextTheme.bodyBaseRegularLight : STextTheme.bodyBaseRegularDark,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      hintText: label,
      hintStyle: dark ? STextTheme.bodyBaseRegularLight : STextTheme.bodyBaseRegularDark,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(SSizes.borderRadiussm),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(SSizes.borderRadiussm),
        borderSide: const BorderSide(color: SColors.softBlack50),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(SSizes.borderRadiussm),
        borderSide: const BorderSide(color: SColors.green500),
      ),
    );
  }
}