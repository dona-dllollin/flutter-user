import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user/Screen/Detail/food_detail.dart';
import 'package:user/Service/food_service.dart';
import 'package:user/color.dart';
// import 'package:user/Model/food_model.dart';
// import 'package:user/Service/food_service.dart';
// import 'package:user/color.dart';

class FoodCard extends StatefulWidget {
  final String gambar;
  final String nama;
  final String harga;
  final String id;

  const FoodCard(
      {super.key,
      required this.id,
      required this.gambar,
      required this.nama,
      required this.harga});

  @override
  State<FoodCard> createState() => _FoodCardState();
}

class _FoodCardState extends State<FoodCard> {
  void _showFoodDetail() async {
    // Mengambil data makanan berdasarkan ID
    var foodData = await FoodService().getById(widget.id);

    // Navigasi ke halaman DetailFood dengan membawa data yang didapat
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FoodDetail(data: foodData),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      // height: 10000,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color.fromARGB(255, 225, 225, 225),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 15),
          Center(
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 224, 224, 224),
                  borderRadius: BorderRadius.circular(30)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.network(
                  'http://192.168.7.201:3000/${widget.gambar}',
                  height: 120,
                  width: 120,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      'images/logo.png',
                      height: 120,
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15),
                Text(widget.nama,
                    style: GoogleFonts.lato(
                        textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ))),
                Text(widget.harga,
                    style: GoogleFonts.lato(
                        textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ))),
                Center(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                      ),
                      onPressed: _showFoodDetail,
                      child: Text("Detail",
                          style: GoogleFonts.lato(
                            textStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  offset: Offset(1.0, 1.0), // Posisi bayangan
                                  blurRadius: 2.0, // Jarak blur bayangan
                                  color: Color.fromARGB(64, 0, 0,
                                      0), // Warna bayangan lebih terang
                                ),
                              ],
                            ),
                          ))),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
