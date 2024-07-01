import 'package:flutter/material.dart';
import 'package:user/Model/food_model.dart';
import 'package:user/Screen/home/widget/food_cart.dart';
import 'package:user/Service/food_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<FoodModel>> fetchedFoods = FoodService().getFoods();

  @override
  void initState() {
    super.initState();
    fetchedFoods = FoodService().getFoods();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // CategoryButton(icon: Icons.whatshot, label: 'Semua'),
                  // CategoryButton(icon: Icons.fastfood, label: 'Makanan'),
                ],
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
                              0.70, // Default aspect ratio (width:height = 1:1)
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
