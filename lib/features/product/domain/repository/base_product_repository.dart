import 'package:dartz/dartz.dart';
import 'package:grocery_app/core/error/failure.dart';
import 'package:grocery_app/features/product/domain/entities/product_entities.dart';
import 'package:grocery_app/features/product/domain/entities/product_page_entities.dart';

abstract class BaseProductRepository {
  Future<Either<Failure, ProductEntities>> getDataProduct({
    required String upc,
  });
  Future<Either<Failure, ProductPageEntities>> getAllProduct();
  Future<Either<Failure, Unit>> addProduct({required ProductEntities product});
}
