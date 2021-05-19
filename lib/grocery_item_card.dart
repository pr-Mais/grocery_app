class GroceryItem {
  GroceryItem({
    this.img = 'assets/placeholder.jpg',
    required this.name,
    required this.price,
  });

  late final String img;
  late final String name;
  late final double price;

  factory GroceryItem.fromMap(Map<String, dynamic> map) {
    return GroceryItem(
      name: map['name'] as String,
      img: map['img'] as String,
      price: map['price'] is int? map['price'].toDouble() : map['price'],
    );
  }
}
