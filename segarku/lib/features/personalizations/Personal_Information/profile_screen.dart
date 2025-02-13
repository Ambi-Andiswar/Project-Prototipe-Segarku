import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:segarku/features/authentification/controller/login_google/login_google_mdb.dart';
import 'package:segarku/navigation_menu.dart';
import 'package:segarku/utils/constants/colors.dart';
import 'package:segarku/utils/constants/image_strings.dart';
import 'package:segarku/utils/constants/sizes.dart';
import 'package:segarku/utils/local_storage/user_storage.dart';
import 'package:segarku/utils/models/fields.dart';
import 'package:segarku/utils/theme/custom_themes/text_theme.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';
import 'dart:convert';
import '../../../../../utils/constants/text_strings.dart';
import '../../../commons/widget/appbar/appbar.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as path;

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  
  Map<String, dynamic>? userData;
  String? apiKey;
  String? uid;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    setState(() {
      isLoading = true; // Set loading state ke true saat mulai memuat data
    });

    final storageApiKey = await UserStorage.getApiKey();
    final storageUid = await UserStorage.getUid();

    if (storageApiKey != null && storageUid != null) {
      // Ambil data terbaru dari MongoDB
      final updatedUserData = await LoginGoogleMdb.getUserDataFromMongoDB(storageApiKey, storageUid);
      if (updatedUserData != null) {
        // Simpan data terbaru ke local storage
        await UserStorage.saveUserSession(
          apiKey: storageApiKey,
          uid: storageUid,
          userData: updatedUserData,
        );
      }
    }

    // Ambil data dari local storage
    final data = await UserStorage.getUserData();
    setState(() {
      userData = data;
      apiKey = storageApiKey;
      uid = storageUid;
      
      // Populate controllers dengan data terbaru
      _nameController.text = data?['nama'] ?? '';
      _emailController.text = data?['email'] ?? '';
      _phoneController.text = data?['telepon'] ?? '';
      isLoading = false;
    });
  }

  Future<void> _updateProfile() async {
    if (apiKey == null || uid == null) {
      Get.snackbar(
        'Belum bisa mengedit Profile',
        'Anda belum login dengan akun Anda',
        backgroundColor: SColors.danger500,
        colorText: SColors.pureWhite,
        icon: const Icon(Icons.error, color: Colors.white),
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    try {
      final response = await http.patch(
        Uri.parse('https://www.admin-segarku.online/api/customers/$uid'),
        headers: {
          'Content-Type': 'application/json',
          'X-API-KEY': apiKey!,
        },
        body: jsonEncode({
          'nama': _nameController.text,
          'email': _emailController.text,
          'telepon': _phoneController.text,
        }),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        // Update local storage
        await UserStorage.saveUserSession(
          apiKey: apiKey!,
          uid: uid!,
          userData: {
            ...userData!,
            'nama': _nameController.text,
            'email': _emailController.text,
            'telepon': _phoneController.text,
          },
        );

        Get.snackbar(
          'Success',
          'Profile berhasil di perbarui!',
          backgroundColor: SColors.green500,
          colorText: SColors.pureWhite,
          icon: const Icon(Icons.check_circle, color: Colors.white),
          snackPosition: SnackPosition.TOP,
        );

        // Navigate to profile or home screen
        Get.to(() => const NavigationMenu(initialIndex: 3));
      } else {
        Get.snackbar(
          'Gagal Mengupdate Profile',
          responseData['message'] ?? 'Update failed',
          backgroundColor: SColors.danger500,
          colorText: SColors.pureWhite,
          icon: const Icon(Icons.error, color: Colors.white),
          snackPosition: SnackPosition.TOP,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Gagal',
        'Belum bisa mengupdate Profile: $e',
        backgroundColor: SColors.danger500,
        colorText: SColors.pureWhite,
        icon: const Icon(Icons.error, color: Colors.white),
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  Future<void> _pickAndUploadPhoto() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile == null) return;

    File imageFile = File(pickedFile.path);
    int fileSize = await imageFile.length();
    
    if (fileSize > 10 * 1024 * 1024) { // Maksimal 10MB
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ukuran foto maksimal 10MB')),
      );
      return;
    }

    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('https://admin-segarku.online/api/customers/$uid/UploadPhotoProfil'),
      );
      request.headers['X-API-KEY'] = apiKey!;
      request.files.add(await http.MultipartFile.fromPath(
        'photo',
        imageFile.path,
        filename: path.basename(imageFile.path),
      ));

      var response = await request.send();

      if (response.statusCode == 200) {
        Get.snackbar(
          'Berhasil',
          'Foto profil berhasil diperbarui!',
          backgroundColor: SColors.green500,
          colorText: SColors.pureWhite,
          icon: const Icon(Icons.check_circle, color: Colors.white),
          snackPosition: SnackPosition.TOP,
        );
        _loadUserData(); // Refresh profil setelah upload
      } else {
        Get.snackbar(
          'Gagal',
          'Belum bisa mengupload foto profil',
          backgroundColor: SColors.danger500,
          colorText: SColors.pureWhite,
          icon: const Icon(Icons.error, color: Colors.white),
          snackPosition: SnackPosition.TOP,
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Terjadi kesalahan: $e')),
      );
    }
  }



  @override
  Widget build(BuildContext context) {
    final bool dark = context.isDarkMode;
    
    return Scaffold(
      resizeToAvoidBottomInset: true, 
      body: SafeArea(
        child: Column(
          children: [
            // AppBar
            Container(
              color: dark ? SColors.pureBlack : SColors.pureWhite,
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  SCustomAppBar(
                    title: STexts.editProfile,
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
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Profile Image
                      isLoading
                          ? Shimmer.fromColors(
                              baseColor: dark ? Colors.grey[700]! : Colors.grey[300]!,
                              highlightColor: dark ? Colors.grey[600]! : Colors.grey[100]!,
                              child: Container(
                                width: 72,
                                height: 72,
                                decoration: BoxDecoration(
                                  color: dark ? Colors.grey : Colors.grey,
                                  borderRadius: BorderRadius.circular(SSizes.borderRadiusmd),
                                ),
                              ),
                            )
                          : ClipRRect(
                        borderRadius: BorderRadius.circular(SSizes.borderRadiusmd),
                        child: userData?['photo'] != null && userData?['photo'].isNotEmpty
                            ? Image.network(
                                userData!['photo'], // Ambil URL foto dari userData
                                width: 72,
                                height: 72,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Image.asset(SImages.profile, width: 72, height: 72, fit: BoxFit.cover);
                                },
                              )
                            : Image.asset(SImages.profile, width: 72, height: 72, fit: BoxFit.cover),
                      ),
                      const SizedBox(height: SSizes.lg2),

                      // Change Photo Button
                      isLoading
                          ? Shimmer.fromColors(
                              baseColor: dark ? Colors.grey[700]! : Colors.grey[300]!,
                              highlightColor: dark ? Colors.grey[600]! : Colors.grey[100]!,
                              child: Container(
                                width: 100,
                                height: 20,
                                color: dark ? Colors.grey : Colors.grey,
                              ),
                            )
                          : GestureDetector(
                        onTap: _pickAndUploadPhoto,
                        child: const Text(
                          STexts.changePhotoProfile,
                          style: STextTheme.ctaSm,
                        ),
                      ),
                      const SizedBox(height: SSizes.xl),

                      // Input Fields dengan data user
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
                          : InputFields.usernameProfileField(
                        context, 
                        dark, 
                        controller: _nameController
                      ),
                      const SizedBox(height: SSizes.md),
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
                          : InputFields.editNoPhoneField(
                        context, 
                        dark, 
                        controller: _phoneController
                      ),
                      const SizedBox(height: SSizes.md),
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
                          : InputFields.editEmailField(
                        context, 
                        dark, 
                        controller: _emailController,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      // Button Selesai di bagian bawah page
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(
          left: SSizes.defaultMargin,
          top: SSizes.defaultMargin,
          right: SSizes.defaultMargin,
          bottom: SSizes.lg2,
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SizedBox(
              width: constraints.maxWidth,
              child: ElevatedButton(
                onPressed: _updateProfile,
                child: Text(
                  STexts.save,
                  style: dark
                    ? STextTheme.titleBaseBoldLight
                    : STextTheme.titleBaseBoldDark,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }
}