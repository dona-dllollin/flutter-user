class FoodModel {
  final String id;
  final String nama;
  final int harga;
  final String gambar;
  final String deskripsi;
  final int jumlah;
  final List<String> kategori;

  FoodModel({
    required this.id,
    required this.nama,
    required this.harga,
    required this.gambar,
    required this.deskripsi,
    required this.jumlah,
    required this.kategori,
  });

  // Factory constructor untuk membuat instance dari JSON
  factory FoodModel.fromJson(Map<String, dynamic> json) {
    return FoodModel(
      id: json['_id'],
      nama: json['nama'] as String? ?? '',
      harga: (json['harga'] as num).toInt(), // Mengubah ke int
      gambar: json['gambar'] as String? ?? '',
      deskripsi: json['deskripsi'] as String? ?? '',
      jumlah: json['jumlah'] as int? ?? 0,
      kategori: List<String>.from(
          json['kategori']?.map((item) => item.toString()) ?? []),
    );
  }
}
