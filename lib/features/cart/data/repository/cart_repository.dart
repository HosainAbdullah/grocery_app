import 'package:dartz/dartz.dart';
import 'package:grocery_app/core/error/exceptions.dart';
import 'package:grocery_app/core/error/failure.dart';
import 'package:grocery_app/features/cart/data/data_source/cart_local_data_source.dart';
import 'package:grocery_app/features/cart/data/model/cart.dart';
import 'package:grocery_app/features/cart/domain/repository/base_cart_repository.dart';

class CartRepository implements BaseCartRepository {
  final BaseCartLocalDataSource cartLocalStorage;

  CartRepository({
    required this.cartLocalStorage,
  });

  @override
  Future<Either<Failure, List<CartItem>>> getCartItem() async {
    try {
      final result = await cartLocalStorage.selectCartItem();
      return Right(result);
    } on EmptyCacheException {
      return const Left(EmptyCacheFailure(message: "Not data local"));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteOneItem(
      {required CartItem cartIte}) async {
    try {
      final result = await cartLocalStorage.removeCartItem(cartItem: cartIte);
      if (result) {
        return Right(result);
      } else {
        return const Left(EmptyCacheFailure(message: "The Item Not Find"));
      }
    } on EmptyCacheException {
      return const Left(EmptyCacheFailure(message: "Not data local"));
    }
  }

  @override
  Future<Either<Failure, bool>> saveCartItem(
      {required List<CartItem> cartItem}) async {
    try {
      final result = await cartLocalStorage.saveCartItem(cartItem: cartItem);
      if (result) {
        return Right(result);
      } else {
        return const Left(EmptyCacheFailure(message: "No Save Data"));
      }
    } on EmptyCacheException {
      return const Left(EmptyCacheFailure(message: "Not data local"));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteAllItem() async {
    try {
      final result = await cartLocalStorage.deleteAllItem();
      if (result) {
        return Right(result);
      } else {
        return const Left(EmptyCacheFailure(message: "No delete Data"));
      }
    } on EmptyCacheException {
      return const Left(EmptyCacheFailure(message: "Not data local"));
    }
  }
}
