import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user/Model/food_model.dart';
import 'package:user/Providers/add_to_cart_provider.dart';
import 'package:user/color.dart';

class AddToCart extends StatefulWidget {
  final FoodModel product;
  const AddToCart({super.key, required this.product});

  @override
  State<AddToCart> createState() => _AddToCartState();
}

class _AddToCartState extends State<AddToCart> {
  int kuantitas = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        color: Color.fromARGB(255, 213, 213, 213),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 35),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 40,
            // decoration: BoxDecoration(
            //   borderRadius: BorderRadius.circular(20),
            //   border: Border.all(color: Colors.white, width: 2),
            // ),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey),
                  ),
                  child: IconButton(
                    onPressed: () {
                      if (kuantitas != 0) {
                        setState(() {
                          kuantitas--;
                        });
                      }
                    },
                    iconSize: 18,
                    icon: const Icon(
                      Icons.remove,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                Text(
                  kuantitas.toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
                const SizedBox(width: 5),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey),
                  ),
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        kuantitas++;
                      });
                    },
                    iconSize: 18,
                    icon: const Icon(
                      Icons.add,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                )
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              if (kuantitas > 0) {
                Provider.of<OrderItemProvider>(context, listen: false)
                    .addItem(widget.product, kuantitas);
                // if items is add then show this snackbar
                final snackBar = SnackBar(
                  content: Text(
                    '${widget.product.nama} berhasil ditambahkan',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.white,
                    ),
                  ),
                  duration: Duration(seconds: 1),
                  backgroundColor: primaryColor,
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            },
            child: Container(
              height: 55,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: const Text(
                "Tambah",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ),
          )
        ],
      ),
    );
  }
}
