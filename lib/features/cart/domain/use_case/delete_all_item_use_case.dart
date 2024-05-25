import 'package:dartz/dartz.dart';
import 'package:grocery_app/core/error/failure.dart';
import 'package:grocery_app/features/cart/domain/repository/base_cart_repository.dart';

class DeleteAllItemUseCase {
  final BaseCartRepository baseCartRepository;

  DeleteAllItemUseCase({
    required this.baseCartRepository,
  });
  Future<Either<Failure, bool>> call() async {
    return await baseCartRepository.deleteAllItem();
  }
}
