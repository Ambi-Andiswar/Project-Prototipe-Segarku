import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:segarku/commons/widget/appbar/appbar.dart';
import 'package:segarku/features/personalizations/controller/user/user_service.dart';
import 'package:segarku/navigation_menu.dart';
import 'package:segarku/utils/constants/colors.dart';
import 'package:segarku/utils/constants/sizes.dart';
import 'package:segarku/utils/constants/text_strings.dart';
// import 'package:segarku/utils/constants/image_strings.dart';
import 'package:segarku/utils/local_storage/user_storage.dart';
import 'package:segarku/utils/theme/custom_themes/text_theme.dart';
import 'package:segarku/utils/constants/icons.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';

class MyAddressScreen extends StatefulWidget {
  const MyAddressScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyAddressScreenState createState() => _MyAddressScreenState();
}

class _MyAddressScreenState extends State<MyAddressScreen> {
  final TextEditingController _addressDetailController = TextEditingController();
  final TextEditingController _addressNodeController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _villageController = TextEditingController();

  List<String> villageNames = [];
  String? selectedVillage;

  Map<String, dynamic>? userData;
  String? uid;
  bool isEditing = false;
  bool isLoading = true;

  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  static const String _villageKey = 'selected_village';

  @override
  void initState() {
    super.initState();
    fetchVillages();
    _loadSelectedVillage();
    _loadUserData().then((_) {
      _loadAddressData(); // Load user data setelah data alamat dimuat
    });
  }

  // Memuat data pengguna
  Future<void> _loadUserData() async {
    setState(() {
      isLoading = true;
    });
    final data = await UserStorage.getUserData();
    final storageUid = await UserStorage.getUid();
    setState(() {
      userData = data;
      uid = storageUid;
      _nameController.text = data?['nama'] ?? '';
      _phoneController.text = data?['telepon'] ?? '';
      isLoading = false;
    });
  }

  // Memuat data kelurahan yang disimpan lokal
  Future<void> _loadSelectedVillage() async {
    final village = await _storage.read(key: _villageKey);
    setState(() {
      selectedVillage = village;
      _villageController.text = village ?? '';
    });
  }

  // Menyimpan data kelurahan ke penyimpanan lokal
  Future<void> _saveSelectedVillage(String village) async {
    await _storage.write(key: _villageKey, value: village);
  }

  // Mengambil data desa dari API
  Future<void> fetchVillages() async {
    final response = await http.get(Uri.parse(
        'https://emsifa.github.io/api-wilayah-indonesia/api/villages/1871081.json'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      setState(() {
        villageNames = data.map((village) => village['name'].toString()).toList();
        // Tambahkan desa Sidosari secara manual
        if (!villageNames.contains("SIDOSARI")) {
          villageNames.add("SIDOSARI");
        }
      });
    } else {
      throw Exception('Gagal memuat data desa');
    }
  }

  // Memuat data alamat dari API
  Future<void> _loadAddressData() async {
    if (uid == null) return;

    try {
      final addressData = await UserApiService.getCustomerAddress(uid!);
      if (addressData['addresses'] != null && addressData['addresses'].isNotEmpty) {
        final address = addressData['addresses'][0]; // Ambil alamat pertama
        setState(() {
          _nameController.text = address['nama_penerima'] ?? '';
          _phoneController.text = address['telepon'] ?? '';
          _addressDetailController.text = address['alamat'] ?? '';
          _addressNodeController.text = address['catatan'] ?? '';
          isEditing = true; // Set isEditing ke true karena data sudah ada
          isLoading = false;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal memuat data alamat: $e')),
      );
      setState(() {
        isLoading = false; // Set loading state ke false jika terjadi error
      });
    }
  }

  // Menyimpan atau mengedit alamat
  Future<void> _saveAddress({bool isEdit = false}) async {
    if (uid == null) {
      Get.snackbar(
        'Autentikasi Gagal',
        'User tidak terautentikasi',
        backgroundColor: SColors.danger500,
        colorText: SColors.pureWhite,
        icon: const Icon(Icons.error, color: Colors.white),
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    if (selectedVillage == null || _addressDetailController.text.isEmpty) {
      Get.snackbar(
        'Input Tidak Lengkap',
        'Harap isi semua field yang diperlukan',
        backgroundColor: SColors.danger500,
        colorText: SColors.pureWhite,
        icon: const Icon(Icons.warning, color: Colors.white),
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    try {
      if (isEdit) {
        await UserApiService.editCustomerAddress(
          uid: uid!,
          addressDetail: _addressDetailController.text,
          addressNote: _addressNodeController.text,
          recipientName: _nameController.text,
          recipientPhone: _phoneController.text,
        );
      } else {
        await UserApiService.addCustomerAddress(
          uid: uid!,
          addressDetail: _addressDetailController.text,
          addressNote: _addressNodeController.text,
          recipientName: _nameController.text,
          recipientPhone: _phoneController.text,
        );
      }

      // Simpan kelurahan yang dipilih ke penyimpanan lokal
      await _saveSelectedVillage(selectedVillage!);

      // Tampilkan SnackBar di posisi atas dengan style yang diinginkan
      Get.snackbar(
        'Sukses',
        'Alamat berhasil disimpan',
        backgroundColor: SColors.green500,
        colorText: SColors.pureWhite,
        icon: const Icon(Icons.check_circle, color: Colors.white),
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 2),
      );

      // Navigasi ke halaman NavigationMenu dengan initialIndex: 3
      Get.offAll(() => const NavigationMenu(initialIndex: 3));
    } catch (e) {
      // Tampilkan SnackBar error di posisi atas
      Get.snackbar(
        'Gagal',
        'Gagal menyimpan alamat: $e',
        backgroundColor: SColors.danger500,
        colorText: SColors.pureWhite,
        icon: const Icon(Icons.error, color: Colors.white),
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 2),
      );
    }
  }

    @override
  Widget build(BuildContext context) {
    final bool dark = context.isDarkMode;

    return Scaffold(
      body: Column(
        children: [
          Container(
            color: dark ? SColors.pureBlack : SColors.pureWhite,
            child: Column(
              children: [
                const SizedBox(height: 20),
                SCustomAppBar(
                  title: STexts.address,
                  darkMode: dark,
                ),
                const SizedBox(height: SSizes.md),
                Divider(
                  color: dark ? SColors.green50 : SColors.softBlack50,
                  thickness: 1,
                  height: 1,
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(SSizes.defaultMargin),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        isLoading
                            ? Shimmer.fromColors(
                                baseColor: dark ? Colors.grey[700]! : Colors.grey[300]!,
                                highlightColor: dark ? Colors.grey[600]! : Colors.grey[100]!,
                                child: Container(
                                  width: 150,
                                  height: 20,
                                  color: dark ? Colors.grey : Colors.grey,
                                ),
                              )
                            : Text(
                                STexts.selectLocation,
                                style: dark
                                    ? STextTheme.titleMdBoldDark
                                    : STextTheme.titleMdBoldLight,
                              ),
                        const SizedBox(height: 16),
                        isLoading
                            ? Shimmer.fromColors(
                                baseColor: dark ? Colors.grey[700]! : Colors.grey[300]!,
                                highlightColor: dark ? Colors.grey[600]! : Colors.grey[100]!,
                                child: Container(
                                  width: double.infinity,
                                  height: 16,
                                  color: dark ? Colors.grey : Colors.grey,
                                ),
                              )
                            : Text(
                                "* Layanan pengiriman hanya tersedia untuk daerah Sidosari & Kec. Rajabasa.",
                                style: STextTheme.bodyCaptionRegularDark.copyWith(
                                  color: SColors.danger500,
                                ),
                              ),
                        const SizedBox(height: SSizes.md2),
                        isLoading
                            ? Shimmer.fromColors(
                                baseColor: dark ? Colors.grey[700]! : Colors.grey[300]!,
                                highlightColor: dark ? Colors.grey[600]! : Colors.grey[100]!,
                                child: Container(
                                  width: double.infinity,
                                  height: 60,
                                  color: dark ? Colors.grey : Colors.grey,
                                ),
                              )
                            : _buildDropdownField(
                                "Pilih Kelurahan", _villageController, SIcons.location, dark),
                        const SizedBox(height: SSizes.sm),
                        isLoading
                            ? Shimmer.fromColors(
                                baseColor: dark ? Colors.grey[700]! : Colors.grey[300]!,
                                highlightColor: dark ? Colors.grey[600]! : Colors.grey[100]!,
                                child: Container(
                                  width: double.infinity,
                                  height: 60,
                                  color: dark ? Colors.grey : Colors.grey,
                                ),
                              )
                            : _buildTextField(
                                "Detail Alamat", _addressDetailController, SIcons.home, dark),
                        const SizedBox(height: SSizes.sm),
                        isLoading
                            ? Shimmer.fromColors(
                                baseColor: dark ? Colors.grey[700]! : Colors.grey[300]!,
                                highlightColor: dark ? Colors.grey[600]! : Colors.grey[100]!,
                                child: Container(
                                  width: double.infinity,
                                  height: 60,
                                  color: dark ? Colors.grey : Colors.grey,
                                ),
                              )
                            : _buildTextField(
                                "Catatan Alamat", _addressNodeController, SIcons.noteAddress, dark),
                        const SizedBox(height: SSizes.sm),
                        isLoading
                            ? Shimmer.fromColors(
                                baseColor: dark ? Colors.grey[700]! : Colors.grey[300]!,
                                highlightColor: dark ? Colors.grey[600]! : Colors.grey[100]!,
                                child: Container(
                                  width: double.infinity,
                                  height: 60,
                                  color: dark ? Colors.grey : Colors.grey,
                                ),
                              )
                            : _buildTextField(
                                "Nama Penerima", _nameController, SIcons.profile, dark),
                        const SizedBox(height: SSizes.sm),
                        isLoading
                            ? Shimmer.fromColors(
                                baseColor: dark ? Colors.grey[700]! : Colors.grey[300]!,
                                highlightColor: dark ? Colors.grey[600]! : Colors.grey[100]!,
                                child: Container(
                                  width: double.infinity,
                                  height: 60,
                                  color: dark ? Colors.grey : Colors.grey,
                                ),
                              )
                            : _buildNumberField(
                                "Nomor Telepon", _phoneController, SIcons.phone, dark),
                        const SizedBox(height: SSizes.md),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: isLoading ? null : () => _saveAddress(isEdit: isEditing), // Disable button saat loading
                      child: isLoading
                          ? Shimmer.fromColors(
                              baseColor: dark ? Colors.grey[700]! : Colors.grey[300]!,
                              highlightColor: dark ? Colors.grey[600]! : Colors.grey[100]!,
                              child: Container(
                                width: double.infinity,
                                height: 20,
                                color: dark ? Colors.grey : Colors.grey,
                              ),
                            )
                          : Text(
                              STexts.done,
                              style: dark
                                  ? STextTheme.titleBaseBoldLight
                                  : STextTheme.titleBaseBoldDark,
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
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
          decoration: _inputDecoration(label, icon, dark), // Tetap gunakan style field yang sudah ada
          items: villageNames.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16), // Jarak antara kanan dan kiri
                child: Text(
                  value,
                  style: const TextStyle(color: SColors.green500), // Warna teks dropdown item
                ),
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              selectedVillage = newValue;
              controller.text = newValue ?? '';
            });
          },
          style: const TextStyle(color: SColors.green500), // Warna teks dropdown yang dipilih
          dropdownColor: SColors.green50, // Warna background dropdown item
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