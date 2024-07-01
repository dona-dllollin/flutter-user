import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user/Model/order_model.dart';
import 'package:user/Providers/add_to_cart_provider.dart';
import 'package:user/Screen/Cart/check_out.dart';
import 'package:user/Service/order_service.dart';
import 'package:user/color.dart';

class CartCoba extends StatefulWidget {
  const CartCoba({super.key});

  @override
  State<CartCoba> createState() => _CartCobaState();
}

class _CartCobaState extends State<CartCoba> {
  // final _namaPemesanController = TextEditingController();
  // final _noMejaController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final provider = OrderItemProvider.of(context);
    final finalList = provider.orderItems;
    producrQuantity(IconData icon, OrderItem index) {
      return GestureDetector(
        onTap: () {
          setState(() {
            icon == Icons.add
                ? provider.increaseQuantity(index)
                : provider.decreaseQuantity(index);
          });
        },
        child: Icon(
          icon,
          size: 20,
        ),
      );
    }

    return Scaffold(
      bottomSheet: CheckOutBox(),
      appBar: AppBar(
        title: Text('Keranjang'),
      ),
      body: Consumer<OrderItemProvider>(
        builder: (context, orderItemProvider, _) {
          return ListView.builder(
            itemCount: orderItemProvider.orderItems.length,
            itemBuilder: (context, index) {
              final orderItem = orderItemProvider.orderItems[index];
              return Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color.fromARGB(255, 255, 255, 255),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(
                                0.2), // Warna bayangan dengan opacity
                            spreadRadius: 5, // Jarak sebaran bayangan
                            blurRadius: 7, // Radius blur bayangan
                            offset: Offset(0, 3), // Posisi bayangan (x, y)
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        children: [
                          // Container(
                          //   height: 100,
                          //   width: 90,
                          //   decoration: BoxDecoration(
                          //     borderRadius: BorderRadius.circular(20),
                          //     color: kcontentColor,
                          //   ),
                          //   // padding: const EdgeInsets.all(20),
                          //   child: Image.asset(orderItem.gambar),
                          // ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                orderItem.nama,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              // Text(
                              //   order,
                              //   style: TextStyle(
                              //       fontWeight: FontWeight.bold,
                              //       fontSize: 14,
                              //       color: Colors.grey.shade400),
                              // ),
                              // const SizedBox(height: 10),
                              Text(
                                "Rp${orderItem.harga}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 35,
                    child: Column(
                      children: [
                        // for remove items
                        IconButton(
                          onPressed: () {
                            // for remove ites for cart
                            finalList.removeAt(index);
                            setState(() {});
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                            size: 20,
                          ),
                        ),
                        // for items quantity
                        // const SizedBox(height: 10),
                        Container(
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: kcontentColor,
                            border: Border.all(
                              color: Colors.grey.shade400,
                              width: 2,
                            ),
                          ),
                          child: Row(
                            children: [
                              const SizedBox(width: 10),
                              producrQuantity(Icons.add, orderItem),
                              const SizedBox(width: 10),
                              Text(
                                orderItem.quantity.toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(width: 10),
                              producrQuantity(Icons.remove, orderItem),
                              const SizedBox(width: 10),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     showDialog(
      //       context: context,
      //       builder: (BuildContext context) {
      //         return AlertDialog(
      //           title: Text('Submit Order'),
      //           content: Column(
      //             mainAxisSize: MainAxisSize.min,
      //             children: [
      //               TextField(
      //                 controller: _namaPemesanController,
      //                 decoration: InputDecoration(labelText: 'Nama Pemesan'),
      //               ),
      //               TextField(
      //                 controller: _noMejaController,
      //                 decoration: InputDecoration(labelText: 'No Meja'),
      //               ),
      //             ],
      //           ),
      //           actions: [
      //             TextButton(
      //               onPressed: () {
      //                 Navigator.of(context).pop();
      //               },
      //               child: Text('Batal'),
      //             ),
      //             TextButton(
      //               onPressed: () async {
      //                 final namaPemesan = _namaPemesanController.text;
      //                 final noMeja = _noMejaController.text;

      //                 if (namaPemesan.isNotEmpty) {
      //                   final orderItems = Provider.of<OrderItemProvider>(
      //                           context,
      //                           listen: false)
      //                       .orderItems;
      //                   final orderModel = OrderModel(
      //                     namaPemesan: namaPemesan,
      //                     noMeja: noMeja,
      //                     items: orderItems,
      //                   );

      //                   // Panggil service untuk submit order
      //                   final response =
      //                       await OrderService.submitOrder(orderModel);

      //                   if (response) {
      //                     Navigator.pop(context);
      //                     showDialog(
      //                         context: context,
      //                         builder: (context) => AlertDialog(
      //                               backgroundColor: primaryColor,
      //                               content: const Text(
      //                                 "Orderan anda berhasil ditambahkan",
      //                                 style: TextStyle(color: Colors.white),
      //                                 textAlign: TextAlign.center,
      //                               ),
      //                               actions: [
      //                                 IconButton(
      //                                     onPressed: () {
      //                                       Navigator.pop(context);
      //                                       Navigator.pop(context);
      //                                     },
      //                                     icon: const Icon(Icons.done,
      //                                         color: Colors.white))
      //                               ],
      //                             ));
      //                   } else {
      //                     Navigator.pop(context);
      //                     showDialog(
      //                       context: context,
      //                       builder: (BuildContext context) {
      //                         return AlertDialog(
      //                           title: Text('Error'),
      //                           content: Text('Gagal submit order gagal'),
      //                           actions: [
      //                             TextButton(
      //                               onPressed: () {
      //                                 Navigator.of(context).pop();
      //                               },
      //                               child: Text('OK'),
      //                             ),
      //                           ],
      //                         );
      //                       },
      //                     );
      //                   }
      //                 }
      //               },
      //               child: Text('Submit'),
      //             ),
      //           ],
      //         );
      //       },
      //     );
      //   },
      //   child: Icon(Icons.check),
      // ),
    );
  }
}
