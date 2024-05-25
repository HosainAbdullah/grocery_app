import 'package:equatable/equatable.dart';
import 'package:grocery_app/features/product/domain/entities/product_entities.dart';

class ProductPageEntities extends Equatable {
  final int count;
  final String? next;
  final String? previous;
  final List<ProductEntities> productList;

  const ProductPageEntities({
    required this.count,
    required this.next,
    required this.previous,
    required this.productList,
  });

  @override
  List<Object?> get props => [count, next, previous, productList];

  ProductPageEntities copyWith({
    int? count,
    String? next,
    String? previous,
    List<ProductEntities>? productList,
  }) {
    return ProductPageEntities(
      count: count ?? this.count,
      next: next ?? this.next,
      previous: previous ?? this.previous,
      productList: productList ?? this.productList,
    );
  }
}
