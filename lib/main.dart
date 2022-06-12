import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shopy/data/repos/cart_controller.dart';
import 'package:shopy/data/source/data_source.dart';

import 'data/models/item.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DataController(DataSource()),
      child: MaterialApp(
        theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(),
        ),
        home: Scaffold(
          backgroundColor: const Color(0xFFF5F5F7),
          appBar: AppBar(
            elevation: 0.0,
            title: const Text(
              'Shopy',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w900),
            ),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            actions: const [
              NumberCart(),
            ],
          ),
          body: const Catalogue(),
        ),
      ),
    );
  }
}

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

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dc = context.watch<DataController>();
    final items = Items.from(dc.cart.keys);
    final quantity = List<int>.from(dc.cart.values);
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          'Cart',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Column(children: [
        Expanded(
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return CartCard(items[index], quantity[index]);
            },
          ),
        ),
        GestureDetector(
          onTap: () {
            if (items.isEmpty) {
              return;
            }
            dc.checkout();
            Fluttertoast.showToast(
                msg: "Payment Successful!",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0);
          },
          child: Container(
            height: 64,
            width: double.maxFinite,
            decoration: BoxDecoration(color: Colors.pink[400]),
            child: Center(
              child: Text(
                'Pay ${dc.amount}',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        )
      ]),
    );
  }
}

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
