class SProduct {
  final String nama;
  final String harga;
  final String qty;
  final String categoryId;
  final String berat;
  final String deskripsi;
  final String image;
  final String id;
  final String categoryName;
  final String showPhoto;
  final Map<String, dynamic> category;

  SProduct({
    required this.nama,
    required this.harga,
    required this.qty,
    required this.categoryId,
    required this.berat,
    required this.deskripsi,
    required this.image,
    required this.id,
    required this.categoryName,
    required this.showPhoto,
    required this.category,
  });

  factory SProduct.fromJson(Map<String, dynamic> json) {
    return SProduct(
      nama: json['nama'] ?? 'Produk',
      harga: json['harga'] ?? 'Rp.0',
      qty: json['qty'] ?? '0',
      categoryId: json['category_id'] ?? '',
      berat: json['berat'] ?? '0 gr/pack',
      deskripsi: json['deskripsi'] ?? '',
      image: json['image'] ?? 'https://image-segarku.s3.ap-southeast-2.amazonaws.com/products/Ao8e73xl5YWUIR0sbzwiJcqNhWwbmZ15j6RhXKLx.png',
      id: json['id'] ?? '',
      categoryName: _cleanCategoryName(json['category_name'] ?? ''), // Bersihkan category_name
      showPhoto: json['show_photo'] ?? '',
      category: json['category'] ?? {},
    );
  }

  // Method untuk membersihkan category_name
  static String _cleanCategoryName(String categoryName) {
    return categoryName.replaceAll('&amp;', '&').trim();
  }
}