import 'package:flutter/material.dart';
import 'package:user/cadangan/cart_icon.dart';

class DetailAppBar extends StatefulWidget {
  const DetailAppBar({super.key});

  @override
  State<DetailAppBar> createState() => _DetailAppBarState();
}

class _DetailAppBarState extends State<DetailAppBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
      child: Row(
        children: [
          IconButton(
            style: IconButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 230, 230, 230),
              padding: const EdgeInsets.all(15),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios),
            iconSize: 20,
          ),
          const Spacer(),
          // IconButton(
          //   style: IconButton.styleFrom(
          //     backgroundColor: Colors.white,
          //     padding: const EdgeInsets.all(15),
          //   ),
          //   onPressed: () {},
          //   icon: const Icon(Icons.share_outlined),
          // ),
          CartIconWithBadge()
        ],
      ),
    );
  }
}
