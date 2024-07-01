class Category {
  final String id;
  final String nama;
  final String gambar;

  Category({
    required this.id,
    required this.nama,
    required this.gambar,
  });

  // Factory constructor untuk membuat instance dari JSON
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['_id'] as String? ?? '',
      nama: json['nama'] as String? ?? '',
      gambar: json['gambar'] as String? ?? '',
    );
  }
}
