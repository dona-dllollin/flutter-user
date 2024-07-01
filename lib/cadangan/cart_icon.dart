import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user/Providers/add_to_cart_provider.dart';
import 'package:user/Screen/Cart/cart_screen.dart';
import 'package:user/cadangan/cart_contoh.dart';

class CartIconWithBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<OrderItemProvider>(
      builder: (context, orderProvider, child) {
        int totalItems = orderProvider.totalItems;
        return Padding(
          padding: const EdgeInsets.only(right: 15),
          child: Stack(
            children: [
              Ink(
                decoration: ShapeDecoration(
                  color: const Color.fromARGB(255, 230, 230, 230),
                  shape: CircleBorder(),
                ),
                child: IconButton(
                  icon: Icon(Icons.shopping_cart),
                  iconSize: 20,
                  onPressed: () {
                    // Navigate to cart page
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => CartCoba()));
                  },
                ),
              ),
              if (totalItems > 0)
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      '$totalItems',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
