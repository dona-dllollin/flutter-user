import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart'; // Import paket flutter_icons
import 'package:provider/provider.dart';
import 'package:user/Model/order_model.dart';
import 'package:your_app/models/food_model.dart'; // Sesuaikan dengan path model FoodModel
import 'package:your_app/providers/order_item_provider.dart'; // Sesuaikan dengan path provider OrderItemProvider

class FoodPage extends StatelessWidget {
  final FoodModel food;

  FoodPage({required this.food});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Makanan'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(food.nama),
            Text('Harga: ${food.harga}'),
            Text('Deskripsi: ${food.deskripsi}'),
            Consumer<OrderItemProvider>(
              builder: (context, orderItemProvider, _) {
                // Cari OrderItem yang sesuai dengan makanan ini
                OrderItem? orderItem = orderItemProvider.orderItems.firstWhere(
                  (item) => item.nama == food.nama,
                  orElse: () => OrderItem(
                      nama: food.nama, harga: food.harga, quantity: 0),
                );

                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        orderItemProvider.decreaseQuantity(orderItem);
                      },
                      icon: Icon(Icons.remove),
                    ),
                    Text(orderItem.quantity.toString()),
                    IconButton(
                      onPressed: () {
                        orderItemProvider.increaseQuantity(orderItem);
                      },
                      icon: Icon(Icons.add),
                    ),
                  ],
                );
              },
            ),
            ElevatedButton(
              onPressed: () {
                Provider.of<OrderItemProvider>(context, listen: false)
                    .addItem(food);
              },
              child: Text('Tambah'),
            ),
          ],
        ),
      ),
    );
  }
}
