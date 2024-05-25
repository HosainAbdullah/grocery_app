import 'package:dartz/dartz.dart';
import 'package:grocery_app/core/error/failure.dart';
import 'package:grocery_app/features/product/domain/entities/product_entities.dart';
import 'package:grocery_app/features/product/domain/repository/base_product_repository.dart';

class GetDataProductUseCase {
  final BaseProductRepository baseProductRepository;

  GetDataProductUseCase({required this.baseProductRepository});
  Future<Either<Failure, ProductEntities>> call({
    required String upc,
  }) async {
    return await baseProductRepository.getDataProduct(upc: upc);
  }
}
