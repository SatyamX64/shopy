import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:shopy/data/models/item.dart';

abstract class DataSource {
  factory DataSource() => _LocalDataSource();

  Future<Items> getItems();
}

class _LocalDataSource implements DataSource {
  @override
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
