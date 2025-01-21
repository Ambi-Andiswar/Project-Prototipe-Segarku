import 'package:flutter/material.dart';
import 'package:segarku/features/transaction/widget/Locationpicker.dart';
import 'package:segarku/utils/constants/colors.dart';
import 'package:segarku/utils/constants/image_strings.dart';
import 'package:segarku/utils/constants/sizes.dart';
import 'package:segarku/utils/theme/custom_themes/text_theme.dart';
import 'package:segarku/utils/constants/text_strings.dart';
import 'package:get/get.dart';

class AddressPopup extends StatefulWidget {
  const AddressPopup({super.key});

  @override
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
        builder: (context) => LocationPicker(),
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

    return Padding(
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
                  borderSide: BorderSide(color: SColors.green500, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: SColors.softBlack50, width: 1),
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
                  borderSide: BorderSide(color: SColors.green500, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: SColors.softBlack50, width: 1),
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
                  borderSide: BorderSide(color: SColors.green500, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: SColors.softBlack50, width: 1),
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
                child: const Text(
                  STexts.done,
                  style: STextTheme.titleBaseBoldDark,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
