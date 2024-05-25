import 'package:grocery_app/features/product/data/model/product_model.dart';
import 'package:grocery_app/features/product/domain/entities/product_page_entities.dart';

class ProductPageModel extends ProductPageEntities {
  const ProductPageModel({
    required super.count,
    required super.next,
    required super.previous,
    required super.productList,
  });

  factory ProductPageModel.fromJson(Map<String, dynamic> json) =>
      ProductPageModel(
        count: json['count'],
        next: json['next'],
        previous: json['previous'],
        productList: List<ProductModel>.from(
          json["results"].map(
            (x) => ProductModel.fromJson(x),
          ),
        ),
      );
}
