import 'package:flutter/material.dart';
import 'package:segarku/utils/constants/colors.dart';
import 'package:segarku/utils/constants/sizes.dart';
import 'package:segarku/utils/theme/custom_themes/text_theme.dart';
import 'package:segarku/utils/constants/icons.dart';
import 'package:segarku/utils/constants/text_strings.dart';
import 'package:get/get.dart';

class ConfirmationDialog extends StatelessWidget {
  final bool isDelivery;
  final ValueChanged<bool> onSave;

  const ConfirmationDialog({
    super.key,
    required this.isDelivery,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    final bool dark = context.isDarkMode;
    String selectedPaymentMethod = isDelivery ? 'delivery' : 'pickup';

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: SSizes.md,
        horizontal: SSizes.defaultMargin,
      ),
      child: StatefulBuilder(
        builder: (BuildContext context, StateSetter setModalState) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                STexts.changepurchaseType,
                style: dark
                    ? STextTheme.titleBaseBoldDark
                    : STextTheme.titleBaseBoldLight,
              ),
              const SizedBox(height: SSizes.md),

              // Row for Options
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Option Delivery
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setModalState(() {
                          selectedPaymentMethod = 'delivery';
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(SSizes.md),
                        decoration: BoxDecoration(
                          color: selectedPaymentMethod == 'delivery'
                              ? SColors.green100
                              : null,
                          border: Border.all(
                            color: selectedPaymentMethod == 'delivery'
                                ? SColors.green500
                                : SColors.softBlack50,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            const CircleAvatar(
                              radius: 20,
                              backgroundColor: SColors.green500,
                              child: Icon(
                                SIcons.delivery,
                                color: SColors.pureWhite,
                                size: SSizes.defaultIcon,
                              ),
                            ),
                            const SizedBox(width: SSizes.md),
                            Text(
                              STexts.delivery,
                              style: (dark
                                  ? STextTheme.titleBaseBoldDark
                                  : STextTheme.titleBaseBoldLight)
                                  .copyWith(fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: SSizes.md),

                  // Option Pick-Up
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setModalState(() {
                          selectedPaymentMethod = 'pickup';
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(SSizes.md),
                        decoration: BoxDecoration(
                          color: selectedPaymentMethod == 'pickup'
                              ? SColors.green100
                              : null,
                          border: Border.all(
                            color: selectedPaymentMethod == 'pickup'
                                ? SColors.green500
                                : SColors.softBlack50,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            const CircleAvatar(
                              radius: 20,
                              backgroundColor: SColors.green500,
                              child: Icon(
                                SIcons.pickUp,
                                color: SColors.pureWhite,
                                size: SSizes.defaultIcon,
                              ),
                            ),
                            const SizedBox(width: SSizes.md),
                            Text(
                              STexts.pickUp,
                              style: (dark
                                  ? STextTheme.titleBaseBoldDark
                                  : STextTheme.titleBaseBoldLight)
                                  .copyWith(fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: SSizes.md),

              // Button Save
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
                    final isDeliverySelected =
                        selectedPaymentMethod == 'delivery';
                    onSave(isDeliverySelected);
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    STexts.save,
                    style: dark
                        ? STextTheme.titleBaseBoldLight
                        : STextTheme.titleBaseBoldDark,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
