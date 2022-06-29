
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/models/item.dart';
import '../../../data/repos/cart_controller.dart';

class ItemCard extends StatelessWidget {
  const ItemCard(this.item, {Key? key}) : super(key: key);
  final Item item;
  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      color: Colors.white,
      elevation: 1.0,
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              color: Colors.grey[400],
              child: Image.network(
                item.url,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              child: ListTile(
                title: Text(item.name),
                subtitle: Text(item.price.toString()),
                trailing: IconButton(
                  icon: const Icon(Icons.shopping_cart_checkout),
                  onPressed: () {
                    context.read<DataController>().addItem(item);
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}


