import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/models/item.dart';
import '../../../data/repos/cart_controller.dart';

class CartCard extends StatelessWidget {
  const CartCard(
    this.item,
    this.quantity, {
    Key? key,
  }) : super(key: key);
  final Item item;
  final int quantity;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      height: 120,
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(6),
                bottomLeft: Radius.circular(6),
              ),
              child: Image.network(
                item.url,
              ),
            ),
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(
                height: 12,
              ),
              Text(
                item.name,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text(
                item.price.toString(),
                style: TextStyle(color: Colors.grey[700]),
              ),
              const Spacer(),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      context.read<DataController>().addItem(item);
                    },
                  ),
                  Text(
                    '  $quantity  ',
                    style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      context.read<DataController>().removeItem(item);
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
            ],
          ),
          const SizedBox(
            width: 16,
          ),
        ],
      ),
    );
  }
}
