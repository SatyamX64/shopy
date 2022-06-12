import 'package:flutter/cupertino.dart';
import 'package:shopy/data/models/item.dart';
import 'package:shopy/data/source/data_source.dart';

class DataController extends ChangeNotifier {
  List<Item>? inventory;
  Map<Item, int> cart = {};

  final DataSource source;

  DataController(this.source) {
    loadItems();
  }

  Future<void> loadItems() async {
    await Future.delayed(const Duration(seconds: 3));
    inventory = await source.getItems();
    notifyListeners();
  }

  int get noOfItems {
    return cart.entries.fold(0, (sum, entry) => sum + entry.value);
  }

  int get amount {
    return cart.entries
        .fold(0, (sum, entry) => sum + entry.key.price * entry.value);
  }

  void addItem(Item item) {
    if (cart.containsKey(item)) {
      cart[item] = cart[item]! + 1;
    } else {
      cart[item] = 1;
    }
    notifyListeners();
  }

  void checkout() {
    cart = {};
    notifyListeners();
  }

  void removeItem(Item item) {
    if (cart.containsKey(item)) {
      if (cart[item] == 1) {
        cart.remove(item);
      } else {
        cart[item] = cart[item]! - 1;
      }
      notifyListeners();
    } else {
      throw Exception('Product does not exist');
    }
  }
}
