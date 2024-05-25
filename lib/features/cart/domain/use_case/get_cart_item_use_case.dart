import 'package:dartz/dartz.dart';
import 'package:grocery_app/core/error/failure.dart';
import 'package:grocery_app/features/cart/data/model/cart.dart';
import 'package:grocery_app/features/cart/domain/repository/base_cart_repository.dart';

class GetCartItemUseCase {
  final BaseCartRepository baseCartRepository;

  GetCartItemUseCase({
    required this.baseCartRepository,
  });
  Future<Either<Failure, List<CartItem>>> call() async {
    return await baseCartRepository.getCartItem();
  }
}
