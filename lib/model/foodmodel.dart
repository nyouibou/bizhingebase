import 'dart:convert';

List<Product> productFromJson(String str) =>
    List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

class Product {
  int? id;
  String? productName;
  String? productDetails;
  String? image;
  String? price;
  String? wholesalePrice;
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

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        productName: json["product_name"],
        productDetails: json["product_details"],
        image: json["image"],
        price: json["price"],
        wholesalePrice: json["wholesale_price"],
        minimumOrderQuantity: json["minimum_order_quantity"],
        category: json["category"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_name": productName,
        "product_details": productDetails,
        "image": image,
        "price": price,
        "wholesale_price": wholesalePrice,
        "minimum_order_quantity": minimumOrderQuantity,
        "category": category,
      };
}
