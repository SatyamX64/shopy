import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/repos/cart_controller.dart';
import '../../cart/cart_screen.dart';

class NumberCart extends StatelessWidget {
  const NumberCart({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final noOfItems = context.select<DataController, int>((dc) => dc.noOfItems);
    return GestureDetector(
      onTap: () {
        if (noOfItems == 0) {
          return;
        }
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const CartScreen()),
        );
      },
      child: Stack(
        children: [
          const IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.black,
            ),
            onPressed: null,
          ),
          if (noOfItems > 0)
            Positioned(
              top: 2,
              child: Container(
                height: 18,
                width: 18,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.red),
                child: Text(
                  noOfItems.toString(),
                  style:
                      const TextStyle(fontWeight: FontWeight.bold, fontSize: 8),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

