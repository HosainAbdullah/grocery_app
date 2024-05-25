import 'package:dartz/dartz.dart';
import 'package:grocery_app/core/error/failure.dart';
import 'package:grocery_app/features/cart/data/model/cart.dart';

abstract class BaseCartRepository {
  Future<Either<Failure, List<CartItem>>> getCartItem();

  Future<Either<Failure, bool>> deleteOneItem({
    required CartItem cartIte,
  });
  Future<Either<Failure, bool>> saveCartItem({
    required List<CartItem> cartItem,
  });
  Future<Either<Failure, bool>> deleteAllItem();
}
