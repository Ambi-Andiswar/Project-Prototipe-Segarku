import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:segarku/commons/widget/notification/widget/no_notification.dart';
import 'package:segarku/utils/constants/colors.dart';
import 'package:segarku/utils/constants/image_strings.dart';
import 'package:segarku/utils/constants/sizes.dart';
import 'package:segarku/utils/constants/icons.dart';
import 'package:segarku/utils/theme/custom_themes/text_theme.dart';

// Model untuk data notifikasi
class NotificationItem {
  final String title;
  final String subtitle;
  final String imageUrl;

  NotificationItem({
    required this.title,
    required this.subtitle,
    required this.imageUrl,
  });
}

// Daftar notifikasi
final List<NotificationItem> notifications = [
  NotificationItem(
    title: 'Waktunya belanja sayuran segar',
    subtitle: 'Ayo penuhi kebutuhan dapur anda dengan belanja sayuran dan buah-buahan segar di SegarKu.',
    imageUrl: SImages.slider1,
  ),
  NotificationItem(
    title: 'Diskon besar untuk sayuran',
    subtitle: 'Nikmati diskon hingga 50% untuk berbagai sayuran segar hanya di SegarKu.',
    imageUrl: SImages.slider2,
  ),
  NotificationItem(
    title: 'Promo buah segar',
    subtitle: 'Dapatkan buah-buahan segar dengan harga promo hanya hari ini!',
    imageUrl: SImages.slider3,
  ),
]; // Kosong untuk mengetes kondisi

class NotificationItemScreen extends StatelessWidget {
  const NotificationItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool dark = context.isDarkMode;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: SSizes.defaultMargin),
        child: notifications.isEmpty
            ? const NoNotificationScreen() // Jika data kosong, tampilkan NoNotificationScreen
            : ListView.builder(
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  final notification = notifications[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: SSizes.defaultMargin),
                    child: Container(
                      padding: const EdgeInsets.all(SSizes.defaultMargin),
                      decoration: BoxDecoration(
                        color: dark ? SColors.softBlack50 : SColors.pureWhite,
                        borderRadius: BorderRadius.circular(SSizes.borderRadiusmd2),
                        border: Border.all(
                          color: dark ? SColors.softBlack50 : SColors.green50,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Icon Notification
                              Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  color: SColors.green50,
                                  borderRadius: BorderRadius.circular(SSizes.borderRadiusmd),
                                ),
                                child: const Center(
                                  child: Icon(
                                    SIcons.notificationItem,
                                    size: 24,
                                    color: SColors.green500,
                                  ),
                                ),
                              ),
                              const SizedBox(width: SSizes.md),
                              // Title and Subtitle
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      notification.title,
                                      style: dark
                                          ? STextTheme.titleCaptionBoldDark
                                          : STextTheme.titleCaptionBoldLight,
                                    ),
                                    Text(
                                      notification.subtitle,
                                      style: dark
                                          ? STextTheme.bodySmRegularDark
                                          : STextTheme.bodySmRegularLight,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: SSizes.md),
                          // Image below
                          Container(
                            width: double.infinity,
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(SSizes.borderRadiusmd2),
                              image: DecorationImage(
                                image: AssetImage(notification.imageUrl),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}


