import 'package:flutter/material.dart';
import 'package:user/Model/category_model.dart';
import 'package:user/Model/food_model.dart';
import 'package:user/Screen/home/widget/food_cart.dart';
import 'package:user/Service/category_service.dart';
import 'package:user/Service/food_service.dart';
import 'package:user/cadangan/cart_icon.dart';
import 'package:user/color.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Category>> fetchedCategories;
  late Future<List<FoodModel>> fetchedFoods;
  String selectedCategoryId = 'semua';
  List<Category> categories = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    fetchedCategories = _fetchCategories();
    fetchedFoods = _fetchFoods(selectedCategoryId);
  }

  Future<List<Category>> _fetchCategories() async {
    // Mengambil kategori dari API
    List<Category> apiCategories = await CategoryService().getCategories();

    // Menambah kategori 'Semua' secara manual
    Category semuaCategory =
        Category(id: 'semua', nama: 'Semua', gambar: 'uploads/fire.jpg');
    return [semuaCategory, ...apiCategories];
  }

  Future<List<FoodModel>> _fetchFoods(String categoryId) async {
    // Mengambil makanan berdasarkan kategori
    if (categoryId == 'semua' || categoryId.isEmpty) {
      return await FoodService()
          .getFoods(); // Mengambil semua makanan jika kategori kosong
    } else {
      return await FoodService()
          .getByCategory(categoryId); // Mengambil makanan berdasarkan kategori
    }
  }

  void _onCategorySelected(String categoryId) {
    setState(() {
      selectedCategoryId = categoryId;
      fetchedFoods = _fetchFoods(
          selectedCategoryId); // Memuat ulang makanan berdasarkan kategori yang dipilih
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(150),
          child: AppBar(
            leading: Padding(
              padding: EdgeInsets.only(left: 15),
              child: Ink(
                decoration: ShapeDecoration(
                  color: const Color.fromARGB(255, 230, 230, 230),
                  shape: CircleBorder(),
                ),
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back_ios),
                  iconSize: 20,
                ),
              ),
            ),
            backgroundColor: primaryColor,
            title: Center(
              child: Text(
                'Halo Pelanggan!',
                style:
                    TextStyle(color: const Color.fromARGB(255, 255, 255, 255)),
              ),
            ),
            actions: [
              CartIconWithBadge(),
            ],
            flexibleSpace: Center(
              child: Container(
                margin: EdgeInsets.fromLTRB(50, 100, 50, 50),
                child: Text(
                  'Silahkan Pilih Menu',
                  style: TextStyle(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      fontSize: 30),
                ),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text(
                'Kategori',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              FutureBuilder(
                future: fetchedCategories,
                builder: (context, AsyncSnapshot<List<Category>> snapshot) {
                  if (snapshot.hasData) {
                    categories = snapshot.data!;
                    return SizedBox(
                        height: 40,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: categories.map((category) {
                            return GestureDetector(
                              onTap: () {
                                _onCategorySelected(category.id);
                              },
                              child: Container(
                                // padding: EdgeInsets.symmetric(
                                //     horizontal: 12, vertical: 8),
                                padding: EdgeInsets.only(right: 12),
                                margin: EdgeInsets.symmetric(
                                    horizontal: 4, vertical: 1),
                                decoration: BoxDecoration(
                                  color: (selectedCategoryId == category.id)
                                      ? Color.fromARGB(255, 242, 128, 40)
                                          .withOpacity(0.5)
                                      : const Color.fromARGB(
                                          255, 219, 219, 219),
                                  borderRadius: BorderRadius.circular(30),
                                  boxShadow: [
                                    BoxShadow(
                                      color: selectedCategoryId == category.id
                                          ? Color.fromARGB(255, 242, 128, 40)
                                              .withOpacity(0.5)
                                          : Color.fromARGB(0, 0, 0, 0),
                                      spreadRadius: 1,
                                      blurRadius: 5,
                                      offset: Offset(
                                        0,
                                        3,
                                      ), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CircleAvatar(
                                      radius: 20,
                                      backgroundColor:
                                          Color.fromARGB(255, 207, 207, 207),
                                      backgroundImage: NetworkImage(
                                          'http://192.168.7.201:3000/${category.gambar}'),
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      category.nama,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ));
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
              const SizedBox(height: 20),
              FutureBuilder(
                  future: fetchedFoods,
                  builder: ((context, snapshot) {
                    if (snapshot.hasData) {
                      final foods = snapshot.data!;
                      return GridView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20,
                          childAspectRatio:
                              0.60, // Default aspect ratio (width:height = 1:1)
                        ),
                        itemCount: foods.length,
                        itemBuilder: (context, index) {
                          final item = foods[index];
                          return FoodCard(
                            id: item.id,
                            gambar: item.gambar,
                            nama: item.nama,
                            harga: item.harga.toString(),
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  }))
            ]),
          ),
        ),
      ),
    );
  }
}
