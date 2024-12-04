// To parse this JSON data, do
//
//     final catModelApiResp = catModelApiRespFromJson(jsonString);

// To parse the JSON data, we need to handle a list of categories
import 'dart:convert';

List<CatModelApiResp> catModelApiRespFromJson(String str) =>
    List<CatModelApiResp>.from(
        json.decode(str).map((x) => CatModelApiResp.fromJson(x)));

// If you only need to fetch a single category response
CatModelApiResp singleCatModelApiRespFromJson(String str) =>
    CatModelApiResp.fromJson(json.decode(str));

// If you need to convert the data back to JSON
String catModelApiRespToJson(List<CatModelApiResp> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CatModelApiResp {
  int? id;
  List<Product>? products;
  String? name;

  CatModelApiResp({
    this.id,
    this.products,
    this.name,
  });

  factory CatModelApiResp.fromJson(Map<String, dynamic> json) =>
      CatModelApiResp(
        id: json["id"],
        products: json["products"] == null
            ? []
            : List<Product>.from(
                json["products"]!.map((x) => Product.fromJson(x))),
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "products": products == null
            ? []
            : List<dynamic>.from(products!.map((x) => x.toJson())),
        "name": name,
      };
}

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
