import 'package:flutter/material.dart';
import 'package:segarku/features/transaction/widget/locationpicker.dart';
import 'package:segarku/utils/constants/colors.dart';
import 'package:segarku/utils/constants/image_strings.dart';
import 'package:segarku/utils/constants/sizes.dart';
import 'package:segarku/utils/theme/custom_themes/text_theme.dart';
import 'package:segarku/utils/constants/text_strings.dart';
import 'package:get/get.dart';

class AddressPopup extends StatefulWidget {
  const AddressPopup({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AddressPopupState createState() => _AddressPopupState();
}

class _AddressPopupState extends State<AddressPopup> {
  String _selectedAddress = "Silahkan pilih alamat Anda";
  final TextEditingController _addressDetail = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  // Method untuk navigasi ke Google Maps Selector
  Future<void> _selectLocation(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LocationPicker(),
      ),
    );

    if (result != null && result is String) {
      setState(() {
        _selectedAddress = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool dark = context.isDarkMode;

    return Container(
      color: dark
        ? SColors.pureBlack
        : SColors.pureWhite,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 16.0,
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                STexts.selectLocation,
                style: dark
                    ? STextTheme.titleMdBoldDark
                    : STextTheme.titleMdBoldLight,
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () => _selectLocation(context),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 150,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: const DecorationImage(
                          image: AssetImage(SImages.maps), // Dummy Map Image
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const Icon(Icons.location_on, color: SColors.green500, size: 40),

                    Positioned(
                          bottom: 8,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: dark
                              ? SColors.pureBlack
                              : SColors.pureWhite,
                              borderRadius: BorderRadius.circular(32),
                              border: Border.all(color: SColors.green500),
                            ),
                            child: Row(
                              children: [
                                Image.asset(
                                  SImages.topRight,
                                  height: 12,
                                  color: dark 
                                    ? SColors.green500
                                    : SColors.softBlack500
                                ),
                                const SizedBox(width: SSizes.sm),
                                Text(
                                  STexts.selectLocation,
                                  style: dark
                                      ? STextTheme.titleCaptionBoldDark
                                      : STextTheme.titleCaptionBoldLight,
                                ),
                              ],
                            ),
                          ),
                        ),
                  ],
                ),
              ),
              const SizedBox(height: SSizes.md2),
              Text(
                "Alamat yang dipilih :",
                style: dark 
                ? STextTheme.titleBaseBoldDark
                : STextTheme.titleBaseBoldLight,
              ),
              const SizedBox(height: SSizes.sm),
              Text(_selectedAddress),
              const SizedBox(height: 16),
              TextField(
                controller: _addressDetail,
                decoration: InputDecoration(
                  labelText: "Detail Alamat",
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: SColors.green500, width: 2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: SColors.softBlack50, width: 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: SSizes.sm),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: "Nama Penerima",
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: SColors.green500, width: 2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: SColors.softBlack50, width: 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: SSizes.sm),
              TextField(
                keyboardType: TextInputType.phone,
                controller: _phoneController,
                decoration: InputDecoration(
                  labelText: "Nomor Telepon",
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: SColors.green500, width: 2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: SColors.softBlack50, width: 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop({
                      'address': _selectedAddress,
                      'name': _nameController.text,
                      'phone': _phoneController.text,
                      'addressdetail': _addressDetail.text,
                    });
                  },
                  child: Text(
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
    );
  }
}
