class SProduct {
  final String nama;
  final int harga;
  final int qty;
  final int maxQuantity; // Tambahkan ini
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
    required this.maxQuantity, // Tambahkan ini
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
      harga: int.tryParse(json['harga']?.toString() ?? '0') ?? 0,
      qty: int.tryParse(json['qty']?.toString() ?? '0') ?? 0,
      maxQuantity: int.tryParse(json['qty']?.toString() ?? '0') ?? 0, // Tambahkan ini
      categoryId: json['category_id'] ?? '',
      berat: json['berat'] ?? '0 gr/pack',
      deskripsi: json['deskripsi'] ?? '',
      image: json['image'] ?? 'https://image-segarku.s3.ap-southeast-2.amazonaws.com/products/Ao8e73xl5YWUIR0sbzwiJcqNhWwbmZ15j6RhXKLx.png',
      id: json['id'] ?? '',
      categoryName: _cleanCategoryName(json['category_name'] ?? ''),
      showPhoto: json['show_photo'] ?? '',
      category: json['category'] ?? {},
    );
  }

  SProduct copyWith({
    String? nama,
    int? harga,
    int? qty,
    int? maxQuantity, // Tambahkan ini
    String? categoryId,
    String? berat,
    String? deskripsi,
    String? image,
    String? id,
    String? categoryName,
    String? showPhoto,
    Map<String, dynamic>? category,
  }) {
    return SProduct(
      nama: nama ?? this.nama,
      harga: harga ?? this.harga,
      qty: qty ?? this.qty,
      maxQuantity: maxQuantity ?? this.maxQuantity, // Tambahkan ini
      categoryId: categoryId ?? this.categoryId,
      berat: berat ?? this.berat,
      deskripsi: deskripsi ?? this.deskripsi,
      image: image ?? this.image,
      id: id ?? this.id,
      categoryName: categoryName ?? this.categoryName,
      showPhoto: showPhoto ?? this.showPhoto,
      category: category ?? this.category,
    );
  }

  static String _cleanCategoryName(String categoryName) {
    return categoryName.replaceAll('&amp;', '&').trim();
  }
}