import 'dart:convert';

import 'package:grocery_app/features/product/domain/entities/product_entities.dart';

class CartItem extends ProductEntities {
  const CartItem({
    required super.proID,
    required super.proImage,
    required super.proName,
    required super.brandName,
    required super.description,
    required super.price,
    required super.upc,
    required super.createdDate,
  });

  // ---------------------------------------------------------------------------
  // JSON
  // ---------------------------------------------------------------------------

  factory CartItem.fromRawJson(String str) => CartItem.fromMap(
        json.decode(str),
      );

  String toRawJson() => json.encode(toJson());

  // ---------------------------------------------------------------------------
  // Maps
  // ---------------------------------------------------------------------------

  factory CartItem.fromMap(Map<String, dynamic> json) {
    return CartItem(
      proID: json['id'],
      upc: json['upc'],
      proName: json['foodName'],
      brandName: json['breandName'],
      proImage: json['image'],
      description: json['description'],
      price: json['price'],
      createdDate: json['createdDate'],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": proID,
        "upc": upc,
        "foodName": proName,
        "breandName": brandName,
        "image": proImage,
        "description": description,
        "price": price,
        "createdDate": createdDate,
      };
}
