import 'package:url_launcher/url_launcher.dart';

void launchWhatsApp() async {
  const phoneNumber = '6282178589928'; // Nomor telepon dengan kode negara (62 untuk Indonesia)
  const message = 'Halo, saya ingin bertanya tentang...'; // Pesan default

  final url = Uri.parse('https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}');

  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Tidak dapat membuka WhatsApp. Pastikan WhatsApp terinstal di perangkat Anda.';
  }
}