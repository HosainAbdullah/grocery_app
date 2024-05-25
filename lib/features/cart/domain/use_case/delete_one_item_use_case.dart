import 'package:dartz/dartz.dart';
import 'package:grocery_app/core/error/failure.dart';
import 'package:grocery_app/features/cart/data/model/cart.dart';
import 'package:grocery_app/features/cart/domain/repository/base_cart_repository.dart';

class DeleteOneItemUseCase {
  final BaseCartRepository baseCartRepository;

  DeleteOneItemUseCase({
    required this.baseCartRepository,
  });
  Future<Either<Failure, bool>> call({
    required CartItem cartItem,
  }) async {
    return await baseCartRepository.deleteOneItem(cartIte: cartItem);
  }
}
