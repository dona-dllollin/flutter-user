import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user/Model/order_model.dart';
import 'package:user/Providers/add_to_cart_provider.dart';
import 'package:user/Service/order_service.dart';
import 'package:user/color.dart';

class CheckOutBox extends StatefulWidget {
  const CheckOutBox({super.key});

  @override
  State<CheckOutBox> createState() => _CheckOutBoxState();
}

class _CheckOutBoxState extends State<CheckOutBox> {
  final _namaPemesanController = TextEditingController();
  final _noMejaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = OrderItemProvider.of(context);
    return Container(
      height: 155,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 198, 198, 198),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          bottomLeft: Radius.circular(30),
        ),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "total",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Text(
                "Rp${provider.totalPrice()}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              )
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                minimumSize: const Size(double.infinity, 55),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Masukkan Nama Pemesan'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            controller: _namaPemesanController,
                            decoration:
                                InputDecoration(labelText: 'Nama Pemesan'),
                          ),
                          TextField(
                            controller: _noMejaController,
                            decoration: InputDecoration(labelText: 'No Meja'),
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'Batal',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            style: TextButton.styleFrom(
                                backgroundColor: Colors.grey[400],
                                elevation: 2)),
                        TextButton(
                          onPressed: () async {
                            final namaPemesan = _namaPemesanController.text;
                            final noMeja = _noMejaController.text;

                            if (namaPemesan.isNotEmpty) {
                              final orderItems = Provider.of<OrderItemProvider>(
                                      context,
                                      listen: false)
                                  .orderItems;
                              final orderModel = OrderModel(
                                namaPemesan: namaPemesan,
                                noMeja: noMeja,
                                items: orderItems,
                              );

                              // Panggil service untuk submit order
                              final response =
                                  await OrderService.submitOrder(orderModel);

                              if (response) {
                                provider.orderItems.clear();
                                Navigator.pop(context);
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                          backgroundColor: primaryColor,
                                          content: const Text(
                                            "Orderan anda berhasil ditambahkan",
                                            style:
                                                TextStyle(color: Colors.white),
                                            textAlign: TextAlign.center,
                                          ),
                                          actions: [
                                            IconButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  Navigator.pop(context);
                                                },
                                                icon: const Icon(Icons.done,
                                                    color: Colors.white))
                                          ],
                                        ));
                              } else {
                                Navigator.pop(context);
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Error'),
                                      content: Text('Gagal submit order gagal'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('OK'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            }
                          },
                          child: Text(
                            'Order',
                            style: TextStyle(color: Colors.white),
                          ),
                          style: TextButton.styleFrom(
                              backgroundColor: primaryColor, elevation: 2),
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text(
                "Check Out",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ))
        ],
      ),
    );
  }
}
