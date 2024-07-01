import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user/Model/food_model.dart';
import 'package:user/Model/order_model.dart';

class OrderItemProvider extends ChangeNotifier {
  List<OrderItem> _orderItems = [];

  List<OrderItem> get orderItems => _orderItems;

  void addItem(FoodModel food, int kuantitas) {
    // Cek apakah makanan sudah ada di dalam pesanan
    bool found = false;
    for (var orderItem in _orderItems) {
      if (orderItem.nama == food.nama) {
        orderItem.quantity += kuantitas;
        found = true;
        break;
      }
    }

    // Jika makanan belum ada di pesanan, tambahkan sebagai OrderItem baru
    if (!found) {
      _orderItems.add(OrderItem(
        nama: food.nama,
        harga: food.harga,
        quantity: kuantitas,
      ));
    }

    notifyListeners();
  }

  void removeItem(OrderItem orderItem) {
    _orderItems.remove(orderItem);
    notifyListeners();
  }

  void increaseQuantity(OrderItem orderItem) {
    orderItem.quantity++;
    notifyListeners();
  }

  void decreaseQuantity(OrderItem orderItem) {
    if (orderItem.quantity > 1) {
      orderItem.quantity--;
      notifyListeners();
    }
  }

  int get totalItems {
    int total = 0;
    _orderItems.forEach((item) {
      total += item.quantity;
    });
    return total;
  }

  totalPrice() {
    double myTotal = 0.0; // initial
    for (OrderItem element in _orderItems) {
      myTotal += element.harga * element.quantity;
    }
    return myTotal;
  }

  static OrderItemProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<OrderItemProvider>(
      context,
      listen: listen,
    );
  }
}
