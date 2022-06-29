import 'package:flutter/material.dart';

import 'widgets/catalogue.dart';
import 'widgets/number_cart.dart';

class CatalogueScreen extends StatelessWidget {
  static const route = '/catalogue';

  const CatalogueScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      appBar: AppBar(
        elevation: 0.0,
        title: const Text(
          'Shopy',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        actions: const [
          NumberCart(),
        ],
      ),
      body: const Catalogue(),
    );
  }
}
