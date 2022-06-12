import 'dart:convert';

typedef Items = List<Item>;

class Item {
  final String name;
  final int price;
  final String url;

  Item({required this.url, required this.name, required this.price});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Item &&
        other.name == name &&
        other.price == price &&
        other.url == url;
  }

  @override
  int get hashCode => name.hashCode ^ price.hashCode ^ url.hashCode;

  @override
  String toString() => 'Product(name: $name, price: $price, url: $url)';

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'price': price,
      'url': url,
    };
  }

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      name: map['name'] as String,
      price: map['price'] as int,
      url: map['url'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Item.fromJson(String source) =>
      Item.fromMap(json.decode(source) as Map<String, dynamic>);

  Item copyWith({
    String? name,
    int? price,
    String? url,
  }) {
    return Item(
      name: name ?? this.name,
      price: price ?? this.price,
      url: url ?? this.url,
    );
  }
}
