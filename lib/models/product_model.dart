import 'dart:convert';

class ProductModel {
  final String id;
  final String title;
  final String imageUrl;
  final double price;
  final String category;
  int quantity;

   ProductModel({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.price,
    required this.category,
    this.quantity = 0,
  });

  // Create a copy of this product with given parameters
  ProductModel copyWith({
    String? id,
    String? title,
    String? imageUrl,
    double? price,
    String? category,
    int? quantity,
  }) {
    return ProductModel(
      id: id ?? this.id,
      title: title ?? this.title,
      imageUrl: imageUrl ?? this.imageUrl,
      price: price ?? this.price,
      category: category ?? this.category,
      quantity: quantity ?? this.quantity,
    );
  }

  // Convert a Product into a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'imageUrl': imageUrl,
      'price': price,
      'category': category,
      'quantity': quantity,
    };
  }

  // Convert a Map into a Product
  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      price: (map['price'] ?? 0.0).toDouble(),
      category: map['category'] ?? '',
      quantity: map['quantity']?.toInt() ?? 0,
    );
  }

  // Convert a Product to JSON
  String toJson() => json.encode(toMap());

  // Create a Product from JSON
  factory ProductModel.fromJson(String source) => ProductModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ProductModel(id: $id, title: $title, imageUrl: $imageUrl, price: $price, category: $category, quantity: $quantity)';
  }
}