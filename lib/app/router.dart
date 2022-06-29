import 'package:flutter/material.dart';

import '/ui/cart/cart_screen.dart';
import '/ui/catalogue/catalogue_screen.dart';

class AppRouter {
  // ignore: body_might_complete_normally_nullable
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case CartScreen.route:
        return MaterialPageRoute(builder: (_) => const CartScreen());
      case CatalogueScreen.route:
        return MaterialPageRoute(builder: (_) => const CatalogueScreen());
      default:
    }
  }
}
