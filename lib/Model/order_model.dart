class OrderItem {
  final String nama;
  final int harga;
  int quantity;

  OrderItem({required this.nama, required this.harga, required this.quantity});

  // Konversi instance OrderItem menjadi format JSON
  Map<String, dynamic> toJson() {
    return {
      'nama': nama,
      'harga': harga,
      'quantity': quantity,
    };
  }

  // Factory constructor untuk membuat instance dari JSON
  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
        nama: json['nama'] as String? ?? '',
        harga: json['harga'] as int? ?? 0,
        quantity: json['items'] as int? ?? 0);
  }
}

class OrderModel {
  final String namaPemesan;
  final String noMeja;
  List<OrderItem> items;

  OrderModel(
      {required this.namaPemesan, required this.noMeja, required this.items});

  // Konversi instance OrderModel menjadi format JSON
  Map<String, dynamic> toJson() {
    return {
      'namaPemesan': namaPemesan,
      'noMeja': noMeja,
      'items': items.map((item) => item.toJson()).toList(),
    };
  }

  // Factory constructor untuk membuat instance dari JSON
  factory OrderModel.fromJson(Map<String, dynamic> json) {
    // Mendapatkan list item dari JSON
    List<dynamic> itemsJson = json['items'];

    // Mapping itemsJson menjadi List<OrderItem>
    List<OrderItem> items =
        itemsJson.map((itemJson) => OrderItem.fromJson(itemJson)).toList();
    return OrderModel(
        namaPemesan: json['namaPemesan'] as String? ?? '',
        noMeja: json['harga'] as String? ?? '',
        items: items);
  }
}
