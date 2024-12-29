class ProductGrid {
  final String name;
  final int price;
  final int id;
  final int? discount;

  final String? imageUrl;
  final String? description;

  num priceWithDiscount() {
    return price - (price * (discount ?? 0) / 100);
  }

  ProductGrid({
    required this.name,
    required this.price,
    required this.id,
    this.discount,
    this.imageUrl,
    this.description,
  });

  factory ProductGrid.fromJson(Map<String, dynamic> json) {
    return ProductGrid(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      discount: json['discount_percent'],
      imageUrl: json['image_url'],
      description: json['description'],
    );
  }
}
