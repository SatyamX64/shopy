import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../data/models/item.dart';
import '../../data/repos/cart_controller.dart';
import 'widgets/cart_card.dart';

class CartScreen extends StatelessWidget {
  static const route = '/cart';
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
