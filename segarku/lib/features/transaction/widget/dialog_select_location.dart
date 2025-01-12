import 'package:flutter/material.dart';
import 'package:segarku/utils/constants/colors.dart';
import 'package:segarku/utils/constants/image_strings.dart';
import 'package:segarku/utils/constants/sizes.dart';
import 'package:segarku/utils/models/fields.dart';
import 'package:segarku/utils/models/fields_search.dart';
import 'package:segarku/utils/theme/custom_themes/text_theme.dart';
import 'package:segarku/utils/constants/text_strings.dart';
import 'package:get/get.dart';

class AddressPopup extends StatelessWidget {
  const AddressPopup({super.key});

  @override
  Widget build(BuildContext context) {
    final bool dark = context.isDarkMode;

    // Controllers untuk input

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: SSizes.md,
        horizontal: SSizes.defaultMargin,
      ),
      child: StatefulBuilder(
        builder: (BuildContext context, StateSetter setModalState) {
          return SingleChildScrollView(
            // Tambahkan padding agar menghindari keyboard
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Judul Popup
                Text(
                  STexts.selectLocation,
                  style: dark
                      ? STextTheme.titleBaseBoldDark
                      : STextTheme.titleBaseBoldLight,
                ),
                const SizedBox(height: SSizes.md),

                // Input Field: Alamat
                InputFieldSearch.fieldSearchAddress(context, dark),
                const SizedBox(height: SSizes.md),

                Divider(
                  color: dark
                      ? SColors.green50
                      : SColors.softBlack50,
                  thickness: 1.0,
                ),
                const SizedBox(height: SSizes.md),

                // Gambar Peta dengan Stack
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: const DecorationImage(
                          image: AssetImage(SImages.maps),
                          fit: BoxFit.cover,
                        ),
                      ),
                      height: 150,
                      width: double.infinity,
                    ),
                    Positioned(
                      bottom: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: SColors.pureWhite,
                          borderRadius: BorderRadius.circular(32),
                          border: Border.all(color: SColors.green500),
                        ),
                        child: Row(
                          children: [
                            Image.asset(
                              SImages.topRight,
                              height: 12,
                            ),
                            const SizedBox(width: 8),
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
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Center(
                        child: Image.asset(
                          SImages.iconMaps,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: SSizes.md),

                InputFields.addressField(context, dark),
                const SizedBox(height: SSizes.md),

                InputFields.addressRecordsField(context, dark),
                const SizedBox(height: SSizes.md),

                InputFields.recipientNameField(context, dark),
                const SizedBox(height: SSizes.md),

                InputFields.noHandphoneAddressField(context, dark),
                const SizedBox(height: SSizes.md),

                // Tombol Simpan
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: SColors.green500,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {

                      // Lakukan aksi dengan data input
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Simpan',
                      style: dark
                          ? STextTheme.titleBaseBoldLight
                          : STextTheme.titleBaseBoldDark,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
