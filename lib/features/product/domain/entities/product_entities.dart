import 'package:equatable/equatable.dart';

class ProductEntities extends Equatable {
  final int proID;
  final String upc;
  final String proName;
  final String brandName;
  final String description;
  final String proImage;
  final String price;
  final String createdDate;

  const ProductEntities({
    required this.proID,
    required this.upc,
    required this.proName,
    required this.proImage,
    required this.brandName,
    required this.description,
    required this.price,
    required this.createdDate,
  });

  @override
  List<Object> get props => [
        proID,
        upc,
        proName,
        proImage,
        brandName,
        description,
        price,
        createdDate,
      ];

  ProductEntities copyWith({
    int? proID,
    String? upc,
    String? proName,
    String? proImage,
    String? brandName,
    String? description,
    String? price,
    String? createdDate,
  }) {
    return ProductEntities(
      proID: proID ?? this.proID,
      upc: upc ?? this.upc,
      proName: proName ?? this.proName,
      proImage: proImage ?? this.proImage,
      brandName: proImage ?? this.brandName,
      description: description ?? this.description,
      price: price ?? this.price,
      createdDate: createdDate ?? this.createdDate,
    );
  }
}
