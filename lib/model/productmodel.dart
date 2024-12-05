import 'dart:convert';

List<Product> productFromJson(String str) =>
    List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

class Product {
  int? id;
  String? productName;
  String? productDetails;
  String? image;
  double? price; // Store as double
  double? wholesalePrice; // Store as double
  int? minimumOrderQuantity;
  int? category;

  Product({
    this.id,
    this.productName,
    this.productDetails,
    this.image,
    this.price,
    this.wholesalePrice,
    this.minimumOrderQuantity,
    this.category,
  });

  /// Factory constructor to create a `Product` from JSON data
  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"] as int?,
        productName: json["product_name"] as String?,
        productDetails: json["product_details"] as String?,
        image: json["image"] as String?,
        price: _toDouble(json["price"]), // Safely convert to double
        wholesalePrice:
            _toDouble(json["wholesale_price"]), // Safely convert to double
        minimumOrderQuantity: json["minimum_order_quantity"] as int?,
        category: json["category"] as int?,
      );

  /// Converts the `Product` object back to JSON
  Map<String, dynamic> toJson() => {
        "id": id,
        "product_name": productName,
        "product_details": productDetails,
        "image": image,
        "price": price?.toString(), // Convert double to String for JSON
        "wholesale_price":
            wholesalePrice?.toString(), // Convert double to String for JSON
        "minimum_order_quantity": minimumOrderQuantity,
        "category": category,
      };

  /// Helper function to safely parse dynamic values into double
  static double? _toDouble(dynamic value) {
    if (value == null) return null;
    if (value is double) return value; // Already a double
    if (value is int) return value.toDouble(); // Convert int to double
    if (value is String)
      return double.tryParse(value); // Parse String to double
    return null; // Return null if the value cannot be converted
  }
}
