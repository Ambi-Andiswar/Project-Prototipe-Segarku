import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:segarku/features/transaction/widget/locationpicker.dart';
import 'package:segarku/utils/constants/colors.dart';
import 'package:segarku/utils/constants/icons.dart';
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
  final TextEditingController _selectedAddressController = TextEditingController();
  final TextEditingController _addressDetail = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  List<String> villageNames = [];

  @override
  void initState() {
    super.initState();
    _selectedAddressController.text = "Silahkan pilih alamat Anda";
    fetchVillages();
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

  Future<void> _selectLocation(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LocationPicker(),
      ),
    );

    if (result != null && result is String) {
      setState(() {
        _selectedAddressController.text = result;
      });
    }
  }

  Widget _buildAutocompleteTextField(String label, TextEditingController controller, IconData icon, bool dark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: dark ? STextTheme.titleCaptionBoldDark : STextTheme.titleCaptionBoldLight,
        ),
        const SizedBox(height: SSizes.xs),
        Autocomplete<String>(
          optionsBuilder: (TextEditingValue textEditingValue) {
            if (textEditingValue.text.isEmpty) {
              return const Iterable<String>.empty();
            }
            return villageNames.where((String option) {
              return option.toLowerCase().contains(textEditingValue.text.toLowerCase());
            });
          },
          onSelected: (String selection) {
            controller.text = selection;
          },
          fieldViewBuilder: (BuildContext context, TextEditingController textEditingController, FocusNode focusNode, VoidCallback onFieldSubmitted) {
            return TextFormField(
              controller: textEditingController,
              focusNode: focusNode,
              decoration: InputDecoration(
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
              ),
            );
          },
        ),
      ],
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
              _buildAutocompleteTextField("Pilih Kelurahan", _selectedAddressController, SIcons.location, dark),
              const SizedBox(height: SSizes.sm),
              _buildAutocompleteTextField("Detail Alamat", _addressDetail, SIcons.home, dark),
              const SizedBox(height: SSizes.sm),
              _buildAutocompleteTextField("Nama Penerima", _nameController, SIcons.profile, dark),
              const SizedBox(height: SSizes.sm),
              _buildAutocompleteTextField("Nomor Telepon", _phoneController, SIcons.phone, dark),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop({
                      'address': _selectedAddressController.text,
                      'name': _nameController.text,
                      'phone': _phoneController.text,
                      'addressdetail': _addressDetail.text,
                    });
                  },
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
}
