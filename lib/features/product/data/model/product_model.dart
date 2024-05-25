import 'package:grocery_app/features/product/domain/entities/product_entities.dart';
import 'dart:convert';

class ProductModel extends ProductEntities {
  const ProductModel({
    required super.proID,
    required super.upc,
    required super.proName,
    required super.proImage,
    required super.brandName,
    required super.description,
    required super.price,
    required super.createdDate,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        proID: json['id'],
        upc: json['upc'],
        proName: json['foodName'],
        brandName: json['breandName'],
        proImage: json['image'],
        description: json['description'],
        price: json['price'],
        createdDate: json['createdDate'],
      );

  factory ProductModel.fromJsonNutritionix(
          Map<String, dynamic> json, String upc) =>
      ProductModel(
        proID: 000,
        upc: upc,
        proName: json['food_name'],
        brandName: json['brand_name'],
        proImage: json['photo']['thumb'],
        description: json['nf_ingredient_statement'] ?? "",
        price: "0.0",
        createdDate: json['updated_at'],
      );

  Map<String, dynamic> toJson() => {
        "upc": upc,
        "foodName": proName,
        "breandName": brandName,
        "image": proImage,
        "description": description,
      };

  factory ProductModel.fromRawJson(String str) =>
      ProductModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());
}

   

// 49000000450
// 076410901473