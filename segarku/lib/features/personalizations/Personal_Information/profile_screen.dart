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
import 'dart:convert';
import '../../../../../utils/constants/text_strings.dart';
import '../../../commons/widget/appbar/appbar.dart';

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

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
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
    });
  }

  Future<void> _updateProfile() async {
    if (apiKey == null || uid == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User not logged in')),
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

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile berhasil di perbarui!')),
        );

        // Navigate to profile or home screen
        Get.to(() => const NavigationMenu(initialIndex: 3));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(responseData['message'] ?? 'Update failed')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating profile: $e')),
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
                      ClipRRect(
                        borderRadius: BorderRadius.circular(SSizes.borderRadiusmd),
                        child: Image.asset(
                          SImages.profile, 
                          width: 72,
                          height: 72,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: SSizes.lg2),

                      // Change Photo Button
                      GestureDetector(
                        onTap: () {
                          // Tambahkan aksi untuk mengubah foto profil
                        },
                        child: const Text(
                          STexts.changePhotoProfile,
                          style: STextTheme.ctaSm,
                        ),
                      ),
                      const SizedBox(height: SSizes.xl),

                      // Input Fields dengan data user
                      InputFields.usernameProfileField(
                        context, 
                        dark, 
                        controller: _nameController
                      ),
                      const SizedBox(height: SSizes.md),
                      InputFields.editEmailField(
                        context, 
                        dark, 
                        controller: _emailController
                      ),
                      const SizedBox(height: SSizes.md),
                      InputFields.editNoPhoneField(
                        context, 
                        dark, 
                        controller: _phoneController
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