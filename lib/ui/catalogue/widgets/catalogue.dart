import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/repos/cart_controller.dart';
import 'item_card.dart';

class Catalogue extends StatelessWidget {
  const Catalogue({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final inventory = context.select((DataController dc) => dc.inventory);
    return inventory == null
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : GridView.builder(
            padding: const EdgeInsets.all(3),
            physics: const BouncingScrollPhysics(),
            itemCount: inventory.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: 1.0,
                mainAxisSpacing: 1.0),
            itemBuilder: (_, index) => ItemCard(inventory[index]),
          );
  }
}
