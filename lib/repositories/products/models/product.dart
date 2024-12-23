class Product {
  final String name;
  final int price;
  final int id;

  Product({required this.name, required this.price, required this.id});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      price: json['price'],
    );
  }
}
