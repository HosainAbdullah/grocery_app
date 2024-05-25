import 'package:dartz/dartz.dart';
import 'package:grocery_app/core/error/failure.dart';
import 'package:grocery_app/features/product/domain/entities/product_page_entities.dart';
import 'package:grocery_app/features/product/domain/repository/base_product_repository.dart';

class GetAllProductUseCase {
  final BaseProductRepository baseProductRepository;

  GetAllProductUseCase({required this.baseProductRepository});
  Future<Either<Failure, ProductPageEntities>> call() async {
    return await baseProductRepository.getAllProduct();
  }
}
