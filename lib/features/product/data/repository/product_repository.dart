import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:grocery_app/core/error/error_handler_server.dart';
import 'package:grocery_app/core/error/failure.dart';
import 'package:grocery_app/core/error/string_error.dart';
import 'package:grocery_app/core/network/network_info.dart';
import 'package:grocery_app/features/product/data/data_source/product_remote_data_source.dart';
import 'package:grocery_app/features/product/data/model/product_model.dart';
import 'package:grocery_app/features/product/domain/entities/product_entities.dart';
import 'package:grocery_app/features/product/domain/entities/product_page_entities.dart';
import 'package:grocery_app/features/product/domain/repository/base_product_repository.dart';

class ProductRepository implements BaseProductRepository {
  final BaseProductRemoteDataSource productRemoteDataSource;
  final BaseNetworkInfo networkInfo;

  const ProductRepository({
    required this.productRemoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, ProductEntities>> getDataProduct(
      {required String upc}) async {
    if (await networkInfo.isConnected) {
      try {
        final result =
            await productRemoteDataSource.selectDataProduct(upc: upc);
        return Right(result);
      } on DioException catch (error) {
        // log(error.toString());
        return Left(ServerFailure(message: error.response!.data['message']));
      }
    } else {
      return const Left(
          OfflineFailure(message: AppStringsErrorServer.noInternetConnection));
    }
  }

  @override
  Future<Either<Failure, ProductPageEntities>> getAllProduct() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await productRemoteDataSource.selectAllProduct();
        return Right(result);
      } on DioException catch (error) {
        return Left(ErrorHandlerServer.handle(error).failure);
      }
    } else {
      return const Left(
          OfflineFailure(message: AppStringsErrorServer.noInternetConnection));
    }
  }

  @override
  Future<Either<Failure, Unit>> addProduct(
      {required ProductEntities product}) async {
    if (await networkInfo.isConnected) {
      try {
        ProductModel dataProduct = ProductModel(
          proID: product.proID,
          upc: product.upc,
          proName: product.proName,
          proImage: product.proImage,
          brandName: product.brandName,
          description: product.description,
          price: product.price,
          createdDate: product.createdDate,
        );
        final result =
            await productRemoteDataSource.createProduct(product: dataProduct);
        return Right(result);
      } on DioException catch (error) {
        return Left(ErrorHandlerServer.handle(error).failure);
      }
    } else {
      return const Left(
          OfflineFailure(message: AppStringsErrorServer.noInternetConnection));
    }
  }
}
