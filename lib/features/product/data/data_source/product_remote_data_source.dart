import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:grocery_app/core/extension/path_api_page.dart';
import 'package:grocery_app/features/product/data/model/product_model.dart';
import 'package:grocery_app/features/product/data/model/product_page_model.dart';

abstract class BaseProductRemoteDataSource {
  Future<ProductModel> selectDataProduct({
    required String upc,
  });
  Future<Unit> createProduct({required ProductModel product});

  Future<ProductPageModel> selectAllProduct();
}

class ProductRemoteDataSource implements BaseProductRemoteDataSource {
  final Dio dio;
  final String searchItemPath = PathServerPage.searchItem.rawValue;
  final String allProductPath = PathServerPage.allProduct.rawValue;

  ProductRemoteDataSource({
    required this.dio,
  });

  @override
  Future<ProductModel> selectDataProduct({required String upc}) async {
    final response = await dio.get(ServerSittings.linkServer + searchItemPath,
        queryParameters: {"upc": upc},
        options: Options(
          headers: {
            "x-app-key": "0a2b7ffc429bd0fc56e428efbd329de9",
            "x-app-id": "e32e3eb3",
          },
        ));
    if (response.statusCode == HttpStatus.created ||
        response.statusCode == HttpStatus.ok) {
      final data = response.data;
      log(data.toString());
      return ProductModel.fromJsonNutritionix(data['foods'][0], upc);
    } else {
      throw Exception('error');
    }
  }

  @override
  Future<ProductPageModel> selectAllProduct() async {
    final response = await dio.get(
      ServerSittings.linkServerMe + allProductPath,
    );
    if (response.statusCode == HttpStatus.created ||
        response.statusCode == HttpStatus.ok) {
      final data = response.data as Map<String, dynamic>;
      log(data.toString());
      return ProductPageModel.fromJson(data);
    } else {
      throw Exception('error');
    }
  }

  @override
  Future<Unit> createProduct({required ProductModel product}) async {
    final response = await dio.post(
        ServerSittings.linkServerMe + allProductPath,
        data: product.toJson());
    if (response.statusCode == HttpStatus.created ||
        response.statusCode == HttpStatus.ok) {
      final data = response.data as Map<String, dynamic>;
      log(data.toString());
      return unit;
    } else {
      throw Exception('error');
    }
  }
}
