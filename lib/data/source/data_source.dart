import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:shopy/data/models/item.dart';

class DataSource {
  Future<Items> getItems() async {
    final jsonStr = await rootBundle.loadString('assets/data.json');
    final itemsData = jsonDecode(jsonStr) as List;
    Items items = [];
    for (var item in itemsData) {
      items.add(
        Item.fromJson(
          jsonEncode(item),
        ),
      );
    }
    return items;
  }
}
