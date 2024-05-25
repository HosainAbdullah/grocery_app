import 'package:dartz/dartz.dart';
import 'package:grocery_app/core/error/failure.dart';
import 'package:grocery_app/features/product/domain/entities/product_entities.dart';
import 'package:grocery_app/features/product/domain/repository/base_product_repository.dart';

class AddProductUseCase {
  final BaseProductRepository baseProductRepository;

  AddProductUseCase({
    required this.baseProductRepository,
  });
  Future<Either<Failure, Unit>> call({
    required ProductEntities productEntities,
  }) async {
    return await baseProductRepository.addProduct(product: productEntities);
  }
}
