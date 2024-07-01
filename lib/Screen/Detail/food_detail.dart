import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:user/Model/food_model.dart';
import 'package:user/Screen/Detail/add_to_cart.dart';
import 'package:user/Screen/Detail/detail_app_bar.dart';

class FoodDetail extends StatefulWidget {
  final FoodModel data; // Data yang diterima dari FoodService

  const FoodDetail({super.key, required this.data});

  @override
  State<FoodDetail> createState() => _FoodDetailState();
}

class _FoodDetailState extends State<FoodDetail> {
  int kuantitas = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: AddToCart(product: widget.data),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DetailAppBar(),
                Center(
                  child: Image.network(
                    'http://192.168.7.201:3000/${widget.data.gambar}',
                    height: 200,
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
                SizedBox(height: 25),
                Container(
                  color: Color.fromARGB(255, 139, 139, 139),
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                  height: 1,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(30, 15, 0, 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.data.nama,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Rp. ${widget.data.harga}',
                        style: TextStyle(
                          fontSize: 27,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Text(
                            'Kategori : ',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                          Wrap(
                            spacing: 8.0, // Spasi antara chip
                            children:
                                widget.data.kategori.map<Widget>((kategori) {
                              final nama = kategori
                                  .split(',')[1]
                                  .split(':')[1]
                                  .split('}')[0];
                              return Chip(
                                label: Text(nama.trim()),
                                backgroundColor:
                                    Color.fromARGB(255, 255, 255, 255),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  padding: EdgeInsets.all(8),
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start, // Tambahkan properti ini
                    children: [
                      Center(
                        child: Text(
                          'Deskripsi',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(widget.data.deskripsi,
                          style: TextStyle(fontSize: 16, color: Colors.grey)),
                    ],
                  ),
                ),
                SizedBox(
                  height: 100,
                )
              ],
            ),
          ),
        ));
  }
}
