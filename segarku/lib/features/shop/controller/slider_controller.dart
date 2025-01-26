// slider_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class SliderService {
  // Fungsi untuk mengambil data slider dari API
  Future<List<String>> fetchSliders() async {
    final response = await http.get(Uri.parse('https://www.admin-segarku.online/apiSliders'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> sliderData = data['data'];

      // Mengembalikan list URL gambar
      return sliderData.map<String>((slider) => slider['image_url'] as String).toList();
    } else {
      throw Exception('Failed to load sliders');
    }
  }
}