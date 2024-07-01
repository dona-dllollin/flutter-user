// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:user/Model/order_model.dart';
// import 'package:user/Providers/add_to_cart_provider.dart';
// import 'package:user/Service/order_service.dart';
// // Sesuaikan dengan path dari service order yang Anda buat

// class CartPage extends StatelessWidget {
//   const CartPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Cart'),
//       ),
//       body: Consumer<OrderItemProvider>(
//         builder: (context, orderItemProvider, _) {
//           return ListView.builder(
//             itemCount: orderItemProvider.orderItems.length,
//             itemBuilder: (context, index) {
//               final orderItem = orderItemProvider.orderItems[index];
//               return ListTile(
//                 title: Text(orderItem.nama),
//                 subtitle:
//                     Text('Harga: ${orderItem.harga} x ${orderItem.quantity}'),
//                 trailing: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     IconButton(
//                       icon: Icon(Icons.remove),
//                       onPressed: () {
//                         orderItemProvider.decreaseQuantity(orderItem);
//                       },
//                     ),
//                     IconButton(
//                       icon: Icon(Icons.add),
//                       onPressed: () {
//                         orderItemProvider.increaseQuantity(orderItem);
//                       },
//                     ),
//                   ],
//                 ),
//               );
//             },
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           showDialog(
//             context: context,
//             builder: (BuildContext context) {
//               return SubmitOrderDialog();
//             },
//           );
//         },
//         child: Icon(Icons.check),
//       ),
//     );
//   }
// }

// class SubmitOrderDialog extends StatefulWidget {
//   @override
//   _SubmitOrderDialogState createState() => _SubmitOrderDialogState();
// }

// class _SubmitOrderDialogState extends State<SubmitOrderDialog> {
//   final _namaPemesanController = TextEditingController();
//   final _noMejaController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: Text('Submit Order'),
//       content: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           TextField(
//             controller: _namaPemesanController,
//             decoration: InputDecoration(labelText: 'Nama Pemesan'),
//           ),
//           TextField(
//             controller: _noMejaController,
//             decoration: InputDecoration(labelText: 'No Meja'),
//           ),
//         ],
//       ),
//       actions: [
//         TextButton(
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//           child: Text('Batal'),
//         ),
//         TextButton(
//           onPressed: () async {
//             final namaPemesan = _namaPemesanController.text;
//             final noMeja = _noMejaController.text;

//             if (namaPemesan.isNotEmpty && noMeja.isNotEmpty) {
//               final orderItems =
//                   Provider.of<OrderItemProvider>(context, listen: false)
//                       .orderItems;
//               final orderModel = OrderModel(
//                 namaPemesan: namaPemesan,
//                 noMeja: noMeja,
//                 items: orderItems,
//               );

//               // Panggil service untuk submit order
//               final response = await OrderService.submitOrder(orderModel);

//               // Tangani response di sini (misal: tampilkan pesan sukses atau error)
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(
//                   content: Text(response
//                       ? 'Order berhasil disubmit'
//                       : 'Gagal submit order'),
//                 ),
//               );

//               Navigator.of(context).pop();
//             }
//           },
//           child: Text('Submit'),
//         ),
//       ],
//     );
//   }
// }
