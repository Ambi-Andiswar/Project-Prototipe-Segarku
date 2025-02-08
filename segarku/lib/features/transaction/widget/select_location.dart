import 'package:flutter/material.dart';
import 'package:segarku/features/transaction/controller/storage_address_local.dart';
import 'package:segarku/features/transaction/widget/dialog_select_location.dart';
import 'package:segarku/utils/constants/colors.dart';
import 'package:segarku/utils/constants/icons.dart';
import 'package:segarku/utils/constants/sizes.dart';
import 'package:segarku/utils/constants/text_strings.dart';
import 'package:segarku/utils/theme/custom_themes/text_theme.dart';
import 'package:segarku/utils/local_storage/user_storage.dart';
import 'package:segarku/features/personalizations/controller/user/user_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class SelectLocation extends StatefulWidget {
  const SelectLocation({super.key});

  @override
  _SelectLocationState createState() => _SelectLocationState();
}

class _SelectLocationState extends State<SelectLocation> {
  String _addressDetail = ""; 
  String _village = ""; 
  String _addressNote = ""; 
  String _userName = ""; 
  String _userPhone = ""; 

  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  static const String _villageKey = 'selected_village';

  @override
  void initState() {
    super.initState();
    _loadAddressData();
    _loadLocalAddressData();
  }

  Future<void> _loadLocalAddressData() async {
    final addressData = await AddressLocalStorage.getAddress();
    
    setState(() {
      _addressDetail = addressData['addressDetail'] ?? '';
      _village = addressData['village'] ?? '';
      _addressNote = addressData['addressNote'] ?? '';
      _userName = addressData['name'] ?? '';
      _userPhone = addressData['phone'] ?? '';
    });
  }

  Future<void> _loadAddressData() async {
    try {
      // Muat data pengguna
      final userData = await UserStorage.getUserData();
      
      // Muat data alamat
      final uid = await UserStorage.getUid();
      if (uid != null) {
        final addressData = await UserApiService.getCustomerAddress(uid);
        
        if (addressData['addresses'] != null && addressData['addresses'].isNotEmpty) {
          final address = addressData['addresses'][0];
          
          setState(() {
            _userName = address['nama_penerima'] ?? userData?['nama'] ?? '';
            _userPhone = address['telepon'] ?? userData?['telepon'] ?? '';
            _addressDetail = address['alamat'] ?? '';
            _addressNote = address['catatan'] ?? '';
            
            // Muat desa terpilih dari penyimpanan aman
            _loadSelectedVillage();
          });
        }
      }
    } catch (e) {
      print('Kesalahan memuat data alamat: $e');
    }
  }


  Future<void> _loadSelectedVillage() async {
    final village = await _storage.read(key: _villageKey);
    setState(() {
      _village = village ?? '';
    });
  }

  

  @override
  Widget build(BuildContext context) {
    final bool dark = context.isDarkMode;

    return GestureDetector(
      onTap: () async {
        final result = await showModalBottomSheet<Map<String, dynamic>>( // Ubah tipe data di sini
          context: context,
          isScrollControlled: true,
          backgroundColor: dark ? SColors.softBlack50 : SColors.pureWhite,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          builder: (BuildContext context) {
            return const AddressPopup();
          },
        );

        if (result != null) {
          setState(() {
            _addressDetail = result['addressdetail']?.toString() ?? _addressDetail;
            _village = result['village']?.toString() ?? _village;
            _addressNote = result['addressnote']?.toString() ?? _addressNote;
            _userName = result['name']?.toString() ?? _userName;
            _userPhone = result['phone']?.toString() ?? _userPhone;
          });
        }
      },
      child: Container(
        padding: const EdgeInsets.all(SSizes.defaultMargin),
        decoration: BoxDecoration(
          color: dark ? SColors.pureBlack : SColors.pureWhite,
          borderRadius: BorderRadius.circular(SSizes.borderRadiusmd2),
          border: Border.all(color: SColors.green500),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  SIcons.location,
                  color: SColors.green500,
                  size: SSizes.defaultIconsm,
                ),
                const SizedBox(width: SSizes.sm2),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        STexts.address,
                        style: dark
                            ? STextTheme.bodyCaptionRegularDark
                            : STextTheme.bodyCaptionRegularLight,
                      ),
                      const SizedBox(height: SSizes.sm2),
                      if (_addressDetail.isNotEmpty)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: '$_addressDetail,',
                                    style: dark
                                        ? STextTheme.bodyCaptionRegularDark
                                        : STextTheme.bodyCaptionRegularLight,
                                  ),
                                  if (_village.isNotEmpty) 
                                    TextSpan(
                                      text: ' Kel. $_village',
                                      style: dark
                                          ? STextTheme.bodyCaptionRegularDark
                                          : STextTheme.bodyCaptionRegularLight,
                                    ),
                                ],
                              ),
                            ),
                            if (_addressNote.isNotEmpty)
                              Text(
                                _addressNote,
                                style: dark
                                    ? STextTheme.bodyCaptionRegularDark
                                    : STextTheme.bodyCaptionRegularLight,
                              ),
                            const SizedBox(height: SSizes.md),
                            Row(
                              children: [
                                Text(
                                  _userName,
                                  style: dark
                                      ? STextTheme.titleCaptionBoldDark
                                      : STextTheme.titleCaptionBoldLight,
                                ),
                                const SizedBox(width: SSizes.sm2),
                                Text(
                                  '•',
                                  style: dark
                                      ? STextTheme.bodyCaptionRegularDark
                                      : STextTheme.bodyCaptionRegularLight,
                                ),
                                const SizedBox(width: SSizes.sm2),
                                Text(
                                  _userPhone,
                                  style: dark
                                      ? STextTheme.bodyCaptionRegularDark
                                      : STextTheme.bodyCaptionRegularLight,
                                ),
                                const Spacer(),
                                const Icon(
                                  SIcons.arrowRight,
                                  color: SColors.green500,
                                  size: SSizes.md2,
                                ),
                              ],
                            ),
                          ],
                        )
                      else
                        Text(
                          'Tambah Alamat',
                          style: dark
                              ? STextTheme.bodyCaptionRegularDark
                              : STextTheme.bodyCaptionRegularLight,
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}